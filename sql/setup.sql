-- Loan Default Risk Analysis
-- Phase 1: Database Setup

-- IF NOT EXISTS prevents errors if script is run multiple times
CREATE DATABASE IF NOT EXISTS fintrust_lending;
USE fintrust_lending;

-- Create main table

CREATE TABLE IF NOT EXISTS credit_risk (
    person_age INT,
    person_income INT,
    person_home_ownership VARCHAR(20),
    person_emp_length FLOAT,
    loan_intent VARCHAR(30),
    loan_grade VARCHAR(5),
    loan_amnt INT,
    loan_int_rate FLOAT,
    loan_status INT,
    loan_percent_income FLOAT,
    cb_person_default_on_file VARCHAR(5),
    cb_person_cred_hist_length INT,
    is_unemployed INT
);

-- Verify table

SHOW TABLES;
DESCRIBE credit_risk;

-- Data imported using MySQL Workbench
-- File: credit_risk_cleaned.csv
-- Records imported: 32,416

-- Verify import

SELECT COUNT(*) AS total_rows
FROM credit_risk;

-- Preview data

SELECT *
FROM credit_risk
LIMIT 10;

CREATE INDEX idx_loan_grade ON credit_risk (loan_grade);
CREATE INDEX idx_default_on_file ON credit_risk (cb_person_default_on_file);
CREATE INDEX idx_loan_percent_income ON credit_risk (loan_percent_income);
CREATE INDEX idx_grade_default ON credit_risk (loan_grade, cb_person_default_on_file);
