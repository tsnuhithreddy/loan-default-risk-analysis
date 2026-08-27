# Exploratory Data Analysis (EDA) Findings — FinTrust Lending Co.

**Analyst:** Telukala Snuhith Reddy  
**Dataset:** 32,416 historical loan records (`data/cleaned/credit_risk_cleaned.csv`)  
**Methodology Note:** These findings describe observed historical relationships and bivariate distributions within the dataset; they represent empirical patterns rather than out-of-sample predictive validations.

---

### Finding 1 — Scale of the Portfolio Default Problem

FinTrust's overall observed default rate is **21.87%** (7,089 defaults out of 32,416 loans), which sits substantially above typical prime NBFC benchmark ranges (3.6%–5.4% Gross NPA). This establishes that elevated default risk is present across broad segments of the historical portfolio.

---

### Finding 2 — Grade G Exhibits Extreme Default Concentration (98.44%)

Grade G loans exhibit an observed default rate of **98.44%** (63 out of 64 loans defaulted). Within this historical dataset, Grade G represents an extreme risk concentration where approved loans resulted in near-complete principal default.

---

### Finding 3 — Debt Consolidation Carries the Highest Purpose-Level Risk

Borrowers seeking loans for **Debt Consolidation** exhibit the highest observed default rate among all loan intents at **28.68%** (1,496 defaults / 5,217 loans), followed by Medical expenses (**26.70%**). This suggests that borrowers seeking to refinance existing obligations may already be under elevated financial stress.

---

### Finding 4 — Prior Default History is Strongly Associated with Repeat Default (2.05x)

Borrowers with a historical **prior default on file default at 37.87%**, compared to **18.43%** for borrowers with no prior default on record—a **2.05x risk ratio**. Historical credit bureau default status is the single strongest bivariate categorical differentiator in the dataset.

---

### Finding 5 — 35% DTI Serves as a Meaningful Empirical Risk Differentiator

Observed default rates escalate sharply across Debt-to-Income (DTI) tiers:
- **Low (<20% DTI):** 12.87% default rate
- **Medium (20–34% DTI):** 21.68% default rate
- **High (35–49% DTI):** 69.87% default rate
- **Critical (≥50% DTI):** 78.43% default rate

The empirical step-change between sub-35% (18.28% overall) and >35% DTI (71.96% overall) indicates that 35% DTI is a strong candidate threshold for enhanced manual review.

---

### Finding 6 — Higher Income is Inversely Associated with Observed Default Rate

Default rates show an inverse relationship with borrower income brackets:
- **Low (<$30k):** 33.41% default rate
- **Medium ($30k–$60k):** 24.32% default rate
- **High ($60k–$100k):** 16.59% default rate
- **Very High (≥$100k):** 11.23% default rate

Borrowers earning under $30,000 exhibit approximately 3x the default rate of borrowers earning above $100,000.

---

### Finding 7 — Grade D Generates the Largest Absolute Financial Exposure ($22.78M)

While Grade G has the highest percentage default rate (98.44%), **Grade D represents the single largest absolute dollar loss** in the portfolio at **$22,778,600** across 2,143 defaulted loans. This highlights that portfolio risk management requires monitoring absolute dollar exposure alongside percentage default rates.

---

### Finding 8 — Grades E, F, and G Generate Negative First-Year Net Margins

Comparing first-year simple interest revenue from repaid loans against defaulted principal exposure reveals negative net positions across higher-risk tiers:
- **Grade E:** -$11.39M net position (64.49% default rate)
- **Grade F:** -$2.30M net position (70.54% default rate)
- **Grade G:** -$1.10M net position (98.44% default rate)

In these grades, stated interest rate premiums do not offset observed principal losses.

---

### Finding 9 — Default Risk Follows a Non-Linear Age Distribution

Default rates do not decrease monotonically with borrower age:
- **Senior borrowers (50+):** 25.35% default rate
- **Young borrowers (<25):** 23.34% default rate
- **Core working-age borrowers (25–50):** 20.55%–20.98% default rate

This U-shaped empirical pattern suggests differing underlying risk dynamics at the age boundaries (e.g., thin credit files for younger applicants vs. potential income constraints for senior applicants).

---

### Finding 10 — Composite Risk Flag Demonstrates Strong In-Sample Risk Separation

The composite analytical flag (`loan_grade ∈ {E,F,G}` OR `DTI > 40%` OR `prior_default = 'Y'`) separates the portfolio into two distinct empirical performance groups:
- **High Risk Flagged:** 44.45% default rate ($n = 7,228$)
- **Normal Segment:** 15.39% default rate ($n = 25,188$)

This confirms that combining grade, leverage, and bureau history provides strong in-sample risk segmentation.
