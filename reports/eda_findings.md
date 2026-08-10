# EDA Findings — FinTrust Lending Co.

## Analyst: T Snuhith Reddy

### Finding 1 — Scale of the problem

FinTrust's overall default rate is **21.87%**, meaning approximately 1 in every 5 loans ends in default. This is significantly higher than the typical 3–5% benchmark used for comparison. In the cleaned dataset, **7,089 out of 32,416 loans** defaulted.

### Finding 2 — Grade G is unsalvageable

Grade G loans default at **98.44%**. This is not simply a higher-risk segment — it represents a near-certain loss based on the observed data. Continuing to approve Grade G applications could significantly damage portfolio value.

### Finding 3 — Debt Consolidation is the riskiest intent

Borrowers taking loans for **Debt Consolidation** have the highest observed default rate at **28.68%**, which is well above the overall portfolio default rate. This suggests that borrowers seeking to consolidate existing debt may already be experiencing financial pressure.

### Finding 4 — Prior default doubles risk

Borrowers with a **prior default on file are 2.06x more likely to default again** compared with borrowers without a prior default. This makes previous repayment history an important factor when assessing borrower risk.

### Finding 5 — DTI threshold is correctly placed

Default rates increase noticeably when **debt-to-income (DTI) exceeds 35%**. This indicates that higher debt burdens are strongly associated with repayment risk. FinTrust should therefore apply its DTI threshold consistently and carefully review exceptions.

### Finding 6 — Income predicts repayment reliably

Default rates generally decrease as borrower income increases. **Lower-income borrowers show the highest default rates**, indicating that income level is an important factor in assessing repayment capacity. Stronger income verification and additional risk checks could be considered for the lowest income band.

### Finding 7 — Grade D creates the largest absolute loss

Grade D does not have the highest default rate, but it creates the **largest total financial exposure from defaults** because of the volume of loans in this grade. This makes Grade D an important segment for portfolio-level risk management.

### Finding 8 — Grades F and G are loss-making

The analysis indicates that interest revenue from repaid **Grade F and Grade G loans does not compensate for the principal lost through defaults**. These grades therefore represent potentially loss-making segments and may require stricter approval criteria or risk-based pricing.

### Finding 9 — Young borrowers are highest risk by age

Borrowers **under 25** have the highest observed default rate among the age groups analyzed. Limited employment history, lower income, and less established credit experience may contribute to this higher level of risk.

### Finding 10 — Early Warning System is validated

The composite **risk flag successfully separates high-risk borrowers from normal-risk borrowers**. High-risk borrowers show substantially higher default rates than normal borrowers. This suggests that the risk flag could be used as an early warning indicator within FinTrust's loan approval and monitoring process.
