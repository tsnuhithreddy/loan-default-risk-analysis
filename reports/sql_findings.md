# SQL Findings

This document summarizes the key business insights obtained from the SQL analysis performed on the cleaned credit risk dataset.

## Business Insights

Finding 1 — Grade G and F are destroying the portfolio
Grade G has a 98.44% default rate — meaning for every 100 Grade G loans approved, 98 will default. Grade F is 70.54%. Grade E is 64.49%. These three grades alone represent the majority of FinTrust's default losses in absolute dollar terms.
Business implication: FinTrust's internal grading model is working correctly — it correctly identifies bad borrowers. The problem is the company is still approving them. The model flags them as high risk and the credit team approves them anyway.

Finding 2 — Prior default is the strongest single predictor
Borrowers with a prior default on file default at 37.87% — compared to 18.43% for clean borrowers. That is 2.06x more likely to default. This is the single most powerful binary predictor in the entire dataset. One column — Y or N — more than doubles default probability.
Business implication: Every application where cb_person_default_on_file = Y should trigger mandatory manual review regardless of loan grade. Currently FinTrust treats this flag as one of many inputs. It should be treated as a near-automatic red flag.

Finding 3 — Three loan intents consistently exceed the average default rate
Debt Consolidation (28.68%), Medical (26.76%), and Home Improvement (26.15%) all exceed the portfolio average of 21.87%. Debt Consolidation is particularly concerning — a borrower consolidating existing debt is already financially stressed before taking this loan.
Business implication: These three intents should carry stricter approval conditions — minimum Grade C, DTI below 30%, and no prior default on file. Approving a Debt Consolidation loan for a Grade E borrower is a near-certain loss.

Finding 4 — DTI ratio is a reliable default predictor
Borrowers in the Critical DTI tier (loan_percent_income above 0.50) default at significantly higher rates than Low DTI borrowers. The industry standard threshold of 35% DTI appears to be correctly placed — default rates jump meaningfully above this level.
Business implication: FinTrust's existing 35% DTI threshold is validated by the data. The recommendation is to enforce it more strictly rather than approve exceptions above it.

Finding 5 — Young borrowers carry disproportionate risk
Borrowers under 25 (Young segment) show the highest default rate among age groups. This makes intuitive sense — shorter employment history, lower income stability, less financial experience.
Business implication: Loan applications from borrowers under 25 should require higher minimum grades (B or above) and stricter DTI limits than older borrower segments.

Finding 6 — Renters default more than homeowners
RENT shows the highest default rate among home ownership categories. OWN shows the lowest. This aligns with financial theory — homeowners have a tangible asset and typically more financial stability.
Business implication: Home ownership status should be weighted more heavily in FinTrust's internal scoring model. A renter applying for a Grade D loan is significantly riskier than a homeowner applying for the same grade.

Finding 7 — Some grades are loss-making despite revenue generation
Certain higher-risk grades generate significant interest revenue but the default losses exceed that revenue. A grade that charges 20% interest but loses 70% of principal on defaults is net negative for the business.
Business implication: FinTrust must calculate risk-adjusted return by grade — not just interest rate. Revenue from repaid loans in Grade F and G does not compensate for the principal lost on defaulted ones.

Finding 8 — High risk composite flag captures a dangerous segment
Borrowers flagged as High Risk (Grade E/F/G OR DTI above 40% OR prior default on file) show a default rate more than double the portfolio average. This segment represents a significant portion of total applications.
Business implication: The composite risk flag from Q10 can be operationalised as an automatic review trigger in FinTrust's loan approval workflow. Any application triggering this flag should not be auto-approved.

Finding 9 — Grade model is well-calibrated at the extremes but fails in the middle
Grade A and Grade G perform roughly as expected. The middle grades C, D, and E show actual default rates that exceed their expected ranges from the risk scoring matrix. The model underestimates risk for these grades.
Business implication: FinTrust's internal credit scoring model needs recalibration specifically for Grade C, D, and E borrowers. These grades are being approved with insufficient scrutiny because the model incorrectly classifies them as moderate risk.

Finding 10 — Income quartile analysis confirms income is a reliable predictor
Quartile 1 (lowest income) defaults at the highest rate. Quartile 4 (highest income) defaults at the lowest rate. The relationship is consistent and monotonic — each higher income quartile defaults less than the one below it.
Business implication: Income verification should be strengthened in the approval process. Since income is self-reported in this dataset, FinTrust should require bank statement verification for all low-income applicants.
