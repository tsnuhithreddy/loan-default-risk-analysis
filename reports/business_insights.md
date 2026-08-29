# Strategic Business Insights & Portfolio Recommendations — FinTrust Lending Co.

**Analyst:** Telukala Snuhith Reddy  
**Scope:** 32,416 historical loan records (`data/cleaned/credit_risk_cleaned.csv`)  
**Methodology Note:** The insights and proposed policy thresholds below are derived from empirical observations and static counterfactual simulations within this historical dataset. They represent analytical proposals for credit risk committee review rather than validated institutional underwriting policies.

---

### Insight 1 — Portfolio-Level Imbalance Between Interest Revenue and Default Exposure

**Observation:**  
FinTrust's overall observed default rate is **21.87%** (7,089 defaults across 32,416 loans), representing **$76.97 million** in defaulted principal exposure.

**Evidence:**  
Comparing estimated first-year simple interest revenue from repaid loans ($25.00 million) against defaulted principal exposure ($76.97 million) results in an annualized net portfolio position of **-$51.96 million** under a baseline zero-recovery assumption. For contextual comparison, prime Indian NBFC sector Gross Non-Performing Asset (GNPA) benchmarks typically range between 3.6% and 5.4% (*CareEdge Ratings, 2025; ICRA, 2021*).

**Strategic Consideration:**  
The portfolio's elevated default exposure indicates that nominal interest rate pricing does not compensate for realized loss rates in lower-tier segments. A structured review of approval criteria across high-risk cohorts is warranted.

---

### Insight 2 — Lower Loan Grades (F and G) Generate Severe Negative Net Contributions

**Observation:**  
Observed default rates reach **70.54%** for Grade F ($n = 241$; 170 defaults) and **98.44%** for Grade G ($n = 64$; 63 defaults).

**Evidence:**  
- **Grade G:** $1,098,925 in defaulted principal vs. $307 in estimated first-year interest (Net: -$1,098,618).
- **Grade F:** $2,496,875 in defaulted principal vs. $195,206 in estimated first-year interest (Net: -$2,301,669).

**Proposed Underwriting Consideration:**  
Given the extreme observed default concentration in Grade G (though based on a small sample of $n = 64$), consider evaluating suspension or enhanced underwriting restrictions for this tier. For Grade F, evaluate whether risk-based pricing caps allow for viable risk-adjusted returns or whether tighter entry criteria should be established.

---

### Insight 3 — Prior Bureau Default on File is Strongly Associated with Repeat Default (2.05x)

**Observation:**  
Applicants with a prior default recorded by the credit bureau default at **37.87%** (2,170 defaults / 5,730 loans), compared to **18.43%** (4,919 defaults / 26,686 loans) for applicants with clean records (2.05x risk ratio).

**Evidence:**  
Across 5,730 borrowers with a prior default flag, total defaulted principal reaches $21.70 million. Historical default is one of the strongest bivariate categorical differentiators in the portfolio.

**Proposed Underwriting Consideration:**  
Evaluate routing all applications where `cb_person_default_on_file = 'Y'` to senior manual underwriting review, with candidate prerequisite criteria (e.g., minimum Grade C and LTI $\le 25\%$) rather than automated straight-through processing.

---

### Insight 4 — Debt Consolidation and Medical Loans Exhibit Above-Average Default Rates

**Observation:**  
**Debt Consolidation** (28.68%; 1,488 defaults / 5,189 loans) and **Medical** (26.76%; 1,617 defaults / 6,042 loans) loan intents exhibit default rates meaningfully above the portfolio average of 21.87%.

**Evidence:**  
Debt Consolidation represents 5,189 loans and 1,488 defaults. Borrowers seeking consolidation frequently carry pre-existing debt obligations that may impair cash-flow flexibility.

**Proposed Underwriting Consideration:**  
Consider purpose-specific underwriting filters, such as requiring verified debt payoff mechanisms or lower LTI limits (e.g., $\le 30\%$) for debt consolidation applicants.

---

### Insight 5 — 35% LTI Serves as an Empirical Leverage Risk Boundary

**Observation:**  
Observed default rates surge from **18.28%** for borrowers with $\text{LTI} \le 35\%$ to **71.96%** for borrowers with $\text{LTI} > 35\%$ ($Z = 58.41, p < 0.001$).

**Evidence:**  
Borrowers in the High (35–49%) and Critical ($\ge 50\%$) leverage tiers account for $24.96 million in defaulted principal exposure.

**Proposed Underwriting Consideration:**  
Consider establishing 35% LTI as a candidate threshold for mandatory manual review and enhanced income verification, while evaluating tighter exposure limits for applicants above 40% LTI.

---

### Insight 6 — Grade D Represents the Largest Dollar Default Exposure ($22.78M)

**Observation:**  
While Grade G exhibits the highest percentage default rate, **Grade D accounts for the single largest defaulted principal exposure** in the portfolio ($22.78 million across 2,138 defaulted loans out of 3,620 total Grade D loans).

**Evidence:**  
Grade D represents a large approval volume (3,620 loans; $39.30M volume) combined with an elevated default rate (59.06%).

**Proposed Underwriting Consideration:**  
Focus exposure-management strategies on Grade D by evaluating loan-size caps, co-borrower requirements, or stricter affordability checks on larger Grade D loan amounts.

---

### Insight 7 — Composite Risk Flag Provides In-Sample Separation of Elevated Risk Segments

**Observation:**  
The composite analytical flag (`Grade ∈ {E,F,G}` OR `loan_percent_income > 0.40` OR `cb_person_default_on_file = 'Y'`) segments applicants into a **44.45% default cohort** ($n = 7,228$; 3,213 defaults) vs. a **15.39% normal cohort** ($n = 25,188$; 3,876 defaults).

**Evidence & Counterfactual Simulation:**  
In a static, in-sample counterfactual scenario where all 7,228 flagged loans were excluded:
- If all flagged loans were excluded, the remaining historical cohort would have an observed default rate of **15.39%** (down from 21.87%).
- **Gross Defaulted Principal Avoided:** **$39,427,075** (~$39.43M across 3,213 defaults).
- **Estimated First-Year Interest Income Forgone:** **$5,880,774** (~$5.88M across 4,015 non-defaulted loans).
- **Net Simplified In-Sample Difference:** **+$33,546,301** (~**+$33.55 million** under static, zero-recovery assumptions).

*Note: This counterfactual simulation does not account for customer acquisition costs, potential behavioral shifts, or out-of-sample portfolio dynamics.*

**Proposed Underwriting Consideration:**  
Use the composite flag as an analytical prioritization tool to route high-risk applications to manual credit review queues.

---

## Analytical Recommendations Matrix (For Credit Committee Review)

| Area | Proposed Action | Analytical Rationale |
|---|---|---|
| **Grade G Tier** | Evaluate suspension or enhanced restrictions for Grade G approvals | 98.44% observed default rate ($n=64$); -$1.10M net margin contribution |
| **Prior Default** | Require senior underwriter review for `Prior Default = 'Y'` | 2.05x risk ratio; 37.87% observed default rate |
| **LTI Ceiling** | Designate 35% LTI as candidate review threshold | Sharp empirical risk escalation (71.96% vs. 18.28%) |
| **Debt Consolidation** | Apply stricter leverage limits on debt refinancing loans | 28.68% default rate indicates pre-existing borrower distress |
| **Grade D Exposure** | Evaluate exposure limits / co-signer policies on Grade D | Accounts for largest absolute default exposure ($22.78M) |
| **Early Warning Flag** | Implement composite flag as review triage trigger | Isolates 44.45% default cohort; shows a +$33.55M simplified static in-sample difference under the exclusion scenario |
