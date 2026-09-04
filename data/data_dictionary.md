# Data Dictionary

This document describes the fields in the FinTrust credit-risk dataset, including their data types, raw missingness, observed ranges, cleaning actions, and analytical roles.

---

## Cleaned Dataset Fields

| Column                       | Type  | Missing % (Raw) | Raw Range / Categories        | Cleaned Range / Categories | Cleaning Action                                                                    | Role                                                |
| ---------------------------- | ----- | --------------: | ----------------------------- | -------------------------- | ---------------------------------------------------------------------------------- | --------------------------------------------------- |
| `person_age`                 | int   |           0.00% | 20–144                        | 20–80                      | Values above 80 capped at 80                                                       | Borrower characteristic                             |
| `person_income`              | int   |           0.00% | 4,000–6,000,000               | 4,000–140,232              | Values above IQR upper fence ($140,232) capped                                     | Borrower characteristic                             |
| `person_home_ownership`      | str   |           0.00% | MORTGAGE / OWN / RENT / OTHER | Same categories            | Whitespace stripped and values uppercased                                          | Borrower characteristic                             |
| `person_emp_length`          | float |           2.75% | 0.0–123.0                     | 0.0–41.0                   | Values above `person_age − 16` capped; missing values filled with 0.0              | Borrower characteristic                             |
| `emp_length_missing`         | int   |               — | —                             | 0 / 1                      | Data-quality indicator: 1 if employment length was originally missing, 0 otherwise | Data-quality indicator                              |
| `loan_intent`                | str   |           0.00% | 6 categories                  | Same 6 categories          | Whitespace stripped and values uppercased                                          | Loan characteristic                                 |
| `loan_grade`                 | str   |           0.00% | A–G                           | A–G                        | Whitespace stripped and values uppercased                                          | Credit-risk indicator                               |
| `loan_amnt`                  | int   |           0.00% | 500–35,000                    | 500–35,000                 | No cleaning required                                                               | Loan characteristic                                 |
| `loan_int_rate`              | float |           9.56% | 5.42–23.22                    | 5.42–23.22                 | Missing values imputed using median rate within `loan_grade`                       | Loan characteristic                                 |
| `loan_status`                | int   |           0.00% | 0 / 1                         | 0 / 1                      | No cleaning required                                                               | Target variable: 1 = default, 0 = non-default       |
| `loan_percent_income`        | float |           0.00% | 0.00–0.83                     | 0.00–0.83                  | Recalculated after `person_income` capping as `loan_amnt / person_income`, rounded to two decimal places | Loan-to-Income (LTI) affordability / risk indicator |
| `cb_person_default_on_file`  | str   |           0.00% | Y / N                         | Y / N                      | Whitespace stripped and values uppercased                                          | Prior credit-default indicator                      |
| `cb_person_cred_hist_length` | int   |           0.00% | 2–30                          | 2–30                       | No cleaning required                                                               | Credit-history characteristic                       |

> **Note on Ranges:** Raw ranges represent observed values in the raw dataset. Cleaned ranges reflect the mathematical result of the outlier capping and data cleaning rules applied to this dataset, rather than universal institutional underwriting policy limits.

> **Important note on `loan_percent_income`:** This field is the source-provided loan-to-income (LTI) ratio and is preserved as recorded. Because `person_income` is capped during cleaning, the stored `loan_percent_income` value is not necessarily equal to `loan_amnt / person_income` after cleaning. Analyses using LTI therefore use the source-provided `loan_percent_income` field rather than recalculating it from the cleaned income value.

---

## Engineered Cleaning Feature

### `emp_length_missing`

This binary indicator is created during the data-cleaning process before missing `person_emp_length` values are filled with `0.0`.

| Value | Meaning                                                               |
| ----- | --------------------------------------------------------------------- |
| `0`   | Employment-length information was recorded                            |
| `1`   | Employment-length information was originally missing (imputed as 0.0) |

**Important:** This variable indicates unrecorded/missing employment information at the time of application; it should not be assumed to represent confirmed unemployment in all instances.

---

## Target Variable

### `loan_status`

The target variable represents the observed loan outcome:

| Value | Meaning              |
| ----- | -------------------- |
| `0`   | Repaid / non-default |
| `1`   | Default              |

The cleaned dataset contains **32,416 loans**, with an observed default rate of **21.87%** (7,089 defaults).

---

## EDA / Analytical Variables

The following variables are constructed during SQL and Python exploratory data analysis. They are analytical groupings rather than raw dataset columns:

| Variable                | Description                          | Definition / Tiers                                                                |
| ----------------------- | ------------------------------------ | --------------------------------------------------------------------------------- |
| `lti_risk` / `lti_tier` | Loan-to-Income (LTI) Ratio risk tier | Low (<20%), Medium (20–34%), High (35–49%), Critical (≥50%)                       |
| `income_band`           | Borrower income classification       | Low (<$30k), Medium ($30k–$60k), High ($60k–$100k), Very High (≥$100k)            |
| `age_group`             | Borrower age classification          | Young (<25), Early Career (25–35), Mid Career (36–49), Senior (≥50)               |
| `risk_flag`             | Composite Early Warning Risk Flag    | `High Risk` if Grade ∈ {E,F,G} OR LTI > 40% OR Prior Default = 'Y', else `Normal` |

---

## LTI Ratio Definition

### `loan_percent_income`

`loan_percent_income` represents the loan amount relative to the borrower's annual income, expressed as a decimal.

Conceptually:

```text
LTI = Loan Amount / Annual Income
```

For example:

```text
0.40 = 40% of annual income
```

The project uses the source-provided `loan_percent_income` value for LTI-based analysis.

**LTI should not be referred to as conventional Debt-to-Income (DTI)** because the dataset does not contain the borrower's total debt obligations. The analysis therefore uses the term **Loan-to-Income (LTI)** throughout.

---

## Risk Flag Definition

### `risk_flag`

The composite early-warning flag identifies borrowers who meet at least one of the following observed risk conditions:

```text
Grade ∈ {E, F, G}
OR
LTI > 40%
OR
Prior Default = Y
```

These conditions are used for **historical risk segmentation** within the dataset.

The resulting flag should not be interpreted as a validated predictive model or as a production underwriting policy without out-of-sample validation.

---

## Financial Metric Interpretation

The project calculates a simplified financial exposure proxy using:

```text
One-Year Simple-Interest Proxy
=
Interest from Non-Defaulted Loans
−
Defaulted Principal Exposure
```

This is an **analytical proxy**, not observed accounting profit, realized loss, or actual net portfolio performance.

The dataset does not contain sufficient information to calculate realized loan losses because it does not provide items such as recovery amounts, loan tenure, repayment schedules, funding costs, operating costs, or actual cash flows.

---

## Cleaning Pipeline Reference

The complete automated cleaning pipeline is implemented in:

```text
clean_data.py
```
