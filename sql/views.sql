USE fintrust_lending;

CREATE OR REPLACE VIEW risk_flagged_loans AS
SELECT *,
    CASE
        WHEN loan_grade IN ('E','F','G')
          OR loan_percent_income > 0.40
          OR cb_person_default_on_file = 'Y'
        THEN 'High Risk'
        ELSE 'Normal Borrowers'
    END AS risk_flag
FROM credit_risk;
