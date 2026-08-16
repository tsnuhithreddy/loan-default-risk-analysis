Insight 1 — The Portfolio is in a Structural Crisis
Observation:
FinTrust's overall default rate stands at 21.87% — nearly one in four loans approved ends in default.
Evidence:
Of 32,416 loans analysed, 7,089 have defaulted representing a total principal loss exposure of $77 million. NBFC sector gross NPA has ranged 3.6%–5.4% in recent periods (CareEdge Ratings, NBFC-Microfinance Industry Report, 2025). FinTrust is operating at 4–6x this range. Note: GNPA measures 90+ day delinquency, while loan_status here reflects a completed default outcome, so this comparison is directional rather than a precise like-for-like benchmark.
Business Impact:
At the current default rate FinTrust's interest revenue of $25 million from repaid loans is completely overwhelmed by $77 million in default losses — producing a net portfolio position of negative $51.96 million. The business is not merely underperforming — it is destroying capital on every cohort of loans approved.
Recommendation:
An immediate portfolio-wide review is required. No new loan approvals should proceed without a revised risk framework in place. The current approval process is systematically approving borrowers who cannot repay.

Insight 2 — Grade G and F Loans Should Be Discontinued Immediately
Observation:
Grade G loans default at 98.44% and Grade F loans default at 70.54% — both far exceeding any threshold where lending remains rational.
Evidence:
Grade G generates $0.0M in interest revenue against $1.1M in default losses. Grade F generates $0.2M in revenue against $2.5M in losses. Both grades are deeply loss-making — every rupee lent at these grades produces a net loss after accounting for defaults.
Business Impact:
Continuing to approve Grade F and G loans costs FinTrust approximately $3.6M in net losses from these two grades alone. Since loan grade is assigned before approval, this loss is entirely preventable. There is no risk-adjusted case for approving Grade G loans — the expected loss exceeds the expected revenue by an order of magnitude.
Recommendation:
Suspend all Grade G approvals immediately. Place a moratorium on Grade F approvals pending a pricing review. If Grade F loans are to continue, interest rates must be restructured to at minimum break even after accounting for the 70.54% expected default rate — which would require rates exceeding 40%, likely above regulatory caps.

Insight 3 — Prior Default History is the Single Strongest Predictor of Future Default
Observation:
Borrowers with a prior default on file default at 37.87% compared to 18.43% for clean borrowers — making them 2.06 times more likely to default again.
Evidence:
Of 32,416 borrowers, 5,730 carry a prior default flag from the credit bureau. This single binary column — Y or N — more than doubles default probability. No other single variable in the dataset produces an equivalent predictive separation.
Business Impact:
FinTrust is currently approving loans for borrowers with prior defaults without applying materially different criteria. If the 5,730 prior-default borrowers were subject to stricter minimum grade requirements (Grade C or above only), the projected portfolio default rate would reduce by an estimated 3–4 percentage points.
Recommendation:
Implement a mandatory policy: any applicant with cb_person_default_on_file = Y must meet a minimum loan grade of C and a maximum DTI of 25% to qualify for approval. Prior default should function as an automatic escalation trigger requiring senior credit officer sign-off rather than standard approval workflow.

Insight 4 — Debt Consolidation Loans Signal Pre-Existing Financial Distress
Observation:
Debt Consolidation loans carry the highest default rate among all loan purposes at 28.68% — exceeding the portfolio average of 21.87% by 6.81 percentage points.
Evidence:
A borrower seeking debt consolidation is, by definition, already managing multiple debt obligations they are struggling to service. This context — pre-existing financial stress — makes them structurally higher risk before any other factor is considered. Medical loans (26.76%) and Home Improvement loans (26.15%) follow closely — both representing reactive rather than planned financial decisions.
Business Impact:
These three loan intents — Debt Consolidation, Medical, and Home Improvement — collectively represent a significant portion of FinTrust's portfolio volume. Their above-average default rates suggest FinTrust's approval criteria do not adequately account for the specific risk profile each intent carries.
Recommendation:
Introduce intent-specific approval criteria. For Debt Consolidation loans — require Grade C minimum, DTI below 30%, and no prior default. For Medical and Home Improvement — require Grade D minimum with DTI below 35%. Intent should be a first-pass filter in the approval workflow, not a passive data field.

Insight 5 — The DTI Threshold is Correctly Placed but Poorly Enforced
Observation:
Borrowers in the Critical DTI tier (loan_percent_income above 50%) default at 76.72% — nearly four times the rate of Low DTI borrowers at 13.43%.
Evidence:
The data shows a consistent and steep escalation across DTI tiers — Low 13.43%, Medium 29.05%, High 69.87%, Critical 76.72%. The jump between Medium and High tiers at the 35% boundary is dramatic — a 40 percentage point increase in default rate. This validates that the 35% threshold is correctly placed as a risk boundary.
Business Impact:
Despite having a correctly calibrated DTI threshold, FinTrust is clearly approving loans above this threshold — evidenced by the significant number of borrowers in the High and Critical tiers. Each exception approved above 35% DTI carries an expected default rate above 69%.
Recommendation:
The 35% DTI threshold should be treated as a hard ceiling not a soft guideline. Loans above 35% DTI should require explicit board-level exception approval with documented justification. Loans above 50% DTI should be automatically declined regardless of other factors.

Insight 6 — Grade D Represents FinTrust's Largest Absolute Financial Loss
Observation:
Despite not having the highest default rate, Grade D loans generate the largest total default exposure in the portfolio at $23 million.
Evidence:
Grade D has a default rate of 59.06% — significant but lower than Grades E, F, and G. However Grade D carries the highest loan volume among higher-risk grades. The combination of high volume and elevated default rate produces the largest absolute loss. Grade D alone accounts for approximately 30% of total portfolio default exposure.
Business Impact:
This is a critical insight that default rate alone would miss. A risk team focused only on Grade G (highest rate) would overlook that Grade D is costing the business far more in absolute dollars. Capital allocation decisions must be driven by exposure not rate.
Recommendation:
Introduce mandatory collateral or guarantor requirements for all Grade D loans above $15,000. Additionally cap total Grade D loan volume as a percentage of new monthly approvals — recommend no more than 15% of monthly approvals fall into Grade D.

Insight 7 — The Early Warning System Successfully Identifies High-Risk Borrowers
Observation:
Borrowers flagged as High Risk by the composite flag (Grade E/F/G OR DTI above 40% OR prior default on file) default at 44.5% compared to 15.4% for normal borrowers — a 2.89x separation.
Evidence:
Of 32,416 borrowers, 7,228 are flagged as High Risk. These borrowers account for a disproportionate share of total defaults despite representing only 22.3% of the portfolio by volume. The flag correctly separates the population into two meaningfully different risk groups.
Business Impact:
If FinTrust had declined all 7,228 High Risk flagged applications, the projected default rate on the remaining portfolio would drop from 21.87% to approximately 15.4% — a 6.47 percentage point reduction. This represents approximately $20–25 million in avoided default losses.
Recommendation:
Operationalise the composite risk flag as an automatic workflow trigger in the loan approval system. Any application triggering the flag should be routed to a mandatory manual review queue rather than standard auto-approval. This single operational change has the highest projected impact of any recommendation in this analysis.

Insight 8 — FinTrust is Losing $52 Million Net on This Portfolio
Observation:
Total interest revenue from repaid loans across all grades is $25 million. Total principal lost on defaulted loans is $77 million. Net position is negative $51.96 million.
Evidence:
This is not a marginal loss — it is a structural one. Even Grades A and B, which are the healthiest grades in the portfolio, generate modest revenue. The losses from Grades D, E, F, and G overwhelm any revenue generated from the safer grades. The business model as currently operated is not financially viable.
Business Impact:
Every quarter FinTrust continues operating under the current approval framework, it deepens this structural loss. The loss is not recoverable from existing loans — it is a forward-looking problem that only tighter approval criteria can address.

Recommendation:
Present this net position figure to the board as the primary financial argument for immediate policy reform. The $51.96 million net loss is more compelling than any percentage-based default rate because it quantifies the real cost in money rather than statistics. Pair this with projected net position improvement under the recommended policy changes to demonstrate the financial case for reform.

## Summary — Priority Action Matrix

| Priority | Action | Projected Impact |
|----------|----------|---------|
| Immediate | Suspend all Grade G approvals | Eliminate $1.1M ongoing exposure |
| Immediate | Flag prior default as mandatory review trigger | Reduce default rate by 3–4% |
| 30 days | Implement DTI hard ceiling at 35% | Eliminate highest-risk approvals |
| 30 days | Apply intent-specific approval criteria | Reduce Debt Consolidation defaults |
| 60 days | Cap Grade D volume at 15% of monthly approvals | Reduce largest absolute exposure |
| 60 days | Operationalise composite risk flag in workflow | $20–25M projected loss reduction |
| 90 days | Restructure or discontinue Grade F pricing | Eliminate loss-making grade |
