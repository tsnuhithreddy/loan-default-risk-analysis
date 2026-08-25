# Data Dictionary

This document describes the fields in the FinTrust credit-risk dataset,
including their data types, raw missingness, observed ranges, cleaning
actions, and analytical roles.

## Cleaned Dataset Fields

| Column | Type | Missing % (Raw) | Raw Range / Categories | Cleaned Range / Categories | Cleaning Action | Role |
|---|---|---:|---|---|---|---|
| `person_age` | int | 0.00% | 20–144 | 20–80 | Values above 80 capped at 80 | Borrower characteristic |
| `person_income` | int | 0.00% | 4,000–6,000,000 | 4,000–140,232 | Values above the IQR upper fence capped | Borrower characteristic |
| `person_home_ownership` | str | 0.00% | MORTGAGE / OWN / RENT / OTHER | Same categories | Whitespace stripped and values uppercased | Borrower characteristic |
| `person_emp_length` | float | 2.75% | 0.0–123.0 | Non-negative; capped based on borrower age | Values above `person_age − 16` capped; missing values filled with 0 | Borrower characteristic |
| `emp_length_missing` | int | — | — | 0 / 1 | New indicator: 1 if employment-length information was originally missing | Data-quality indicator |
| `loan_intent` | str | 0.00% | Six loan-intent categories | Same categories | Whitespace stripped and values uppercased | Loan characteristic |
| `loan_grade` | str | 0.00% | A–G | A–G | Whitespace stripped and values uppercased | Credit-risk indicator |
| `loan_amnt` | int | 0.00% | 500–35,000 | Unchanged | No cleaning required | Loan characteristic |
| `loan_int_rate` | float | 9.56% | 5.42–23.22 | 5.42–23.22 | Missing values imputed using the median rate within `loan_grade` | Loan characteristic |
| `loan_status` | int | 0.00% | 0 / 1 | 0 / 1 | No cleaning required | Target variable: 1 = default, 0 = non-default |
| `loan_percent_income` | float | 0.00% | 0.00–0.83 | Unchanged | No cleaning required | Affordability / risk indicator |
| `cb_person_default_on_file` | str | 0.00% | Y / N | Y / N | Whitespace stripped and values uppercased | Prior credit-default indicator |
| `cb_person_cred_hist_length` | int | 0.00% | 2–30 | Unchanged | No cleaning required | Credit-history characteristic |

> **Note:** Raw ranges represent the observed values in the original
> dataset. Cleaned ranges describe the result of the implemented cleaning
> rules and should not be interpreted as universal business-policy limits.

## Engineered Cleaning Feature

### `emp_length_missing`

This binary indicator is created during the cleaning process before missing
`person_emp_length` values are filled with `0`.

| Value | Meaning |
|---|---|
| `0` | Employment-length information was available |
| `1` | Employment-length information was originally missing |

**Important:** This variable indicates missing employment information. It does
not establish that the borrower was unemployed.

## Target Variable

### `loan_status`

The target variable represents the observed loan outcome:

| Value | Meaning |
|---|---|
| `0` | Repaid / non-default |
| `1` | Default |

The cleaned dataset contains **32,416 loans**, with an observed default rate
of approximately **21.87%**.

## EDA / Analytical Variables

The following variables are created during exploratory analysis and risk
analysis. They are **not part of the core cleaned dataset unless explicitly
saved by the notebook**.

| Variable | Description |
|---|---|
| `dti_tier` | Loan-to-Income Ratio risk classification used for EDA |
| `income_band` | Borrower income classification used for EDA |
| `age_group` | Borrower age classification used for EDA |
| `risk_flag` | Composite analytical risk flag: `High Risk` or `Normal` |

These variables are analytical constructs used to investigate observed risk
patterns. They should not be interpreted as independently validated
production underwriting rules.

## Cleaning Rules Summary

The cleaning pipeline performs the following operations:

1. Removes exact duplicate records.
2. Caps `person_age` values above 80.
3. Caps impossible `person_emp_length` values based on borrower age.
4. Creates `emp_length_missing` before filling missing employment length with 0.
5. Imputes missing `loan_int_rate` using loan-grade-level medians.
6. Caps extreme `person_income` values using the IQR upper fence.
7. Standardizes selected categorical variables.
8. Runs final validation checks for missing values, duplicates, age,
   employment length, and engineered indicators.

The reproducible cleaning pipeline is implemented in:

```text
clean_data.py
