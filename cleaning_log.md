# Data Cleaning Log

## Dataset Information

- Original Dataset: credit_risk_dataset.csv
- Cleaned Dataset: credit_risk_cleaned.csv

## Cleaning Steps Performed

- Removed duplicate records
- Handled missing values
- Created `is_unemployed` feature
- Corrected unrealistic employment length values
- Capped unrealistic age values
- Verified data types
- Performed final quality checks

## Final Dataset Summary

Rows 32416
Columns 13
Missing values 0
Duplicate rows 0

## Status

Data cleaning completed successfully.
Dataset is ready for SQL analysis and Power BI dashboard development.

## EDA columns created (not saved to CSV — analysis only)

- dti_tier: DTI risk classification (Low/Medium/High/Critical)
- income_band: Income band classification (Low/Medium/High/Very High)
- age_group: Age group classification (Young/Early Career/Mid Career/Senior)
- risk_flag: Composite risk flag (High Risk / Normal)
