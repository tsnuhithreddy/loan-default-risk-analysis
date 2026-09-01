# Statistical Validation Findings — FinTrust Lending Co.

**Analyst:** Telukala Snuhith Reddy  
**Dataset:** 32,416 historical loan records (`data/cleaned/credit_risk_cleaned.csv`)  
**Methodology Note:** This report summarizes formal hypothesis tests used to assess whether selected differences and associations observed in the historical portfolio are statistically distinguishable from the null hypotheses under the assumptions of the respective tests. Results are in-sample and should not be interpreted as evidence of causality or validated out-of-sample predictive performance.

---

## Finding 1 — Loan Grade is Significantly Associated with Default (Chi-Square Test)

A Pearson Chi-Square test of independence was performed to assess the relationship between loan grade and loan outcome (`loan_status`).

- **Chi-Square Statistic ($\chi^2$):** 5,588.33
- **Degrees of Freedom ($df$):** 6
- **P-Value:** $< 0.001$

**Interpretation:** The chi-square test provides strong evidence that default status is associated with loan grade at the $\alpha = 0.001$ level. The descriptive results also show a monotonic increase in observed default rates from Grade A (9.96%) through Grade G (98.44%). The chi-square test establishes statistically significant association, but does not by itself test the monotonic trend.

---

## Finding 2 — 35% Loan-to-Income (LTI) Split Demonstrates Statistically Significant Risk Separation (Two-Proportion Z-Test)

A two-proportion hypothesis test was conducted comparing default proportions between borrowers above and at or below the 35% Loan-to-Income ratio threshold (`loan_percent_income`).

- **$\le$35% LTI Default Rate:** 18.28% ($n = 30,248$; 5,529 defaults)
- **>35% LTI Default Rate:** 71.96% ($n = 2,168$; 1,560 defaults)
- **Absolute Risk Difference:** 53.68 percentage points
- **95% Confidence Interval for Difference:** [51.74%, 55.62%]
- **Risk Ratio:** $3.94\times$
- **Z-Statistic:** 58.41
- **P-Value:** $< 0.001$

**Interpretation:** Borrowers with a loan-to-income ratio (`loan_percent_income`) exceeding 35% default at nearly $4\times$ the rate of borrowers at or below 35%. The difference is statistically significant ($p < 0.001$). This empirical separation supports evaluating 35% LTI as a primary candidate threshold for enhanced or manual underwriting review, subject to out-of-sample validation and business-policy assessment.

> **Grouping Note:** An exploratory 4-tier breakdown reported 69.87% default for the 35–49% leverage tier and 76.72% for $\ge$50%. The 71.96% figure represents the aggregated pool of all loans with LTI $> 35\%$, formally evaluated by this test.

---

## Finding 3 — Composite Risk Flag Achieves Statistically Significant Risk Segmentation (Two-Proportion Z-Test)

A two-proportion test was conducted evaluating the composite analytical risk flag (`loan_grade ∈ {E,F,G}` OR `loan_percent_income > 0.40` OR `cb_person_default_on_file = 'Y'`).

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
- **Estimated First-Year Simple Interest on Non-Defaulted Loans:** **$25,003,819**
- **Simplified Exposure–Interest Difference (One-Year Simple-Interest Proxy):** **-$51,964,856**

*Note: In the absence of loan-tenure fields, interest reflects a one-year simple interest calculation on non-defaulted loans, providing a conservative annualized baseline comparison against unrecovered defaulted principal.*

---

## Hypothesis Testing Summary Table

| Hypothesis Test | Key Statistic | P-Value | In-Sample Significance |
|---|---|:---:|:---:|
| **Chi-Square:** Loan Grade vs. Default | $\chi^2 = 5,588.33$ ($df=6$) | $< 0.001$ | Statistically Significant |
| **Two-Proportion Z-Test:** LTI $>35\%$ vs. $\le 35\%$ | $Z = 58.41$ ($3.94\times$ Risk Ratio) | $< 0.001$ | Statistically Significant |
| **Two-Proportion Z-Test:** High Risk Flag vs. Normal | $Z = 52.69$ ($2.89\times$ Risk Ratio) | $< 0.001$ | Statistically Significant |

All three tested relationships demonstrate statistically significant in-sample associations with observed loan default outcomes within the FinTrust dataset. These results establish historical association, not causal effects or validated out-of-sample predictive performance.
