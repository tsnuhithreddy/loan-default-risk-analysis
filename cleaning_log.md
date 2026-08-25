# Data Cleaning Log

## Dataset Information

- **Original Dataset:** `data/raw/credit_risk_dataset.csv`
- **Cleaned Dataset:** `data/cleaned/credit_risk_cleaned.csv`
- **Original Rows:** 32,581
- **Cleaned Rows:** 32,416
- **Rows Removed:** 165 duplicate records
- **Final Columns:** 13

## Cleaning Steps Performed

### 1. Duplicate Removal

Exact duplicate records were removed from the raw dataset.

- Duplicate rows removed: **165**
- The dataframe index was reset after removal.

### 2. Age Validation and Capping

`person_age` values above 80 were capped at 80 to limit the influence of implausible extreme ages.

The cleaned dataset was validated to ensure that all ages fall within the expected range of **18–80 years**.

### 3. Employment-Length Validation

`person_emp_length` was checked against the borrower's age.

A maximum possible employment length was calculated as:

```text
Maximum employment length = person_age − 16
