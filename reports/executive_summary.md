Both of those updates make the report exceptionally rigorous and defensive.

Here is the exact full text for **`reports/executive_summary.md`** with both refinements applied:

---

### Exact Full Text for `reports/executive_summary.md`:

Copy and replace the entire content of **`reports/executive_summary.md`** with this block:

````markdown
# Executive Summary — Credit Risk Analysis & Portfolio Review
## FinTrust Lending Co. | Portfolio Risk Review
### Prepared by: Telukala Snuhith Reddy, Data Analyst
### Scope: 32,416 Historical Loan Records (`data/cleaned/credit_risk_cleaned.csv`)

---

## Executive Overview

An analysis of 32,416 historical loan records reveals an overall observed default rate of **21.87%** (7,089 defaulted loans), representing **$76.97 million** in defaulted principal exposure against **$310.99 million** in total funded loan volume.

Comparing estimated first-year simple interest calculated on non-defaulted loans ($25.00 million) against defaulted principal exposure ($76.97 million) produces a **net portfolio position of -$51.96 million under a simplified one-year simple-interest, zero-recovery analytical proxy**. For contextual comparison, CareEdge Ratings reported GNPA of 5.4% for the NBFC-MFI sector as of March 2025 and projected a decline to 3.6% by March 2026. This comparison is directional only because GNPA is a delinquency-based asset-quality measure, whereas `loan_status` in this dataset represents a binary historical default outcome.

This analysis investigates key empirical risk drivers within the historical portfolio to provide data-driven recommendations for credit risk committee review.

---

## Key Empirical Findings

### 1. Loan Grades Demonstrate Strong Monotonic Risk Differentiation
Observed default rates escalate monotonically across assigned credit grades:
- **Grade A:** 9.96% ($n = 10,703$; 1,066 defaults)
- **Grade B:** 16.32% ($n = 10,387$; 1,695 defaults)
- **Grade C:** 20.75% ($n = 6,438$; 1,336 defaults)
- **Grade D:** 59.06% ($n = 3,620$; 2,138 defaults)
- **Grade E:** 64.49% ($n = 963$; 621 defaults)
- **Grade F:** 70.54% ($n = 241$; 170 defaults)
- **Grade G:** 98.44% ($n = 64$; 63 defaults)

Under the simplified single-year exposure proxy, first-year interest from performing loans does not offset defaulted principal exposure in any grade, resulting in negative net balances across all seven tiers.

### 2. Prior Credit Default is a Strong Observed Categorical Risk Signal
Borrowers with a historical credit bureau default on file default at **37.87%** (2,170 defaults / 5,730 loans), compared to **18.43%** (4,919 defaults / 26,686 loans) for borrowers with clean bureau records—a **2.05x risk ratio**.

### 3. Leverage (Loan-to-Income Ratio) Exhibits a Sharp Step-Change at 35%
Observed default rates increase sharply across Loan-to-Income (LTI) tiers (`loan_percent_income`):
- **$\le 35\%$ LTI:** 18.28% default rate ($n = 30,248$; 5,529 defaults)
- **$> 35\%$ LTI:** 71.96% default rate ($n = 2,168$; 1,560 defaults)

This statistically significant divergence ($Z = 58.41, p < 0.001$, 95% CI: [51.74%, 55.62%]) supports evaluating 35% LTI as a candidate threshold for enhanced manual review.

### 4. Defaulted Principal Exposure is Heavily Concentrated in Grade D
While Grade G exhibits the highest percentage default rate (98.44%), **Grade D accounts for the single largest defaulted principal exposure** in the portfolio at **$22.78 million** across 2,138 defaulted loans. Portfolio exposure management must balance percentage default rates with absolute dollar concentrations.

---

## Financial Exposure Reconciliation Summary

| Metric | Value |
|---|---|
| Total Loans Analyzed | 32,416 |
| Total Defaulted Loans | 7,089 |
| Overall Observed Default Rate | 21.87% |
| Total Loan Volume Funded | $310.99 million |
| Gross Defaulted Principal Exposure | $76.97 million |
| Estimated First-Year Simple Interest (Non-Defaulted Loans) | $25.00 million |
| **Net Portfolio Balance (One-Year Simple-Interest, 0% Recovery Proxy)** | **-$51.96 million** |
| Contextual NBFC-MFI GNPA Reference* | 5.4% (Mar 2025); 3.6% projected (Mar 2026) |

---

## Analytical Recommendations for Credit Committee Review

The following candidate policies are proposed for institutional evaluation:

1. **Grade G Tier Review:** Evaluate suspension or enhanced underwriting restrictions for Grade G approvals (98.44% default rate, $n = 64$).
2. **Prior Default Workflow Triage:** Route applications with `cb_person_default_on_file = 'Y'` to senior manual credit review.
3. **Enhanced Leverage Review at 35% LTI:** Designate 35% LTI as a candidate threshold for mandatory income verification and manual underwriting.
4. **Purpose-Specific Underwriting:** Introduce tighter leverage thresholds on Debt Consolidation loans (28.68% default rate; 1,488 defaults / 5,189 loans) and Medical loans (26.76% default rate; 1,617 defaults / 6,042 loans).
5. **Grade D Exposure Controls:** Evaluate exposure caps, co-borrower requirements, or stricter affordability limits on higher-balance Grade D applications ($22.78M exposure).
6. **Early Warning Flag Implementation:** Utilize the composite risk flag (`Grade ∈ {E,F,G}` OR `loan_percent_income > 0.40` OR `cb_person_default_on_file = 'Y'`) to prioritize applications for manual underwriting review queues.

---

## Simulated Trade-Off Analysis (In-Sample Counterfactual Modeling)

To evaluate the trade-offs of proposed tightening measures, the following table models static in-sample counterfactual scenarios comparing observed defaulted principal exposure against forgone estimated first-year simple interest in the excluded segments:

| Simulated Action | Estimated Interest Income Forgone | Observed Defaulted Principal Exposure in Excluded Group | Simplified In-Sample Exposure–Interest Difference |
|---|---|---|---|
| Exclude Grade G Approvals ($n = 64$) | $307 | $1,098,925 | +$1,098,618 |
| Exclude Grade F Approvals ($n = 241$) | $195,206 | $2,496,875 | +$2,301,669 |
| Exclude Approvals with LTI > 35% ($n = 2,168$) | $1,222,679 | $24,958,475 | +$23,735,796 |
| Exclude Composite High-Risk Flagged ($n = 7,228$) | $5,880,774 | $39,427,075 | +$33,546,301 |

*Note: These simulations reflect static in-sample calculations under a baseline zero-recovery assumption. They are illustrative scenario models, not forward-looking financial profit forecasts. They do not establish that the observed defaults would have been prevented by the proposed policy and do not account for customer acquisition costs, potential borrower behavioral changes, or macroeconomic shifts.*

---

## Conclusion & Limitations

**Methodology & Data Limitations:**
- **Observational Snapshot:** The dataset represents a static historical snapshot without origination dates, preventing vintage cohort tracking, seasonality modeling, or forward-looking time-series forecasts.
- **Zero-Recovery Assumption:** Exposure figures assume 0% recovery post-default; actual recoveries would reduce realized net loss figures.
- **First-Year Interest Proxy:** Interest calculations reflect single-year simple interest on non-defaulted loans rather than full lifetime loan cash-flow profitability.
- **Compliance & Fair Lending:** Any adopted underwriting cutoffs must undergo fair-lending disparate impact review prior to production implementation.

---

*\*Benchmark note: External reference sourced from CareEdge Ratings, NBFC-Microfinance Industry Report, 2025. GNPA (90+ days past due) is a delinquency metric whereas `loan_status` represents a completed binary default outcome; the comparison is directional.*
````
