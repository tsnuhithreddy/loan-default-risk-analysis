# Data Dictionary

| Column | Type | Missing % (raw) | Raw Range | Cleaned Range | Cleaning Action |
|---|---|---|---|---|---|
| person_age | int | 0.00% | 20–144 | 20–80 | Capped at 80 |
| person_income | int | 0.00% | 4,000–6,000,000 | 4,000–140,232 | Capped at IQR upper fence |
| person_home_ownership | str | 0.00% | MORTGAGE/OWN/RENT/OTHER | same | Uppercased, whitespace stripped |
| person_emp_length | float | 2.75% | 0.0–123.0 | 0.0–41.0 | Capped at (age−16); nulls filled with 0 |
| is_unemployed | int | — | — | 0/1 | New column: flags originally-null emp_length |
| loan_intent | str | 0.00% | 6 categories | same | Uppercased, whitespace stripped |
| loan_grade | str | 0.00% | A–G | same | Uppercased, whitespace stripped |
| loan_amnt | int | 0.00% | 500–35,000 | unchanged | No cleaning needed |
| loan_int_rate | float | 9.56% | 5.42–23.22 | 5.42–23.22 | Nulls filled with grade-level median |
| loan_status | int | 0.00% | 0/1 | unchanged | Target variable: 1 = default |
| loan_percent_income | float | 0.00% | 0.00–0.83 | unchanged | No cleaning needed |
| cb_person_default_on_file | str | 0.00% | Y/N | same | Uppercased, whitespace stripped |
| cb_person_cred_hist_length | int | 0.00% | 2–30 | unchanged | No cleaning needed |
