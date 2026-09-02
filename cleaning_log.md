# Data Cleaning Log

## Dataset Information

- **Original Dataset:** `data/raw/credit_risk_dataset.csv`
- **Cleaned Dataset:** `data/cleaned/credit_risk_cleaned.csv`
- **Original Rows:** 32,581
- **Cleaned Rows:** 32,416
- **Rows Removed:** 165 duplicate records
- **Original Columns:** 12
- **Final Columns:** 13 (includes 1 engineered data-quality indicator: `emp_length_missing`)

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

`person_emp_length` was validated against borrower age. For data-quality validation, the maximum plausible employment length was defined as `person_age - 16`, assuming employment cannot begin before age 16.

The maximum possible employment length was calculated as:

- **Formula:** `Maximum employment length = person_age − 16`
- **Rows capped:** 737 records with `person_emp_length > (person_age − 16)` were capped to `person_age − 16`.
- **Cleaned employment length range:** 0.0–41.0 years

---

### 4. Missing Employment-Length Flagging & Imputation

Missing values in `person_emp_length` were tracked before imputation to preserve the distinction between known zero employment and unrecorded employment information.

- **Raw dataset missingness:** 895 records (2.75% of 32,581 raw rows)
- **After duplicate removal:** 887 records (2.74% of 32,416 retained rows)
- **Action:** Created a missingness indicator column `emp_length_missing` (`1` if `person_emp_length` was originally missing, `0` otherwise).
- **Imputation:** All missing `person_emp_length` values were filled with `0.0`.
- **Final cleaned dataset missingness:** 0
- **Note:** This variable indicates unrecorded employment information at the time of application; it should not be assumed to represent confirmed unemployment in all instances.

---

### 5. Missing Interest Rate Imputation

Missing values in `loan_int_rate` were imputed using the median interest rate within each `loan_grade` group, preserving the observed grade-level pricing structure.

- **Raw dataset missingness:** 3,116 records (9.56% of 32,581 raw rows)
- **After duplicate removal:** 3,095 records (9.55% of 32,416 retained rows)
- **Imputation medians by grade:**
  - **Grade A:** 7.49%
  - **Grade B:** 10.99%
  - **Grade C:** 13.48%
  - **Grade D:** 15.31%
  - **Grade E:** 16.82%
  - **Grade F:** 18.535%
  - **Grade G:** 20.16%
- **Final cleaned dataset missingness:** 0

---

### 6. High Income Capping (IQR Upper Fence)

`person_income` exhibited extreme positive skewness with maximum reported income reaching $6,000,000. Values above the Interquartile Range (IQR) upper fence were capped to reduce outlier leverage on statistical metrics.

- **Q1 (25th percentile):** $38,542
- **Q3 (75th percentile):** $79,218
- **IQR:** Q3 − Q1 = $40,676
- **Upper Fence:** Q3 + (1.5 × IQR) = $140,232
- **Rows capped (income > $140,232):** 1,478 records
- **Cleaned income range:** $4,000 – $140,232
* **Methodology Note:** `loan_percent_income` is recalculated after income capping using `loan_amnt / person_income` and rounded to two decimal places so that the derived loan-to-income (LTI) ratio remains consistent with the cleaned income values.


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

Automated validation checks were executed for nulls, duplicates, age bounds, employment length, engineered flag validity, and dataset dimensions:

- **Missing values:** 0 across all 13 columns.
- **Duplicate records:** 0 duplicate rows remaining.
- **Age boundaries:** All values within the validated range 20–80 years.
- **Employment length:** All values >= 0.0 and <= (person_age - 16).
- **Income boundaries:** All values <= $140,232.
- **Engineered Flag:** `emp_length_missing` contains only `0` and `1`.
- **Final dataset dimensions:** 32,416 rows × 13 columns.
check this
