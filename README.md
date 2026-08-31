# Loan Default Risk Analysis & Early Warning System

> **Simulating an institutional credit risk analytics engagement for FinTrust Lending Co. —
> an analytical portfolio study of 32,416 historical loan records with a 21.87%
> observed default rate.**

---

## The Business Problem

The analyzed FinTrust portfolio shows a high observed default rate, with more than 1 in 5 loans recorded as defaults.

- Default rate: The portfolio's observed default rate is 21.87%. External industry credit-quality metrics are provided only as contextual benchmarks because definitions and measurement periods may differ.
- Total defaults: **7,089 loans** out of 32,416
- Estimated first-year simple interest on non-defaulted loans: **$25.00M**
- Defaulted principal exposure under a zero-recovery assumption: **$76.97M**
- Simplified exposure–interest difference under a one-year simple-interest, zero-recovery assumption: **-$51.96M**

As the analyst, I was hired to identify the major observed risk drivers,
quantify their financial impact, and develop an analytical early-warning
framework to support better lending decisions.

---

## Project Workflow

1. **Data Validation & Understanding**
2. **Data Cleaning & Preparation**
3. **SQL Business Analysis**
4. **Python Exploratory Data Analysis**
5. **Risk Driver Analysis**
6. **Statistical Validation**
7. **Financial Impact Analysis**
8. **Power BI Dashboard Development**
9. **Business Recommendations**
10. **Limitations & Responsible Interpretation**
---

## Key Findings

| # | Finding | Evidence | Recommended Action |
|---|---|---|---|
| 1 | Grade G shows extremely elevated observed default risk | 98.44% default rate | Enhanced underwriting and senior review |
| 2 | Prior-default borrowers show substantially higher observed default risk | 37.87% vs 18.43%; risk ratio ≈ 2.05x | Use prior default as an enhanced-review trigger |
| 3 | Debt Consolidation has the highest observed default rate among loan intents | 28.68% default rate | Apply intent-specific affordability and underwriting review |
| 4 | Loan-to-Income Ratio above 35% is associated with substantially higher observed default | 71.96% vs 18.28%; two-proportion z-test | Use >35% as a candidate enhanced-review threshold |
| 5 | Grade D represents the largest absolute default exposure | Approximately $23M in defaulted principal | Review exposure concentration and underwriting |
| 6 | Grades F and G show negative simplified exposure–interest differences under the project's assumptions | Approximately $0.2M estimated interest vs $3.6M defaulted principal exposure | Review pricing, exposure, and approval strategy |
| 7 | Composite Risk Flag shows strong observed risk separation | 44.5% vs 15.4% default rate | Use as an analytical early-warning indicator pending further validation |
| 8 | Analytical portfolio position is negative under the project's financial assumptions | Estimated interest: $25.00M vs default exposure: $76.97M | Prioritize risk reduction and portfolio exposure management |

---

## Statistical Validation

The composite risk flag was evaluated using a two-proportion z-test comparing observed default rates between flagged and non-flagged borrowers.

The analysis also includes a confidence interval for the difference in default proportions.

The statistical results provide evidence that the observed default-rate difference between the two groups is unlikely to be explained by random sampling variation alone within this dataset.

However, this analysis is not equivalent to out-of-sample predictive-model validation. Before production deployment, the risk flag would require testing on unseen data, threshold optimization, stability monitoring, and fairness assessment.

Full statistical results: [reports/statistical_findings.md](reports/statistical_findings.md)

These results demonstrate statistical association within the analyzed dataset; they do not establish causal effects or guarantee future predictive performance.
## Dashboard

3-page interactive Power BI dashboard built for the CRO.

### Page 1 — Executive Overview
![Executive Overview](dashboard/screenshots/dashboard_page1_overview.png)

### Page 2 — Risk Deep Dive
![Risk Deep Dive](dashboard/screenshots/dashboard_page2_risk_deep_dive.png)

### Page 3 — Early Warning System
![Early Warning System](dashboard/screenshots/dashboard_page3_early_warning.png)

---

## EDA Highlights

### Default Rate by Loan Grade
![Default Rate by Grade](dashboard/screenshots/chart2_default_by_grade.png)

### Revenue vs Loss by Grade
![Revenue vs Loss](dashboard/screenshots/chart8_revenue_vs_loss_by_grade.png)

### Prior Default Impact
![Prior Default](dashboard/screenshots/chart4_prior_default_impact.png)

---

## Tools Used

| Tool | Version | Purpose |
|---|---|---|
| Python | 3.x | Data cleaning and EDA |
| Pandas | Latest | Data manipulation |
| NumPy | Latest | Statistical calculations |
| Matplotlib + Seaborn | Latest | Data visualisation |
| MySQL | 8.0 | SQL analysis |
| Power BI Desktop | Latest | Interactive dashboard |
| Google Colab | — | Development environment |
| GitHub | — | Version control |

---

## Repository Structure

```text
loan-default-risk-analysis/
│
├── data/
│   ├── raw/
│   │   └── credit_risk_dataset.csv
│   │       # Original Kaggle dataset — preserved unchanged
│   │
│   ├── cleaned/
│   │   └── credit_risk_cleaned.csv
│   │       # Validated dataset used for SQL, EDA, and dashboard analysis
│   │
│   └── data_dictionary.md
│       # Definitions, data types, ranges, and cleaning actions for each field
│
├── notebooks/
│   ├── Loan_default_risk_analysis.ipynb
│   │   # Complete Python analysis: EDA, statistical testing, risk analysis,
│   │   # financial impact analysis, and business recommendations
│   │
│   └── README.md
│       # Instructions for running the analysis notebook
│
├── sql/
│   ├── setup.sql
│   │   # Creates the FinTrust database and credit_risk table
│   │
│   ├── reference_tables.sql
│   │   # Creates supporting reference and risk-classification tables
│   │
│   ├── views.sql
│   │   # Creates reusable SQL views for risk analysis
│   │
│   └── queries.sql
│       # 28 business-focused SQL queries across five analytical categories
│
├── dashboard/
│   ├── FinTrust_LoanDefaultRisk_Dashboard.pbix
│   │   # Interactive Power BI dashboard
│   │
│   └── screenshots/
│       # Exported EDA charts and Power BI dashboard pages
│
├── reports/
│   ├── sql_findings.md
│   │   # Key findings from SQL analysis
│   │
│   ├── eda_findings.md
│   │   # Exploratory data analysis findings
│   │
│   ├── business_insights.md
│   │   # Business interpretation and lending recommendations
│   │
│   ├── statistical_findings.md
│   │   # Statistical tests, confidence intervals, and interpretations
│   │
│   └── executive_summary.md
│       # Concise management-level summary of the project
│
├── clean_data.py
│   # Reproducible Python data-cleaning pipeline
│
├── cleaning_log.md
│   # Documentation of data-quality issues and cleaning decisions
│
├── requirements.txt
│   # Python dependencies required to run the project
│
├── LICENSE
│   # MIT license for the project code
│
├── .gitignore
│   # Files and folders excluded from version control
│
└── README.md
    # Project overview, methodology, findings, and reproduction guide
```

## Dataset

| Field | Detail |
|---|---|
| Source | Credit Risk Dataset — Kaggle (Laotse) |
| License | CC0 Public Domain |
| Raw rows | 32,581 |
| Cleaned rows | 32,416 |
| Columns | 12 original + 1 engineered |
| Target variable | `loan_status` (1 = default, 0 = repaid) |
| Observed default rate | 21.87% |

The cleaned dataset contains 32,416 observations and 13 fields after
data-cleaning and feature-engineering steps.

See [data/data_dictionary.md](data/data_dictionary.md) for field definitions,
data types, ranges, and cleaning actions.

Note: the dataset and this project's code are covered by separate licenses.
See `LICENSE` for the project's MIT license.

---

## How to Reproduce

1. **Python dependencies:** `pip install -r requirements.txt`
2. **Data cleaning:** run `python clean_data.py` from the repository root. This reads `data/raw/credit_risk_dataset.csv` and writes `data/cleaned/credit_risk_cleaned.csv`. Alternatively, open `notebooks/Loan_default_risk_analysis.ipynb` in Google Colab and run the notebook using the raw dataset.
3. **SQL analysis:** in MySQL 8.0, run in order: `sql/setup.sql` → import `data/cleaned/credit_risk_cleaned.csv` → `sql/reference_tables.sql` → `sql/views.sql` → `sql/queries.sql`
4. **Dashboard:** open `dashboard/FinTrust_LoanDefaultRisk_Dashboard.pbix` in Power BI Desktop.

## SQL Analysis Highlights

28 queries across 5 categories:

```sql
-- Window function example: running cumulative exposure
SELECT
    loan_grade,
    SUM(loan_amnt)                          AS grade_exposure,
    SUM(SUM(loan_amnt))
        OVER (ORDER BY loan_grade ASC)      AS cumulative_exposure
FROM credit_risk
WHERE loan_status = 1
GROUP BY loan_grade
ORDER BY loan_grade;
```

**Categories covered:**
- Basic aggregations and GROUP BY
- CASE WHEN risk classification
- Multi-table JOINs with reference tables
- CTEs for multi-step business logic
- Window functions — RANK, ROW_NUMBER, NTILE, running totals

Full query file: [sql/queries.sql](sql/queries.sql)

---

## Data Cleaning Summary

| Step | Issue | Action | Rows affected |
|---|---|---|---:|
| 1 | Duplicate rows | Removed duplicate records | 165 |
| 2 | Implausible ages | Capped age at 80 | 7 |
| 3 | Implausible employment length | Capped at age − 16 | 737 |
| 4 | Missing employment length | Filled with 0 and retained a missing-information indicator | 887 |
| 5 | Missing interest rate | Median imputation within loan grade | 3,095 |
| 6 | Extreme income values | IQR-based upper cap at $140,232 | 1478 |
| 7 | Categorical inconsistencies | Trimmed whitespace and standardized categories | All categorical columns |

Full cleaning documentation: [cleaning_log.md](cleaning_log.md)

The employment-length indicator represents missing employment-length
information; it should not be interpreted as confirmed unemployment.

---

## Business Recommendations

### Immediate actions

- **Grade G:** Treat the segment as an enhanced-underwriting population
  given its extremely high observed default rate. Review affordability,
  exposure, pricing, and approval policy rather than automatically rejecting
  every Grade G application.

- **Prior default history:** Use prior default history as an enhanced-review
  trigger because borrowers with prior defaults show substantially higher
  observed default rates.

- **Loan-to-Income Ratio:** Use a Loan-to-Income Ratio above 35% as a
  candidate enhanced-affordability-review threshold. The threshold should
  be evaluated further using portfolio-level and out-of-sample analysis
  before becoming a hard underwriting rule.

### Near-term actions

- Apply intent-specific underwriting and affordability review for
  Debt Consolidation loans.

- Evaluate the Composite Risk Flag as an analytical early-warning indicator.
  Before production use, validate it on unseen data and assess threshold
  stability and fairness.

- Review Grade D exposure concentration because it represents the largest
  absolute default exposure in the analyzed portfolio.

- Review pricing and exposure strategy for Grades F and G using portfolio
  economics and recovery assumptions.

### Longer-term actions

- Validate the observed risk drivers using FinTrust's real portfolio data.

- Perform out-of-sample testing and threshold optimization for the
  Composite Risk Flag.

- Incorporate recovery/collections information before using financial
  exposure estimates for operational decisions.

- Monitor risk-driver stability over time once loan-vintage and
  origination-date data become available.

**Important:** These recommendations are analytical recommendations based on
observed associations in the dataset. They are not validated production
underwriting rules.

**Potential impact:** Reducing exposure to high-risk borrower segments could materially reduce portfolio losses. Specific projected savings are detailed in the Executive Summary report.

Full report: [reports/executive_summary.md](reports/executive_summary.md)

**Compliance note:** Any lending cutoffs based on grade, Loan-to-Income Ratio,
prior default history, or other risk indicators should be reviewed against
applicable fair-lending and responsible-lending requirements before
implementation. Risk variables may correlate with protected characteristics
even when those characteristics are not directly used.

---

## Limitations of This Analysis

- **Observational dataset:** The analysis identifies associations between
  borrower/loan characteristics and observed default outcomes. It does not
  establish causal relationships.

- **No out-of-sample validation:** The Composite Risk Flag was statistically
  evaluated within this dataset but was not tested on unseen data.

- **No loan-vintage or date field:** The dataset is a single snapshot, so
  trend, seasonality, cohort drift, and temporal validation were not possible.

- **No loan-term field:** Estimated interest revenue is calculated using one
  year of simple interest (`loan_amnt × loan_int_rate`), not actual lifetime
  interest revenue.

- **Zero-recovery assumption:** Defaulted principal is treated as fully
  exposed in the financial-impact calculation. Actual recoveries could
  materially reduce realized losses.

- **Self-reported income:** The dataset contains no independent income
  verification field.

- **Single dataset source:** Findings should be validated against real
  portfolio data before any lending-policy change is implemented.

- **No fairness assessment:** Protected characteristics and fairness metrics
  were not available for evaluating potential disparate impacts.

---

## What I'd Analyze With More Data

- **Time-series default drift** — if loan origination date were available, 
  track whether default rates are worsening or improving by cohort.
- **Macro overlay** — unemployment rate, interest rate environment, or 
  regional economic indicators at time of origination.
- **Bureau score** (if available) alongside internal grade, to evaluate
  whether the internal grading system provides additional risk separation
  beyond a bureau-based credit score.
- **Recovery/collections data** — this analysis assumes 0% recovery on 
  defaults (stated as a conservative assumption); real LGD (loss given 
  default) is rarely 100%, and modeling recovery would materially change 
  the net loss figures.

---

## About

**Analyst:** Telukala Snuhith Reddy  
**Degree:** B.Tech Computer Science — SR University, Warangal (2023–2027)  
**Email:** snuhithreddy2005@gmail.com  


---

*This project simulates an institutional credit risk analytics engagement.
Dataset: Credit Risk Dataset by Laotse — Kaggle (CC0 Public Domain).
FinTrust Lending Co. and all other company names used in this project are fictional.*
