-- FinTrust Lending Co. — Analytical Reference Tables
-- Description: Simulated benchmark matrices used for risk evaluation and comparative SQL analysis.
-- Note: These benchmarks represent analytical models for portfolio evaluation, not live institutional underwriting policies.

USE fintrust_lending;

-- Reference table for loan grade benchmarks
CREATE TABLE IF NOT EXISTS loan_grade_reference (
    grade VARCHAR(5) PRIMARY KEY,
    grade_description VARCHAR(50),
    risk_category VARCHAR(20),
    typical_rate_min FLOAT,
    typical_rate_max FLOAT,
    approval_recommendation VARCHAR(30)
);

-- Insert simulated loan grade benchmark data
INSERT INTO loan_grade_reference VALUES
('A', 'Excellent credit', 'Low Risk', 5.0, 8.5, 'Approve'),
('B', 'Very good credit', 'Low Risk', 8.5, 11.0, 'Approve'),
('C', 'Good credit', 'Medium Risk', 11.0, 13.5, 'Approve with review'),
('D', 'Fair credit', 'Medium Risk', 13.5, 16.0, 'Approve with conditions'),
('E', 'Poor credit', 'High Risk', 16.0, 18.5, 'Manual review required'),
('F', 'Very poor credit', 'High Risk', 18.5, 21.0, 'Decline recommended'),
('G', 'Highest risk', 'Critical Risk', 21.0, 25.0, 'Decline');

-- Verify loan grade benchmark data
SELECT * FROM loan_grade_reference;

-- Reference table for analytical risk scoring matrix
CREATE TABLE IF NOT EXISTS risk_scoring_matrix (
    risk_tier VARCHAR(20) PRIMARY KEY,
    tier_description VARCHAR(100),
    recommended_action VARCHAR(50),
    expected_default_rate_min FLOAT,
    expected_default_rate_max FLOAT
);

-- Insert simulated risk scoring benchmark data
INSERT INTO risk_scoring_matrix VALUES
('Low', 'Grade A-B, Loan-to-Income Ratio < 20%, clean history', 'Auto approve', 0.0, 8.0),
('Medium', 'Grade C-D, Loan-to-Income Ratio 20-35%, clean history', 'Approve with review', 8.0, 20.0),
('High', 'Grade E-F, Loan-to-Income Ratio 35-50%, or prior default', 'Manual review', 20.0, 40.0),
('Critical', 'Grade G, Loan-to-Income Ratio > 50%, prior default on file', 'Decline', 40.0, 100.0);

-- Verify risk scoring benchmark data
SELECT * FROM risk_scoring_matrix;
