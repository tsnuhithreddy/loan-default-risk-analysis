# Strategic Business Insights & Portfolio Recommendations — FinTrust Lending Co.

**Analyst:** Telukala Snuhith Reddy  
**Scope:** 32,416 historical loan records  
**Methodology Note:** The insights and proposed policy thresholds below are derived from empirical observations and static counterfactual simulations within this historical dataset. They represent analytical proposals for credit risk committee review rather than validated institutional underwriting policies.

---

### Insight 1 — Portfolio-Level Imbalance Between Interest Revenue and Default Exposure

**Observation:**  
FinTrust's overall observed default rate is **21.87%** (7,089 defaults across 32,416 loans), representing **$76.97 million** in defaulted principal exposure.

**Evidence:**  
Comparing estimated first-year simple interest revenue from repaid loans ($25.00 million) against defaulted principal exposure ($76.97 million) results in an annualized net portfolio position of **-$51.96 million** under a baseline zero-recovery assumption. Prime NBFC sector gross NPA benchmarks typically range between 3.6% and 5.4% (CareEdge Ratings, 2025).

**Strategic Consideration:**  
The portfolio's elevated default exposure indicates that nominal interest rate pricing does not compensate for realized loss rates in lower-tier segments. A structured review of approval criteria across high-risk cohorts is warranted.

---

### Insight 2 — Lower Loan Grades (F and G) Generate Severe Negative Net Contributions

**Observation:**  
Observed default rates reach **70.54%** for Grade F ($n = 241$) and **98.44%** for Grade G ($n = 64$).

**Evidence:**  
- **Grade G:** $1,098,925 in defaulted principal vs. $307 in first-year interest revenue (Net: -$1,098,618).
- **Grade F:** $2,496,875 in defaulted principal vs. $195,206 in first-year interest revenue (Net: -$2,301,669).

**Proposed Underwriting Consideration:**  
Given the extreme observed default concentration in Grade G, consider discontinuing approvals in this tier. For Grade F, evaluate whether risk-based pricing caps allow for viable risk-adjusted returns or whether tighter entry criteria should be established.

---

### Insight 3 — Prior Bureau Default on File is Strongly Associated with Repeat Default (2.05x)

**Observation:**  
Applicants with a prior default recorded by the credit bureau default at **37.87%**, compared to **18.43%** for applicants with clean records (2.05x risk ratio).

**Evidence:**  
Across 5,730 borrowers with a prior default flag, total defaulted principal reaches $21.57 million. Historical default is the single strongest bivariate categorical differentiator in the portfolio.

**Proposed Underwriting Consideration:**  
Evaluate routing all applications where `cb_person_default_on_file = 'Y'` to senior manual underwriting review, with candidate prerequisite criteria (e.g., minimum Grade C and DTI $\le 25\%$) rather than automated straight-through processing.

---

### Insight 4 — Debt Consolidation and Medical Loans Exhibit Above-Average Default Rates

**Observation:**  
**Debt Consolidation** (28.68%) and **Medical** (26.70%) loan intents exhibit default rates meaningfully above the portfolio average of 21.87%.

**Evidence:**  
Debt Consolidation represents 5,217 loans and 1,496 defaults. Borrowers seeking consolidation frequently carry pre-existing debt obligations that may impair cash-flow flexibility.

**Proposed Underwriting Consideration:**  
Consider purpose-specific underwriting filters, such as requiring verified debt payoff mechanisms or lower DTI limits (e.g., $\le 30\%$) for debt consolidation applicants.

---

### Insight 5 — 35% DTI Serves as an Empirical Leverage Risk Boundary

**Observation:**  
Observed default rates surge from **18.28%** for borrowers with $\text{DTI} \le 35\%$ to **71.96%** for borrowers with $\text{DTI} > 35\%$ ($Z = 58.41, p < 0.001$).

**Evidence:**  
Borrowers in the High (35–49%) and Critical ($\ge 50\%$) DTI tiers account for $24.96 million in defaulted principal.

**Proposed Underwriting Consideration:**  
Consider establishing 35% DTI as a candidate threshold for mandatory manual review and enhanced income verification, while evaluating tighter exposure limits for applicants above 40% DTI.

---

### Insight 6 — Grade D Represents the Largest Dollar Default Exposure ($22.78M)

**Observation:**  
While Grade G exhibits the highest percentage default rate, **Grade D accounts for the single largest dollar loss** in the portfolio ($22.78 million across 2,143 defaulted loans).

**Evidence:**  
Grade D represents a large approval volume (3,630 loans; $39.46M volume) combined with an elevated default rate (59.06%).

**Proposed Underwriting Consideration:**  
Focus exposure-management strategies on Grade D by evaluating loan-size caps, co-borrower requirements, or stricter affordability checks on larger Grade D loan amounts.

---

### Insight 7 — Composite Risk Flag Provides In-Sample Separation of Elevated Risk Segments

**Observation:**  
The composite analytical flag (`Grade ∈ {E,F,G}` OR `DTI > 40%` OR `Prior Default = 'Y'`) segments applicants into a **44.45% default cohort** ($n = 7,228$) vs. a **15.39% normal cohort** ($n = 25,188$).

**Evidence & Counterfactual Simulation:**  
In a static, in-sample counterfactual scenario where all 7,228 flagged loans were declined:
- **Baseline Default Rate:** Decreases directionally from 21.87% to approximately 15.39%.
- **Gross Defaulted Principal Avoided:** ~$34.7M.
- **Estimated Interest Revenue Forgone:** ~$9.7M.
- **Net Simulated In-Sample Benefit:** Approximately **+$20–$25 million** (under static, zero-recovery assumptions).

*Note: This counterfactual simulation does not account for customer acquisition costs, potential behavioral shifts, or out-of-sample portfolio dynamics.*

**Proposed Underwriting Consideration:**  
Use the composite flag as an analytical prioritization tool to route high-risk applications to manual credit review queues.

---

## Analytical Recommendations Matrix (For Credit Committee Review)

| Area | Proposed Action | Analytical Rationale |
|---|---|---|
| **Grade G Tier** | Consider suspension of Grade G approvals | 98.44% observed default rate; -$1.10M net margin contribution |
| **Prior Default** | Require senior underwriter review for `Prior Default = 'Y'` | 2.05x risk ratio; 37.87% observed default rate |
| **DTI Ceiling** | Designate 35% DTI as candidate review threshold | Sharp empirical risk escalation (71.96% vs. 18.28%) |
| **Debt Consolidation** | Apply stricter leverage limits on debt refinancing loans | 28.68% default rate indicates pre-existing borrower distress |
| **Grade D Exposure** | Evaluate exposure limits / co-signer policies on Grade D | Accounts for largest absolute loss exposure ($22.78M) |
| **Early Warning Flag** | Implement composite flag as review triage trigger | Isolates 44.45% default cohort in historical data |
