# Statistical Findings

This report summarizes the formal statistical validation performed in
`notebooks/Loan_default_risk_analysis.ipynb`. The exploratory findings in
`eda_findings.md` and `sql_findings.md` describe *what* the patterns in the
data look like; this report confirms *whether those patterns are unlikely to
be due to chance*, using standard hypothesis tests rather than visual
inspection alone.

All figures below were run directly from the cleaned dataset (32,416 rows)
and can be reproduced by running the "Statistical Validation" section of the
notebook.

---

## Finding 1 — Loan grade is significantly associated with default (Chi-square test)

A chi-square test of independence was run on loan grade vs. default status.

- **Chi-square statistic:** 5588.33
- **Degrees of freedom:** 6
- **P-value:** < 0.001

**Interpretation:** Default status is significantly associated with loan
grade. This provides formal statistical support for the pattern observed
throughout the exploratory analysis — default rates differ meaningfully
across FinTrust's seven loan grades, and this is very unlikely to be
explained by random chance.

---

## Finding 2 — The 35% DTI threshold produces a statistically significant risk split (Two-proportion z-test)

- **≤35% DTI default rate:** 18.28% (n = 30,248)
- **>35% DTI default rate:** 71.96% (n = 2,168)
- **Difference:** 53.68 percentage points
- **Risk ratio:** 3.94x
- **Z-statistic:** 58.41
- **P-value:** < 0.001

**Interpretation:** Borrowers above the 35% DTI threshold default at nearly
4x the rate of borrowers below it, and this difference is statistically
significant, not sampling noise. This directly supports enforcing the 35%
DTI ceiling as a hard underwriting rule rather than a soft guideline.

*Note: an earlier internal breakdown using a 4-tier DTI classification
(Low/Medium/High/Critical) reported 69.87% for the 35–49% band specifically,
excluding the 50%+ "Critical" tier. That figure and the 71.96% above are not
in conflict — they describe different groupings of the same underlying data.
The 71.96% figure is the one formally validated by this test and is the
number used in the README and executive summary.*

---

## Finding 3 — The composite risk flag significantly separates high- and low-risk borrowers (Two-proportion z-test)

- **High Risk default rate:** 44.45% (n = 7,228)
- **Normal default rate:** 15.39% (n = 25,188)
- **Risk difference:** 29.06 percentage points
- **95% CI for the difference:** 27.83 to 30.29 percentage points
- **Risk ratio:** 2.89x
- **Z-statistic:** 52.69
- **P-value:** < 0.001

**Interpretation:** FinTrust's composite risk flag (Grade E/F/G, or DTI >
40%, or a prior default on file) identifies a segment that defaults at
nearly 3x the rate of the rest of the portfolio, and the separation is
statistically significant. This supports using the flag as an
**analytical early-warning indicator**.

**Important caveat:** statistical significance confirms the *association* is
real, not that the flag is production-ready. Before deployment as an
approval-workflow gate, the flag would still need: validation on unseen
(out-of-sample) data, threshold optimization, monitoring for stability over
time, and a fairness/disparate-impact assessment. See
`README.md` → *Limitations of This Analysis* for the full list of caveats.

---

## Finding 4 — Financial exposure, reconciled

- Principal exposure from defaulted loans: **$76,968,675**
- Estimated first-year interest revenue from repaid loans: **$25,003,819**
- **Net portfolio position: -$51,964,856**

This uses one year of simple interest as the revenue estimate, since the
dataset has no loan-term field — see the Methodology note in
`reports/executive_summary.md` for why this is a conservative, first-year
view rather than a full loan-lifetime profitability figure.

---

## Summary table

| Test | Result | Significant? |
|---|---|---|
| Chi-square: grade vs. default | χ² = 5588.33, df = 6 | Yes, p < 0.001 |
| Z-test: DTI >35% vs. ≤35% | Z = 58.41, 3.94x risk ratio | Yes, p < 0.001 |
| Z-test: High Risk flag vs. Normal | Z = 52.69, 2.89x risk ratio | Yes, p < 0.001 |

All three core risk signals used elsewhere in this project (loan grade, DTI
threshold, composite risk flag) are statistically validated, not just
visually apparent in a chart.
