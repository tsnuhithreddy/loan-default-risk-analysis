# Statistical Validation Findings — FinTrust Lending Co.

**Analyst:** Telukala Snuhith Reddy  
**Dataset:** 32,416 historical loan records (`data/cleaned/credit_risk_cleaned.csv`)  
**Methodology Note:** This report summarizes the formal hypothesis tests conducted to evaluate whether observed exploratory patterns represent statistically significant in-sample associations rather than random sampling fluctuations.

---

## Finding 1 — Loan Grade is Significantly Associated with Default (Chi-Square Test)

A Pearson Chi-Square test of independence was performed to assess the relationship between loan grade and loan outcome (`loan_status`).

- **Chi-Square Statistic ($\chi^2$):** 5,588.33
- **Degrees of Freedom ($df$):** 6
- **P-Value:** $< 0.001$

**Interpretation:** Default status is statistically dependent on loan grade at the $\alpha = 0.001$ level. This confirms that the observed monotonic escalation in default rates from Grade A (9.96%) through Grade G (98.44%) represents a statistically significant association within this dataset.

---

## Finding 2 — 35% DTI Split Demonstrates Statistically Significant Risk Separation (Two-Proportion Z-Test)

A two-proportion hypothesis test was conducted comparing default proportions between borrowers above and below the 35% Loan-to-Income (DTI) threshold.

- **$\le$35% DTI Default Rate:** 18.28% ($n = 30,248$; 5,530 defaults)
- **>35% DTI Default Rate:** 71.96% ($n = 2,168$; 1,559 defaults)
- **Absolute Risk Difference:** 53.68 percentage points
- **95% Confidence Interval for Difference:** [51.78%, 55.58%]
- **Risk Ratio:** $3.94\times$
- **Z-Statistic:** 58.41
- **P-Value:** $< 0.001$

**Interpretation:** Borrowers with a DTI ratio exceeding 35% default at nearly $4\times$ the rate of borrowers at or below 35%. The difference is statistically significant ($p < 0.001$). This empirical separation supports designating 35% DTI as a primary candidate threshold for mandatory manual underwriting review.

> **Grouping Note:** An exploratory 4-tier breakdown reported 69.87% default for the 35–49% tier and 78.43% for $\ge$50%. The 71.96% figure represents the aggregated pool of all loans with DTI $> 35\%$, formally evaluated by this test.

---

## Finding 3 — Composite Risk Flag Achieves Statistically Significant Risk Segmentation (Two-Proportion Z-Test)

A two-proportion test was conducted evaluating the composite analytical risk flag (`Grade ∈ {E,F,G}` OR `DTI > 40%` OR `Prior Default = 'Y'`).

- **High Risk Flagged Default Rate:** 44.45% ($n = 7,228$; 3,213 defaults)
- **Normal Segment Default Rate:** 15.39% ($n = 25,188$; 3,876 defaults)
- **Absolute Risk Difference:** 29.06 percentage points
- **95% Confidence Interval for Difference:** [27.83%, 30.29%]
- **Risk Ratio:** $2.89\times$
- **Z-Statistic:** 52.69
- **P-Value:** $< 0.001$

**Interpretation:** The composite risk flag identifies an empirical high-risk cohort defaulting at nearly $3\times$ the baseline rate of the remaining portfolio ($p < 0.001$).

**Statistical vs. Production Caveat:** While statistical significance confirms strong in-sample association, production deployment as an automated underwriting gate requires out-of-sample (temporal/vintage) validation, threshold sensitivity modeling, and fair-lending disparate impact assessments.

---

## Finding 4 — Financial Exposure Reconciliation

- **Gross Principal Exposure from Defaulted Loans:** **$76,968,675**
- **Estimated First-Year Simple Interest Revenue (Repaid Loans):** **$25,003,819**
- **Net Portfolio Balance (First-Year View):** **-$51,964,856**

*Note: In the absence of loan-tenure fields, revenue reflects a one-year simple interest calculation on non-defaulted loans, providing a conservative annualized baseline comparison against unrecovered defaulted principal.*

---

## Hypothesis Testing Summary Table

| Hypothesis Test | Key Statistic | P-Value | In-Sample Significance |
|---|---|:---:|:---:|
| **Chi-Square:** Loan Grade vs. Default | $\chi^2 = 5,588.33$ ($df=6$) | $< 0.001$ | Statistically Significant |
| **Two-Proportion Z-Test:** DTI $>35\%$ vs. $\le 35\%$ | $Z = 58.41$ ($3.94\times$ Risk Ratio) | $< 0.001$ | Statistically Significant |
| **Two-Proportion Z-Test:** High Risk Flag vs. Normal | $Z = 52.69$ ($2.89\times$ Risk Ratio) | $< 0.001$ | Statistically Significant |

All three core risk indicators demonstrate statistically significant in-sample associations with loan default outcomes within the FinTrust dataset.
