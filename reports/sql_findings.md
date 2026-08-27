# SQL Business Intelligence Findings — FinTrust Lending Co.

**Analyst:** Telukala Snuhith Reddy  
**Database:** `fintrust_lending` (MySQL 8.0) | 32,416 records post-cleaning  
**Methodology Note:** These findings summarize descriptive metrics and aggregations derived from the 28 SQL business intelligence queries. They describe historical associations within the portfolio rather than out-of-sample predictive models.

---

### Finding 1 — Higher-Risk Grades (E, F, G) Generate Severe Negative Net Margins

SQL analysis confirms strong monotonic risk ordering across loan grades:
- **Grade A:** 9.96% default rate ($n = 10,653$)
- **Grade B:** 16.32% default rate ($n = 10,351$)
- **Grade C:** 21.05% default rate ($n = 6,399$)
- **Grade D:** 59.06% default rate ($n = 3,630$)
- **Grade E:** 64.49% default rate ($n = 966$)
- **Grade F:** 70.54% default rate ($n = 241$)
- **Grade G:** 98.44% default rate ($n = 64$)

**Business Implication:** The grading framework successfully differentiates risk tiers. However, in Grades E, F, and G, principal write-offs vastly exceed first-year interest revenue, resulting in substantial net dollar losses.

---

### Finding 2 — Prior Default History is the Strongest Bivariate Risk Differentiator

Query 15 shows that borrowers with a historical default on file default at **37.87%**, compared to **18.43%** for borrowers with clean credit bureau records—a **2.05x risk ratio**.
- **Business Implication:** Bureau-reported default history represents the strongest single bivariate categorical signal in the dataset. Applications with `cb_person_default_on_file = 'Y'` warrant mandatory credit officer review rather than automated approval.

---

### Finding 3 — Three Loan Intents Exceed the Portfolio Average Default Rate

Query 3 identifies three loan purposes with observed default rates above the portfolio average of 21.87%:
- **Debt Consolidation:** 28.68% (1,496 defaults / 5,217 loans)
- **Medical:** 26.70% (1,402 defaults / 5,251 loans)
- **Home Improvement:** 26.15% (734 defaults / 2,807 loans)

**Business Implication:** Debt consolidation applicants often carry pre-existing debt burdens. Stricter debt-to-income caps and grade prerequisites (e.g., Grade C or above) should be evaluated for these purpose categories.

---

### Finding 4 — Loan-to-Income (DTI) Ratio Shows Sharp Risk Escalation Above 35%

Query 8 and Query 27 evaluate borrower leverage tiers:
- **Low DTI (<20%):** 12.87% default rate
- **Medium DTI (20–34%):** 21.68% default rate
- **High DTI (35–49%):** 69.87% default rate
- **Critical DTI (≥50%):** 78.43% default rate

**Business Implication:** Observed default rates more than triple when DTI crosses 35%. This empirical step-change supports establishing 35% DTI as a primary candidate threshold for mandatory review.

---

### Finding 5 — Default Risk Exhibits a Non-Linear Age Distribution

Query 6 reveals an empirical U-shaped age pattern:
- **Senior Borrowers (>50):** 25.35% default rate ($n = 852$)
- **Young Borrowers (<25):** 23.34% default rate ($n = 14,484$)
- **Core Career Borrowers (25–50):** 20.55%–20.98% default rate ($n = 17,080$)

**Business Implication:** Underwriting scrutiny should account for distinct life-stage risk drivers at both age extremes rather than assuming risk declines linearly with age.

---

### Finding 6 — Home Ownership Status is Strongly Associated with Default Outcomes

Query 4 and Query 24 break down loan outcomes by housing tenure:
- **Renters:** 31.52% default rate ($n = 16,368$; 5,159 defaults)
- **Mortgage Holders:** 12.63% default rate ($n = 13,382$; 1,690 defaults)
- **Homeowners (Own):** 7.37% default rate ($n = 2,563$; 189 defaults)
- **Other:** 49.06% default rate ($n = 103$; 51 defaults)

**Business Implication:** Housing equity and tenure reflect broader financial stability. Renter applicants in higher-risk loan grades exhibit compounded default rates.

---

### Finding 7 — Risk-Adjusted Revenue Analysis Highlights Loss-Making Tiers

Query 20 reconciles first-year simple interest revenue against defaulted principal exposure:
- **Grades A, B, and C:** Net positive baseline margin (interest earned exceeds defaulted principal).
- **Grades D, E, F, and G:** Net negative margin (defaulted principal exceeds first-year interest revenue).

**Business Implication:** Lending products in lower credit tiers cannot rely solely on higher nominal interest rates to compensate for extreme default frequencies.

---

### Finding 8 — Composite Risk Flag Captures an Empirical High-Risk Segment

Query 10 aggregates the composite analytical risk flag (`Grade ∈ {E,F,G}` OR `DTI > 40%` OR `Prior Default = 'Y'`):
- **High Risk Cohort:** 44.45% default rate ($n = 7,228$; 3,213 defaults)
- **Normal Cohort:** 15.39% default rate ($n = 25,188$; 3,876 defaults)

**Business Implication:** The composite flag successfully isolates an empirical cohort responsible for 45.3% of all portfolio defaults from 22.3% of total loan volume.

---

### Finding 9 — Middle Loan Grades Diverge from Reference Matrix Expectations

Query 13 compares observed default rates against the simulated `risk_scoring_matrix`:
- **Grades A & B:** Perform in line with Low Risk benchmark expectations (<8.0% and 8.0–20.0%).
- **Grades C & D:** Show actual default rates (21.05% and 59.06%) exceeding Medium Risk benchmark ranges (8.0–20.0%).

**Business Implication:** The middle grades exhibit significant performance drift relative to benchmark ranges, suggesting the need for tighter underwriting criteria in Grade C and D segments.

---

### Finding 10 — Income Quartile Analysis Confirms Strong Monotonic Association

Query 23 evaluates borrower distribution across income quartiles:
- **Quartile 1 ($4k–$38.5k):** 31.95% default rate
- **Quartile 2 ($38.5k–$55k):** 24.38% default rate
- **Quartile 3 ($55k–$79.2k):** 18.06% default rate
- **Quartile 4 ($79.2k–$140.2k):** 13.08% default rate

**Business Implication:** Income exhibits a clear, monotonic inverse association with default rate. Enhanced documentation verification is recommended for applicants in Quartile 1.
