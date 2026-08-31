# Strategic Business Insights & Portfolio Recommendations — FinTrust Lending Co.

**Analyst:** Telukala Snuhith Reddy  
**Scope:** 32,416 historical loan records (`data/cleaned/credit_risk_cleaned.csv`)  
**Methodology Note:** The insights and proposed policy thresholds below are derived from empirical observations and static counterfactual simulations within this historical dataset. They represent analytical proposals for credit risk committee review rather than validated institutional underwriting policies.

---

### Insight 1 — The Portfolio Shows Elevated Observed Default Risk

**Observation:**  
FinTrust's overall observed default rate is **21.87%**, with 7,089 defaults recorded among 32,416 historical loan records.

**Evidence:**  
Of 32,416 historical loans analysed, 7,089 are recorded as defaults, representing **$76.97 million** in defaulted principal exposure under the project's zero-recovery analytical assumption. For contextual reference, CareEdge Ratings reported GNPA of 5.4% for the Indian NBFC-MFI sector as of March 2025 and projected approximately 3.6% by March 2026. This comparison is directional only because GNPA is an asset-quality/delinquency measure, whereas `loan_status` represents a binary historical default outcome.

**Business Impact:**  
Under the project's simplified assumptions, estimated first-year simple interest from non-defaulted loans is $25.00 million, compared with $76.97 million of defaulted principal exposure. This produces a simplified exposure–interest difference of approximately **-$51.96 million**. This figure is an analytical proxy rather than an observed accounting loss, profitability measure, or cohort-level financial result.

**Recommendation:**  
Conduct a portfolio-wide credit risk review focused on the strongest observed risk signals identified in this analysis, including loan grade, prior default history, loan-to-income ratio, and high-risk composite flags. Any production policy changes should be validated using out-of-sample or temporal data before implementation.

---

### Insight 2 — Grades F and G Show Extremely High Observed Default Rates

**Observation:**  
Observed default rates reach **70.54%** for Grade F ($n = 241$; 170 defaults) and **98.44%** for Grade G ($n = 64$; 63 defaults).

**Evidence:**  
- **Grade G:** $1,098,925 in defaulted principal vs. $307 in estimated first-year interest (Net proxy: -$1,098,618).
- **Grade F:** $2,496,875 in defaulted principal vs. $195,206 in estimated first-year interest (Net proxy: -$2,301,669).

**Business Impact:**  
Grades F and G have very high observed default rates and negative simplified exposure–interest balances under the project's one-year, zero-recovery assumptions. However, the historical data cannot establish that these observed defaults would have been prevented by excluding the grades, nor can it determine whether alternative pricing, collateral, or underwriting controls would produce acceptable risk-adjusted returns.

**Recommendation:**  
Evaluate Grade G for enhanced underwriting restrictions or exclusion in future policy simulations, and conduct a separate pricing and risk review for Grade F. Any proposed cutoff should be assessed using expected-loss modelling, recovery assumptions, affordability constraints, regulatory requirements, and out-of-sample validation rather than historical default rates alone.

---

### Insight 3 — Prior Default History is a Strong Observed Risk Signal

**Observation:**  
Borrowers with a prior default on file have an observed default rate of **37.87%** (2,170 defaults / 5,730 loans), compared with **18.43%** (4,919 defaults / 26,686 loans) for borrowers without a prior default flag, corresponding to an observed risk ratio of approximately **2.05×**.

**Evidence:**  
Of 32,416 historical loan records, 5,730 have `cb_person_default_on_file = 'Y'`. Across this cohort, total defaulted principal exposure reaches **$23.67 million** ($23,665,325 across 2,170 defaulted loans). This analysis demonstrates empirical association within the dataset, not predictive superiority or causation.

**Business Impact:**  
The prior-default group represents a materially higher observed-risk segment. The analysis therefore supports treating prior default history as a candidate enhanced-review signal. The historical dataset does not contain sufficient evidence to claim that imposing a Grade C minimum would reduce the future portfolio default rate by a specific percentage.

**Recommendation:**  
Evaluate `cb_person_default_on_file = 'Y'` as an enhanced-review trigger. Candidate policies such as minimum grade requirements or tighter affordability thresholds should be tested through out-of-sample policy simulations and reviewed for regulatory and fair-lending implications before production adoption.

---

### Insight 4 — Debt Consolidation Loans Show Elevated Observed Default Risk

**Observation:**  
**Debt Consolidation** (28.68%; 1,488 defaults / 5,189 loans) and **Medical** (26.76%; 1,617 defaults / 6,042 loans) loan intents exhibit observed default rates meaningfully above the portfolio baseline of 21.87%.

**Evidence:**  
Debt Consolidation represents 5,189 loans and 1,488 defaults. Debt Consolidation shows an elevated observed default rate in this portfolio and therefore warrants additional affordability review.

**Business Impact & Recommendation:**  
Consider purpose-specific underwriting filters, such as requiring verified debt payoff mechanisms or tighter LTI thresholds for debt consolidation applicants, subject to policy simulation and fair-lending review.

---

### Insight 5 — 35% LTI Serves as an Empirical Leverage Risk Boundary

**Observation:**  
Observed default rates surge from **18.28%** for borrowers with $\text{LTI} \le 35\%$ ($n = 30,248$; 5,529 defaults) to **71.96%** for borrowers with $\text{LTI} > 35\%$ ($n = 2,168$; 1,560 defaults) ($Z = 58.41, p < 0.001$).

**Evidence:**  
Borrowers in the High (35–49%) and Critical ($\ge 50\%$) leverage tiers account for $24.96 million in defaulted principal exposure.

**Proposed Underwriting Consideration:**  
Consider evaluating 35% LTI as a candidate threshold for mandatory manual review and enhanced income verification, while evaluating tighter exposure limits for applicants above 40% LTI.

---

### Insight 6 — Grade D Represents the Largest Observed Defaulted Principal Exposure

**Observation:**  
Despite not having the highest default rate, **Grade D has the largest observed defaulted principal exposure in the portfolio at approximately $22.78 million** across 2,138 defaulted loans (out of 3,620 total Grade D loans).

**Evidence:**  
Grade D has an observed default rate of 59.06%, below Grades E, F, and G, but its larger number of loans results in the highest observed defaulted principal exposure at approximately $22.78 million. This represents roughly 29.6% of the portfolio's $76.97 million defaulted principal exposure.

**Recommendation:**  
Evaluate exposure controls for Grade D, particularly for higher-balance applications. Candidate measures such as collateral requirements, guarantors, affordability limits, or portfolio concentration caps should be evaluated through policy simulations and validated against expected-loss and operational considerations before implementation.

---

### Insight 7 — Composite Risk Flag Provides In-Sample Separation of Elevated Risk Segments

**Observation:**  
Historical records classified as High Risk by the composite flag (`Grade ∈ {E,F,G}` OR `loan_percent_income > 0.40` OR `cb_person_default_on_file = 'Y'`) have an observed default rate of **44.45%** ($n = 7,228$; 3,213 defaults), compared with **15.39%** for records classified as Normal ($n = 25,188$; 3,876 defaults), corresponding to an observed risk ratio of approximately **2.89×**.

**Evidence & In-Sample Counterfactual Scenario:**  
In a static in-sample exclusion scenario where all 7,228 flagged loans were excluded:
- The remaining historical cohort would have an observed default rate of **15.39%** (down from 21.87%).
- **Observed Defaulted Principal Exposure in Excluded Group:** **$39,427,075** (~$39.43M across 3,213 defaults).
- **Estimated First-Year Simple Interest on Non-Defaulted Loans in Excluded Group:** **$5,880,774** (~$5.88M across 4,015 non-defaulted loans).
- **Simplified In-Sample Exposure–Interest Difference:** **+$33,546,301** (~**+$33.55 million** under static, zero-recovery assumptions).

*Note: These scenario calculations are illustrative static in-sample models. They do not demonstrate that historical defaults would have been prevented and do not account for customer acquisition costs, potential borrower behavioral changes, or macroeconomic shifts.*

**Recommendation:**  
Evaluate the composite risk flag as an analytical early-warning triage tool. Applications triggering the flag could be considered for enhanced review, subject to threshold validation, operational testing, fairness review, and out-of-sample performance assessment before production deployment.

---

### Insight 8 — The Portfolio Shows a -$51.96M Simplified Exposure–Interest Difference

**Observation:**  
Estimated first-year simple interest on non-defaulted loans is approximately **$25.00 million**, while defaulted principal exposure is approximately **$76.97 million**. Under the project's simplified one-year simple-interest and zero-recovery assumptions, the resulting exposure–interest difference is approximately **-$51.96 million**.

**Evidence:**  
The simplified calculation compares estimated first-year simple interest from non-defaulted loans with defaulted principal exposure. It does not represent accounting profit, lifetime loan profitability, expected loss, or realized economic loss. The calculation is intended as a portfolio-risk scenario proxy under explicit zero-recovery assumptions.

**Business Impact:**  
The negative simplified exposure–interest difference indicates that defaulted principal exposure substantially exceeds estimated first-year interest from non-defaulted loans under the project's assumptions. It should be used as an analytical indicator of portfolio risk rather than as evidence of quarterly losses or future financial performance.

**Recommendation:**  
Use the -$51.96 million simplified exposure–interest difference as an illustrative financial-risk indicator alongside observed default rates and exposure concentrations. Any investment or underwriting policy decision should incorporate recovery rates, loan tenure, funding costs, operating expenses, prepayment behaviour, and validated expected-loss estimates that are not available in this dataset.

---

## Summary — Priority Analytical Action Matrix

| Priority | Analytical Action | Evidence / Rationale |
|---|---|---|
| **Immediate** | Review Grade G underwriting | 98.44% observed default rate, based on 64 historical records |
| **Immediate** | Review prior-default applications | 37.87% vs 18.43% observed default rate; approximately 2.05× risk ratio ($23.67M exposure) |
| **30 Days** | Evaluate 35% LTI as a candidate review threshold | 71.96% vs 18.28% observed default rate ($Z = 58.41, p < 0.001$) |
| **30 Days** | Review high-risk loan purposes | Debt Consolidation (28.68%) and Medical (26.76%) show elevated observed default rates |
| **60 Days** | Evaluate Grade D exposure controls | Largest observed defaulted principal exposure at approximately $22.78M |
| **60 Days** | Validate composite risk flag | 44.45% vs 15.39% observed default rate; approximately 2.89× risk ratio |
| **90 Days** | Conduct pricing and expected-loss analysis by grade | Historical simple-interest proxy alone is insufficient for production pricing decisions |
