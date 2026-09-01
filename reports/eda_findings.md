# Exploratory Data Analysis (EDA) Findings — FinTrust Lending Co.

**Analyst:** Telukala Snuhith Reddy  
**Dataset:** 32,416 historical loan records (`data/cleaned/credit_risk_cleaned.csv`)  
**Methodology Note:** These findings describe observed historical relationships and bivariate distributions within the dataset; they represent empirical patterns rather than out-of-sample predictive validations.

---

### Finding 1 — Scale of the Portfolio Default Problem

FinTrust's overall observed default rate is **21.87%** (7,089 defaults out of 32,416 loans). For contextual comparison, CareEdge Ratings reported Gross Non-Performing Assets (GNPA) of **5.4% for the Indian NBFC-MFI sector as of March 2025** and projected approximately **3.6% by March 2026**. Because GNPA is a delinquency-based asset-quality measure while `loan_status` represents a binary historical default outcome, the figures are **directional context rather than like-for-like risk benchmarks** and should not be interpreted as directly comparable default rates.

---

### Finding 2 — Grade G Exhibits an Extremely High Observed Default Rate (98.44%)

Grade G shows an extreme concentration of observed defaults, with **63 of 64 loans defaulting (98.44%)**. Within this historical dataset, Grade G represents an extreme risk tier where 63 of 64 loans are recorded as defaults.

---

### Finding 3 — Debt Consolidation and Medical Intents Exhibit the Highest Default Rates

Observed default rates vary significantly across loan intents:
- **Debt Consolidation:** 28.68% (1,488 defaults / 5,189 loans)
- **Medical:** 26.76% (1,617 defaults / 6,042 loans)
- **Home Improvement:** 26.15% (940 defaults / 3,594 loans)
- **Personal:** 19.90% (1,094 defaults / 5,498 loans)
- **Education:** 17.25% (1,106 defaults / 6,411 loans)
- **Venture:** 14.85% (844 defaults / 5,682 loans)

Debt Consolidation and Medical loan applicants show the highest observed default rates among the six recorded loan-intent categories. These differences are empirical associations within the historical dataset and do not by themselves establish the underlying cause of the higher default rates.

---

### Finding 4 — Prior Default History is Strongly Associated with Observed Default (2.05x)

Borrowers with a historical **prior default on file default at 37.87%** (2,170 defaults / 5,730 loans), compared to **18.43%** (4,919 defaults / 26,686 loans) for borrowers with no prior default on record—an observed risk ratio of approximately **2.05×**. Historical credit bureau default status is a strong observed categorical risk indicator in the dataset.

---

### Finding 5 — 35% Loan-to-Income (LTI) Serves as a Meaningful Empirical Risk Differentiator

Observed default rates escalate sharply across Loan-to-Income (LTI) tiers using the source-provided `loan_percent_income` variable:
- **Low (<20% LTI):** 13.43% default rate (2,868 defaults / 21,363 loans)
- **Medium (20–34% LTI):** 29.05% default rate (2,508 defaults / 8,634 loans)
- **High (35–49% LTI):** 69.87% default rate (1,456 defaults / 2,084 loans)
- **Critical (≥50% LTI):** 76.72% default rate (257 defaults / 335 loans)

The sharp increase in observed default rates between the Medium tier (29.05%) and High tier (69.87%) indicates that the 35% LTI boundary is a strong candidate threshold for enhanced manual review, subject to out-of-sample validation.

---

### Finding 6 — Higher Income is Inversely Associated with Observed Default Rate

Default rates show a strong, consistent inverse relationship with borrower income brackets:
- **Low (<$30k):** 47.20% default rate (1,719 defaults / 3,642 loans)
- **Medium ($30k–$60k):** 25.86% default rate (3,605 defaults / 13,940 loans)
- **High ($60k–$100k):** 13.21% default rate (1,358 defaults / 10,283 loans)
- **Very High (≥$100k):** 8.94% default rate (407 defaults / 4,551 loans)

Borrowers earning under $30,000 have an observed default rate of **47.20%**, compared with **8.94%** among borrowers earning at least $100,000—approximately a **5.28× relative risk ratio** based on these observed rates.

---

### Finding 7 — Grade D Represents the Largest Defaulted Principal Exposure ($22.78M)

While Grade G has the highest percentage default rate (98.44%), **Grade D represents the single largest defaulted principal exposure** in the portfolio at **$22,778,600** across **2,138 defaulted loans** (out of 3,620 total Grade D loans). This highlights that portfolio risk management requires monitoring absolute dollar exposure alongside percentage default rates.

---

### Finding 8 — Grades E, F, and G Show Negative First-Year Net Positions

Comparing estimated first-year simple interest revenue from non-defaulted loans against defaulted principal exposure reveals negative net positions across higher-risk tiers:
- **Grade E:** -$7.04M net position ($7.827M defaulted principal exposure vs. $0.785M estimated first-year interest; 64.49% default rate)
- **Grade F:** -$2.30M net position ($2.497M defaulted principal exposure vs. $0.195M estimated first-year interest; 70.54% default rate)
- **Grade G:** -$1.10M net position ($1.099M defaulted principal exposure vs. $307 estimated first-year interest; 98.44% default rate)

Under this simplified single-year exposure proxy, estimated first-year interest income does not offset observed defaulted principal exposure in any loan grade.

---

### Finding 9 — Default Risk Follows a Non-Linear Age Distribution

Default rates do not decrease monotonically with borrower age:
- **Senior borrowers (51+):** 25.35% default rate (73 defaults / 288 loans)
- **Young borrowers (<25):** 23.34% default rate (2,853 defaults / 12,222 loans)
- **Core working-age borrowers (25–50):** Default rates of 20.98% for ages 25–35 (3,511 defaults / 16,734 loans) and 20.55% for ages 36–50 (652 defaults / 3,172 loans)

The observed rates form a U-shaped pattern across the defined age groups, with higher default rates among borrowers under 25 and those aged 51 or above relative to core working-age borrowers. This descriptive pattern does not establish why the differences occur; potential mechanisms would require additional borrower, credit-history, employment, and longitudinal data.

---

### Finding 10 — Composite Risk Flag Demonstrates Strong In-Sample Risk Separation

The composite analytical flag (`loan_grade ∈ {E,F,G}` OR `loan_percent_income > 0.40` OR `cb_person_default_on_file = 'Y'`) separates the portfolio into two distinct empirical performance groups:
- **High Risk Flagged:** 44.45% default rate (3,213 defaults / 7,228 loans)
- **Normal Segment:** 15.39% default rate (3,876 defaults / 25,188 loans)

Within this historical dataset, combining grade, leverage, and bureau history produces strong in-sample risk separation.
