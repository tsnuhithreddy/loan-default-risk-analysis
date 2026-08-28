# Executive Summary — Credit Risk Analysis & Portfolio Review
## FinTrust Lending Co. | Portfolio Risk Review
### Prepared by: Telukala Snuhith Reddy, Data Analyst
### Scope: 32,416 Historical Loan Records

---

## Executive Overview

An analysis of 32,416 historical loan records reveals an overall observed default rate of **21.87%** (7,089 defaulted loans), representing **$76.97 million** in defaulted principal exposure against **$310.99 million** in total loan volume.

Estimated first-year simple interest revenue from non-defaulted loans ($25.00 million) is substantially outweighed by defaulted principal ($76.97 million), resulting in an annualized net portfolio position of **-$51.96 million** under a baseline zero-recovery assumption. By comparison, prime NBFC gross non-performing asset (GNPA) benchmarks typically range between 3.6% and 5.4% (CareEdge Ratings, 2025).*

This analysis investigates key empirical drivers of default risk to provide data-driven proposals for credit committee review.

---

## Key Empirical Findings

### 1. Loan Grades Demonstrate Strong Risk Rank-Ordering
Observed default rates escalate monotonically across assigned credit grades:
- **Grade A:** 9.96%
- **Grade B:** 16.32%
- **Grade C:** 21.05%
- **Grade D:** 59.06%
- **Grade E:** 64.49%
- **Grade F:** 70.54%
- **Grade G:** 98.44%

The grading model successfully rank-orders borrower risk. However, approvals in Grades E, F, and G generate substantial net dollar losses that nominal interest rates do not offset.

### 2. Prior Credit Default is the Strongest Bivariate Indicator
Borrowers with a historical credit bureau default on file default at **37.87%**, compared to **18.43%** for borrowers with clean records—a **2.05x risk ratio**. This historical indicator provides the strongest single bivariate categorical separation in the portfolio.

### 3. Leverage (DTI Ratio) Exhibits a Sharp Step-Change at 35%
Default rates increase sharply across Debt-to-Income (DTI) tiers:
- **$\le 35\%$ DTI:** 18.28% default rate ($n = 30,248$)
- **$> 35\%$ DTI:** 71.96% default rate ($n = 2,168$)

This statistically significant divergence ($Z = 58.41, p < 0.001$) identifies 35% DTI as a primary candidate threshold for enhanced manual review.

### 4. Dollar Exposure is Concentrated in Grade D
While Grade G exhibits the highest percentage default rate (98.44%), **Grade D accounts for the largest total dollar loss** at **$22.78 million** due to high approval volume (3,630 loans). Portfolio exposure management must balance percentage default rates with absolute dollar volume.

---

## Financial Reconciliation Summary

| Metric | Value |
|---|---|
| Total Loans Analyzed | 32,416 |
| Total Defaulted Loans | 7,089 |
| Overall Observed Default Rate | 21.87% |
| Total Loan Volume Funded | $310.99 million |
| Gross Defaulted Principal Exposure | $76.97 million |
| Estimated First-Year Interest Revenue (Repaid Loans) | $25.00 million |
| **Net Portfolio Position (First-Year View, 0% Recovery)** | **-$51.96 million** |
| NBFC Sector Gross NPA Benchmark Range* | 3.6%–5.4% |

---

## Analytical Recommendations for Credit Committee Review

The following candidate policies are proposed for institutional evaluation:

1. **Grade G Tier Review:** Consider discontinuing approvals in Grade G, where 98.44% of loans defaulted resulting in -$1.10M in net margin contribution.
2. **Prior Default Workflow Triage:** Route applications with `cb_person_default_on_file = 'Y'` to mandatory senior credit officer review with candidate minimum standards (e.g., Grade C or above).
3. **Enhanced Leverage Review at 35% DTI:** Designate 35% DTI as a candidate threshold for required income documentation and manual underwriting review.
4. **Purpose-Specific Underwriting:** Introduce tighter leverage thresholds on Debt Consolidation loans (28.68% default rate), recognizing pre-existing borrower debt burdens.
5. **Grade D Exposure Controls:** Evaluate exposure limits, co-borrower requirements, or stricter affordability limits on higher-balance Grade D applications.
6. **Early Warning Flag Implementation:** Utilize the composite risk flag (`Grade ∈ {E,F,G}` OR `DTI > 40%` OR `Prior Default = 'Y'`) to prioritize applications for manual underwriting queues.

---

## Simulated Trade-Off Analysis (In-Sample Counterfactual Modeling)

To evaluate the trade-offs of proposed tightening measures, the following table models in-sample counterfactual scenarios comparing avoided default losses against forgone first-year interest revenue:

| Simulated Action | Revenue Forgone | Loss Avoided | Net In-Sample Benefit |
|---|---|---|---|
| Exclude Grade G Approvals | $307 | $1,098,925 | +$1,098,618 |
| Exclude Grade F Approvals | $195,206 | $2,496,875 | +$2,301,669 |
| Exclude Approvals with DTI > 35% | $1,222,679 | $24,958,475 | +$23,735,796 |

*Note: These simulations reflect static in-sample calculations under a baseline zero-recovery assumption. They do not account for potential borrower behavioral changes, marketing acquisition costs, or macroeconomic shifts.*

---

## Conclusion & Limitations

The analysis indicates that FinTrust's core lending in lower-risk grades (A and B) generates positive net returns, while portfolio losses are heavily concentrated in higher-risk grades, elevated DTI tiers, and repeat-default applicants.

**Methodology & Data Limitations:**
- **Observational Snapshot:** The dataset represents a static historical snapshot without origination dates, preventing vintage cohort tracking, seasonality modeling, or forward-looking time-series forecasts.
- **Zero-Recovery Assumption:** Loss figures assume 0% recovery post-default; modeled recoveries would reduce net loss figures.
- **Compliance & Fair Lending:** Any adopted underwriting cutoffs must undergo fair-lending review to prevent unintended disparate impacts on protected classes.

---

*\*Benchmark note: NBFC gross NPA benchmark (3.6%–5.4%) sourced from CareEdge Ratings (2025) and ICRA (2021). GNPA (90+ days past due) is a delinquency metric whereas `loan_status` represents a completed default outcome; the comparison is directional.*
