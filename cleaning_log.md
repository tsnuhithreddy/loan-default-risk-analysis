# Data Cleaning Log

## Dataset Information

- **Original Dataset:** `data/raw/credit_risk_dataset.csv`
- **Cleaned Dataset:** `data/cleaned/credit_risk_cleaned.csv`
- **Original Rows:** 32,581
- **Cleaned Rows:** 32,416
- **Rows Removed:** 165 duplicate records
- **Original Columns:** 12
- **Final Columns:** 13 (includes 1 engineered data-quality indicator)

---

## Cleaning Steps Performed

### 1. Duplicate Removal

Exact duplicate records were identified and removed from the raw dataset.

- **Duplicate rows removed:** 165
- **Remaining rows:** 32,416
- The dataframe index was reset after removal.

---

### 2. Age Validation and Capping

`person_age` contained extreme implausible values (such as ages 123 and 144). Values above 80 were capped at 80 to preserve borrower records while removing the distorting effect of extreme outliers.

- **Rows capped (>80 years):** 7 records (original values: `144, 144, 123, 123, 144, 94, 84`)
- **Cleaned age range:** 20–80 years

---

### 3. Employment-Length Validation and Capping

`person_emp_length` was validated against borrower age. A borrower cannot have worked more years than their age minus the legal minimum working age (16 years).

The maximum possible employment length was calculated as:

- **Formula:** `Maximum employment length = person_age − 16`
- **Rows capped:** 737 records with `person_emp_length > (person_age − 16)` were capped to `person_age − 16`.
- **Cleaned employment length range:** 0.0–41.0 years

---

### 4. Missing Employment-Length Flagging & Imputation

Missing values in `person_emp_length` were tracked before imputation to preserve the distinction between known zero employment and unrecorded employment information.

- **Raw dataset missingness:** 895 records (2.75% of raw records)
- **Cleaned dataset missingness:** 887 records (2.74% of post-deduplication records)
- **Action:** Created an indicator column `emp_length_missing` (`1` if originally missing, `0` if recorded).
- **Imputation:** All missing `person_emp_length` values were filled with `0.0`.
- **Note:** This variable indicates unrecorded employment information at the time of application; it should not be assumed to represent confirmed unemployment in all instances.

---

### 5. Missing Interest Rate Imputation

Missing values in `loan_int_rate` were imputed using group-level medians segmented by `loan_grade` to reflect the risk-based pricing tier of each loan.

- **Raw dataset missingness:** 3,116 records (9.56% of raw records)
- **Cleaned dataset missingness:** 3,095 records (9.55% of post-deduplication records)
- **Imputation medians by grade:**
  - **Grade A:** 7.49%
  - **Grade B:** 10.99%
  - **Grade C:** 13.48%
  - **Grade D:** 15.31%
  - **Grade E:** 16.82%
  - **Grade F:** 18.535%
  - **Grade G:** 20.16%
- **Remaining nulls:** 0

---

### 6. Extreme Income Outlier Capping

`person_income` exhibited extreme positive skewness with maximum reported income reaching $6,000,000. Values above the Interquartile Range (IQR) upper fence were capped to reduce outlier leverage on statistical metrics.

- **Q1 (25th percentile):** $38,542
- **Q3 (75th percentile):** $79,218
- **IQR:** Q3 − Q1 = $40,676
- **Upper Fence:** Q3 + (1.5 × IQR) = $140,232
- **Rows capped (income > $140,232):** 1,478 records
- **Cleaned income range:** $4,000 – $140,232

---

### 7. Categorical Standardization

Categorical string columns were standardized by removing leading/trailing whitespace and converting all characters to uppercase.

- **Columns standardized:**
  - `person_home_ownership` (`MORTGAGE`, `RENT`, `OWN`, `OTHER`)
  - `loan_intent` (`DEBTCONSOLIDATION`, `EDUCATION`, `HOMEIMPROVEMENT`, `MEDICAL`, `PERSONAL`, `VENTURE`)
  - `loan_grade` (`A`, `B`, `C`, `D`, `E`, `F`, `G`)
  - `cb_person_default_on_file` (`Y`, `N`)

---

### 8. Final Post-Cleaning Quality Validation

A final automated validation block was executed to guarantee data integrity:

- **Missing values:** 0 across all 13 columns.
- **Duplicate records:** 0 duplicate rows remaining.
- **Age boundaries:** All values strictly within [20, 80].
- **Employment length:** All values >= 0.0 and <= (person_age - 16).
- **Income boundaries:** All values <= $140,232.
- **Engineered Flag:** `emp_length_missing` strictly binary (`0` or `1`).
- **Final dataset dimensions:** 32,416 rows × 13 columns.
