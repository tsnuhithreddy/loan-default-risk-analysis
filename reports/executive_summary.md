# Executive Summary — Loan Default Risk Analysis
## FinTrust Lending Co. | Credit Risk Review
### Prepared by: Telukala Snuhith Reddy, Data Analyst
### Date: August 2026 | Confidential

---

## Situation

FinTrust Lending Co. is facing a credit risk crisis that is costing the 
business tens of millions of dollars annually.

An analysis of 32,416 historical loan records reveals that 1 in every 
5 loans approved ends in default. The current default rate of 21.87% is 
4 to 6 times higher than the NBFC sector's gross NPA range of 3.6%–5.4%.* More critically,
the interest revenue generated from loans that are repaid — $25 million — 
does not come close to covering the $77 million lost on loans that default. 
FinTrust's net portfolio position is negative $51.96 million.

This is not a temporary performance dip. It is a structural problem in 
how loans are being approved.

---

## What the Data Found

**The grading model works — but approvals ignore it.**

FinTrust assigns every loan applicant a risk grade from A to G before 
approving their loan. The data confirms this model is accurate — Grade A 
borrowers default at 9.96% while Grade G borrowers default at 98.44%. 
The model correctly identifies who is high risk. The problem is that 
high-risk loans are being approved anyway.

**Three factors predict default more reliably than anything else.**

First — loan grade. Grades E, F, and G collectively default at rates 
above 64%. These grades generate more in losses than they earn in interest. 
They are not high-risk products — they are guaranteed losses.

Second — prior default history. A borrower who has defaulted before is 
2.06 times more likely to default again. This single piece of information, 
available from the credit bureau before every approval, is the strongest 
predictor in the entire dataset.

Third — debt burden. Borrowers whose loan repayment exceeds 35% of their 
annual income default at nearly 70%. FinTrust has a 35% threshold policy 
but the data shows it is not being enforced consistently.

**The largest losses are not where you expect them.**

Grade G has the highest default rate at 98.44% — but it causes only $1.1M 
in losses because few Grade G loans are approved. Grade D, with a 59.06% 
default rate, causes $23M in losses — the largest of any grade — because 
far more Grade D loans are approved at higher amounts. Managing total 
exposure, not just default rate, is critical.

**The business is losing money on 3 out of 7 loan grades.**

Grades E, F, and G all generate more losses than revenue after accounting 
for defaults. They are not high-yield, high-risk products. They are 
loss-making products that should either be discontinued or fundamentally 
repriced.

---

## Financial Summary

| Metric | Value |
|---|---|
| Total loans analysed | 32,416 |
| Total defaulted loans | 7,089 |
| Overall default rate | 21.87% |
| NBFC sector gross NPA (benchmark)* | 3.6%–5.4% |
| Total interest revenue (repaid loans) | $25 million |
| Total principal lost (defaulted loans) | $77 million |
| **Net portfolio position** | **-$51.96 million** |

---

## What Must Be Done

Six actions are recommended in priority order.

**Action 1 — Suspend Grade G approvals. Immediately.**
Grade G borrowers default at 98.44%. There is no scenario where approving 
these loans benefits the business. Every Grade G approval is a near-certain 
write-off. This is the single fastest action available to stop ongoing losses.

**Action 2 — Treat prior default as a hard stop.**
Any applicant with a prior default on their credit bureau record should be 
required to meet stricter minimum criteria — Grade C or above and debt burden 
below 25% — before any approval is considered. This flag should trigger 
automatic escalation to a senior credit officer. It must never be part of 
a standard auto-approval workflow.

**Action 3 — Make the 35% debt threshold a hard rule, not a guideline.**
Currently the data shows borrowers above 35% debt-to-income being approved 
at significant volume. Default rates above this threshold exceed 69%. Any 
exception above 35% must require documented board-level approval.

**Action 4 — Apply stricter criteria to Debt Consolidation loans.**
Borrowers seeking to consolidate existing debt are already financially 
stressed. This intent category defaults at 28.68% — the highest of any 
loan purpose. A borrower who cannot manage their existing debts should not 
automatically qualify for additional lending. Minimum Grade C and debt 
burden below 30% should be required.

**Action 5 — Implement the Early Warning System.**
Analysis has produced a composite risk flag that identifies high-risk 
applicants before approval using three criteria — loan grade, debt burden, 
and prior default history. In testing, this flag correctly separates 
high-risk borrowers who default at 44.5% from normal borrowers who default 
at 15.4%. Routing all flagged applications to manual review rather than 
auto-approval is projected to reduce portfolio losses by $20 to $25 million.

**Operational requirement:** Implementing mandatory manual review for all 
flagged applications requires an estimated 2 additional credit officer FTEs 
(assuming ~602 flagged applications/month and a 20-minute review per 
application). This should be budgeted alongside the projected $20–25M loss 
reduction as the cost side of this recommendation.

**Action 6 — Review Grade D lending volume and limits.**
Grade D is the single largest source of default losses in absolute dollars 
at $23 million — not because of the highest default rate, but because of 
high approval volume at significant loan amounts. Capping Grade D approvals 
at 15% of monthly volume and requiring collateral for Grade D loans above 
$15,000 would meaningfully reduce this exposure.

---

## Trade-Offs Considered

Every recommendation in this report has a cost as well as a benefit. Below is 
the net financial impact of each major action, accounting for the interest 
revenue given up by declining loans that would otherwise have repaid.

| Action | Revenue Forgone | Loss Avoided | Net Benefit |
|----------|----------|---------|----------|
| Suspend Grade G approvals | $307 | $1,098,925 | +$1,098,618 |
| Suspend Grade F approvals | $195,206 | $2,496,875 | +$2,301,669 |
| Enforce 35% DTI hard ceiling | $1,222,679 | $24,958,475 | +$23,735,796 |

In all three cases the loss avoided is one to two orders of magnitude larger 
than the revenue forgone — meaning these recommendations hold up even after 
accounting for their opportunity cost, not just their headline loss-avoidance 
figure.

## Projected Impact of Recommended Actions

If all six actions are implemented:

| Action | Projected Loss Reduction |
|---|---|
| Suspend Grade G | $1.1M ongoing exposure eliminated |
| Prior default hard stop | 3–4% reduction in portfolio default rate |
| DTI hard ceiling | Eliminates highest-risk approvals |
| Early Warning System | $20–25M projected loss reduction |
| Grade D volume cap | Reduces largest absolute exposure |
| **Total projected impact** | **$25–30M reduction in annual losses** |

These projections are conservative. They assume partial implementation 
and do not account for second-order benefits such as improved credit 
quality of the overall portfolio and reduced cost of collections.

---

## Conclusion

FinTrust's core lending business is viable — Grades A and B borrowers 
repay reliably and generate positive returns. The crisis is concentrated 
in the higher-risk grades and in the absence of consistent enforcement of 
existing risk policies.

The data does not suggest that FinTrust needs to fundamentally change 
what it does. It needs to change who it approves. The tools to make 
better decisions — loan grade, DTI ratio, credit bureau history — are 
already available at the point of every approval decision. They are 
simply not being used with sufficient discipline.

The six recommendations in this report, if implemented together, are 
projected to reduce annual default losses by $25 to $30 million and 
bring FinTrust's default rate from 21.87% toward the 12 to 15% range 
within 12 months — and toward the industry standard of 3 to 5% within 
24 months with continued policy discipline.

The cost of inaction is $52 million per portfolio cycle. The cost of 
implementation is process change and stricter credit discipline. 
The choice is clear.

---

*This analysis is based on 32,416 historical loan records. 
All financial figures are derived from loan principal amounts 
and stated interest rates. Recovery rates assumed at zero 
(conservative estimate). Industry benchmark: NBFC sector gross NPA 
of 3.6%–5.4%, sourced from CareEdge Ratings' NBFC-Microfinance 
Industry Report (2025) and ICRA (2021). Note: GNPA (90+ days 
past due) is a different metric from this dataset's default flag 
(a completed default outcome), so the comparison is directional, 
not a precise like-for-like benchmark.*
