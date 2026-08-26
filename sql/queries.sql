-- FinTrust Lending Co. — SQL Analysis
-- Analyst: T Snuhith Reddy
-- Phase 6: 28 Business Intelligence Queries
-- Database: fintrust_lending | MySQL 8.0
-- Dataset: 32,416 loan records (post-cleaning)

USE fintrust_lending;

-- Q1: Overall default rate
-- Business question: What is FinTrust's current overall loan default rate across all 32,416 loans?
SELECT COUNT(*) AS total_loans,
       SUM(loan_status) AS total_defaults,
       COUNT(*) - SUM(loan_status) AS total_non_defaults,
       ROUND(AVG(loan_status) * 100.0, 2) AS default_rate_pct
FROM credit_risk;

-- Q2: Default rate by loan grade
-- Business question: Which loan grades are performing worst and what is the default rate within each grade?
SELECT loan_grade,
       COUNT(*) AS total_loans,
       SUM(loan_status) AS total_defaults,
       ROUND(AVG(loan_status) * 100.0, 2) AS default_rate
FROM credit_risk
GROUP BY loan_grade
ORDER BY default_rate DESC;

-- Q3: Default rate by loan intent
-- Business question: Which loan purposes carry the highest default risk for FinTrust?
SELECT loan_intent,
       COUNT(*) AS total_loans,
       SUM(loan_status) AS total_defaults,
       ROUND(AVG(loan_status) * 100.0, 2) AS default_rate
FROM credit_risk
GROUP BY loan_intent
ORDER BY default_rate DESC;

-- Q4: Default rate by home ownership
-- Business question: Does home ownership status reliably predict default risk?
SELECT person_home_ownership,
       COUNT(*) AS total_loans,
       ROUND(AVG(loan_status) * 100.0, 2) AS default_rate
FROM credit_risk
GROUP BY person_home_ownership
ORDER BY default_rate DESC;

-- Q5: High volume high risk loan intents
-- Business question: Which loan purposes are simultaneously high volume and high risk?
SELECT loan_intent,
       COUNT(*) AS total_loans,
       SUM(loan_status) AS total_defaults,
       ROUND(AVG(loan_status) * 100.0, 2) AS default_rate
FROM credit_risk
GROUP BY loan_intent
HAVING COUNT(*) > 5000 AND AVG(loan_status) * 100.0 > 20;

-- Q6: Age group segmentation
-- Business question: Which age group carries the highest default risk at FinTrust?
SELECT 
    CASE
        WHEN person_age < 25 THEN 'Young'
        WHEN person_age BETWEEN 25 AND 35 THEN 'Early Career'
        WHEN person_age BETWEEN 36 AND 50 THEN 'Mid Career'
        ELSE 'Senior'
    END AS age_group,
    COUNT(*) AS total_loans,
    SUM(loan_status) AS total_defaults,
    ROUND(AVG(loan_status) * 100.0, 2) AS default_rate
FROM credit_risk
GROUP BY age_group
ORDER BY default_rate DESC;

-- Q7: Income band analysis
-- Business question: At what income level does default risk drop significantly?
SELECT
    CASE 
        WHEN person_income < 30000 THEN 'Low'
        WHEN person_income BETWEEN 30000 AND 59999 THEN 'Medium'
        WHEN person_income BETWEEN 60000 AND 99999 THEN 'High'
        ELSE 'Very High'
    END AS income_band,
    COUNT(*) AS total_loans,
    SUM(loan_status) AS total_defaults,
    ROUND(AVG(loan_status) * 100.0, 2) AS default_rate
FROM credit_risk
GROUP BY income_band
ORDER BY default_rate DESC;

-- Q8: DTI risk classification
-- Business question: Does FinTrust's 35% DTI threshold correctly identify high-risk borrowers?
SELECT
    CASE 
        WHEN loan_percent_income < 0.20 THEN 'Low'
        WHEN loan_percent_income BETWEEN 0.20 AND 0.34 THEN 'Medium'
        WHEN loan_percent_income BETWEEN 0.35 AND 0.49 THEN 'High'
        ELSE 'Critical'
    END AS dti_risk,
    COUNT(*) AS total_loans,
    SUM(loan_status) AS total_defaults,
    ROUND(AVG(loan_status) * 100.0, 2) AS default_rate
FROM credit_risk
GROUP BY dti_risk
ORDER BY default_rate DESC;

-- Q9: Employment stability classification
-- Business question: Does employment stability predict loan default probability?
SELECT
    CASE
        WHEN is_unemployed = 1 THEN 'Unemployed'
        WHEN person_emp_length < 2 THEN 'New'
        WHEN person_emp_length BETWEEN 2 AND 4.9 THEN 'Developing'
        WHEN person_emp_length BETWEEN 5 AND 9.9 THEN 'Stable'
        ELSE 'Veteran'
    END AS employment_stability,
    COUNT(*) AS total_loans,
    SUM(loan_status) AS total_defaults,
    ROUND(AVG(loan_status) * 100.0, 2) AS default_rate
FROM credit_risk
GROUP BY employment_stability
ORDER BY default_rate DESC;

-- Q10: Composite risk flag
-- Business question: How many borrowers meet FinTrust's high-risk criteria and what is their default rate?
SELECT risk_flag,
       COUNT(*) AS total_borrowers,
       SUM(loan_status) AS total_defaults,
       ROUND(AVG(loan_status) * 100.0, 2) AS default_rate
FROM risk_flagged_loans
GROUP BY risk_flag
ORDER BY default_rate DESC;

-- Q11: Grade with reference data
-- Business question: How does actual default rate compare to FinTrust's internal grade classification?
SELECT
    l.grade AS loan_grade,
    l.risk_category,
    COUNT(c.loan_status) AS total_loans,
    ROUND(AVG(c.loan_status) * 100.0, 2) AS default_rate,
    l.approval_recommendation
FROM loan_grade_reference l
JOIN credit_risk c
    ON l.grade = c.loan_grade
GROUP BY
    l.grade,
    l.risk_category,
    l.approval_recommendation
ORDER BY
    l.grade;

-- Q12: Interest rate vs benchmark
-- Business question: Are FinTrust's interest rates appropriately priced for the risk level of each grade?
SELECT l.grade,
       l.typical_rate_min,
       l.typical_rate_max,
       ROUND(AVG(c.loan_int_rate), 2) AS avg_rate,
       CASE
           WHEN AVG(c.loan_int_rate) < l.typical_rate_min THEN 'Underpriced'
           WHEN AVG(c.loan_int_rate) > l.typical_rate_max THEN 'Overpriced'
           ELSE 'Appropriately priced'
       END AS pricing_status
FROM loan_grade_reference l
JOIN credit_risk c
    ON c.loan_grade = l.grade
GROUP BY l.grade, l.typical_rate_min, l.typical_rate_max
ORDER BY l.grade;

-- Q13: Risk tier assignment
-- Business question: How do actual default rates compare to expected ranges in FinTrust's risk scoring matrix?
SELECT r.risk_tier,
       r.tier_description,
       COUNT(*) AS total_loans,
       SUM(c.loan_status) AS total_defaults,
       ROUND(AVG(c.loan_status) * 100.0, 2) AS default_rate,
       r.expected_default_rate_min AS expected_min,
       r.expected_default_rate_max AS expected_max,
       CASE 
           WHEN AVG(c.loan_status) * 100.0 > r.expected_default_rate_max THEN 'Worse than expected'
           WHEN AVG(c.loan_status) * 100.0 < r.expected_default_rate_min THEN 'Better than expected'
           ELSE 'Within expected range'
       END AS expected_performance
FROM credit_risk c 
JOIN risk_scoring_matrix r 
    ON CASE
        WHEN c.loan_grade IN ('A','B') THEN 'Low'
        WHEN c.loan_grade IN ('C','D') THEN 'Medium'
        WHEN c.loan_grade IN ('E','F') THEN 'High'
        ELSE 'Critical'
    END = r.risk_tier
GROUP BY
    r.risk_tier, r.tier_description, r.expected_default_rate_max, r.expected_default_rate_min
ORDER BY default_rate DESC;

-- Q14: Financial exposure by grade
-- Business question: Which loan grades are costing FinTrust the most money in absolute default losses?
SELECT loan_grade,
       SUM(loan_amnt) AS total_loan_amount,
       SUM(CASE WHEN loan_status = 1 THEN loan_amnt ELSE 0 END) AS defaulted_amount,
       ROUND(SUM(CASE WHEN loan_status = 1 THEN loan_amnt ELSE 0 END) * 100.0 / SUM(loan_amnt), 2) AS default_percentage
FROM credit_risk
GROUP BY loan_grade
ORDER BY defaulted_amount DESC;

-- Q15: Prior default impact
-- Business question: How much more likely is a borrower with a prior default to default again with FinTrust?
WITH default_by_prior AS (
    SELECT cb_person_default_on_file,
           COUNT(*) AS total_loans,
           ROUND(AVG(loan_status) * 100.0, 2) AS default_rate
    FROM credit_risk
    GROUP BY cb_person_default_on_file
),
baseline AS (
    SELECT default_rate AS baseline_rate 
    FROM default_by_prior
    WHERE cb_person_default_on_file = 'N'
)
SELECT d.cb_person_default_on_file,
       d.total_loans,
       d.default_rate,
       ROUND(d.default_rate / b.baseline_rate, 2) AS times_more_likely
FROM default_by_prior d
CROSS JOIN baseline b
ORDER BY d.cb_person_default_on_file;

-- Q16: CTE — default rate by grade with ranking
-- Business question: Which grade ranks as the single highest default risk in FinTrust's portfolio?
WITH grade_stats AS (
    SELECT loan_grade,
           ROUND(AVG(loan_status) * 100.0, 2) AS default_rate
    FROM credit_risk
    GROUP BY loan_grade
)
SELECT loan_grade,
       default_rate,
       RANK() OVER (ORDER BY default_rate DESC) AS ranked 
FROM grade_stats;

-- Q17: CTE — above average default segments
-- Business question: Which loan intents consistently exceed FinTrust's overall average default rate?
WITH avg_default_rate AS (
    SELECT loan_intent,
           ROUND(AVG(loan_status) * 100.0, 2) AS default_rate
    FROM credit_risk
    GROUP BY loan_intent
),
overall_avg AS (
    SELECT ROUND(AVG(loan_status) * 100.0, 2) AS overall_default
    FROM credit_risk
)
SELECT a.loan_intent,
       a.default_rate,
       o.overall_default
FROM avg_default_rate a
CROSS JOIN overall_avg o
WHERE a.default_rate > o.overall_default;

-- Q18: CTE — financial exposure summary with cumulative running total
-- Business question: How does FinTrust's total default exposure accumulate as loan grade quality decreases?
WITH grade_details AS (
    SELECT loan_grade,
           SUM(loan_amnt) AS total_loan_amount,
           SUM(CASE WHEN loan_status = 1 THEN loan_amnt ELSE 0 END) AS total_defaulted_amount
    FROM credit_risk
    GROUP BY loan_grade
)
SELECT loan_grade,
       total_loan_amount,
       total_defaulted_amount,
       ROUND(total_defaulted_amount * 100.0 / SUM(total_defaulted_amount) OVER (), 2) AS percent_of_total_portfolio,
       SUM(total_defaulted_amount) OVER (ORDER BY total_defaulted_amount DESC) AS cumulative_exposure
FROM grade_details
ORDER BY total_defaulted_amount DESC;

-- Q19: CTE — high risk borrower profile
-- Business question: What does the typical high-risk FinTrust borrower look like demographically?
WITH profile AS (
    SELECT * 
    FROM credit_risk
    WHERE loan_grade IN ('E','F','G') 
      AND cb_person_default_on_file = 'Y'
),
intent AS (
    SELECT loan_intent,
           COUNT(*) AS intent_count,
           ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS rnk
    FROM profile
    GROUP BY loan_intent
)
SELECT
    (SELECT COUNT(*) FROM profile) AS total_high_risk_borrowers,
    (SELECT ROUND(AVG(person_age), 1) FROM profile) AS avg_age,
    (SELECT ROUND(AVG(person_income), 0) FROM profile) AS avg_income,
    (SELECT ROUND(AVG(loan_amnt), 0) FROM profile) AS avg_loan_amount,
    (SELECT ROUND(AVG(loan_status) * 100.0, 2) FROM profile) AS default_rate,
    loan_intent AS most_common_intent
FROM intent 
WHERE rnk = 1;

-- Q20: CTE — revenue vs loss analysis
-- Business question: Which loan grades are actually profitable for FinTrust after accounting for default losses?
WITH revenue_per_grade AS (
    SELECT loan_grade,
           ROUND(SUM(loan_amnt * loan_int_rate / 100.0), 2) AS expected_revenue
    FROM credit_risk
    WHERE loan_status = 0
    GROUP BY loan_grade
),
loss_per_grade AS (
    SELECT loan_grade,
           ROUND(SUM(loan_amnt), 2) AS total_loss
    FROM credit_risk
    WHERE loan_status = 1
    GROUP BY loan_grade
)
SELECT r.loan_grade,
       r.expected_revenue,
       COALESCE(l.total_loss, 0) AS total_loss,
       CASE
           WHEN r.expected_revenue > COALESCE(l.total_loss, 0) THEN 'Profitable'
           WHEN r.expected_revenue < COALESCE(l.total_loss, 0) THEN 'Loss'
           ELSE 'Break-even'
       END AS revenue_vs_loss
FROM revenue_per_grade r
LEFT JOIN loss_per_grade l
    ON r.loan_grade = l.loan_grade
ORDER BY r.loan_grade;

-- Q21: Window function — rank grades by default rate
-- Business question: What is the official risk ranking of all 7 loan grades in FinTrust's portfolio?
SELECT loan_grade,
       total_loans,
       default_rate,
       RANK() OVER (ORDER BY default_rate DESC) AS risk_rank
FROM (
    SELECT loan_grade,
           COUNT(*) AS total_loans,
           ROUND(AVG(loan_status) * 100.0, 2) AS default_rate
    FROM credit_risk
    GROUP BY loan_grade
) AS grade_summary
ORDER BY risk_rank;

-- Q22: Window function — running total of default exposure
-- Business question: How does FinTrust's cumulative default loss build from Grade A through Grade G?
SELECT loan_grade,
       COUNT(*) AS defaulted_loans,
       SUM(loan_amnt) AS default_exposure,
       SUM(SUM(loan_amnt)) OVER (ORDER BY loan_grade) AS running_total
FROM credit_risk
WHERE loan_status = 1
GROUP BY loan_grade
ORDER BY loan_grade;

-- Q23: Window function — income quartile analysis
-- Business question: Do higher income borrowers consistently default less across all income levels?
SELECT income_quartile,
       MIN(person_income) AS quartile_income_min,
       MAX(person_income) AS quartile_income_max,
       COUNT(*) AS total_borrowers,
       ROUND(AVG(loan_status) * 100.0, 2) AS default_rate
FROM (
    SELECT person_income,
           loan_status,
           NTILE(4) OVER (ORDER BY person_income) AS income_quartile 
    FROM credit_risk
) AS income_groups
GROUP BY income_quartile
ORDER BY income_quartile;

-- Q24: Window function — top 3 riskiest loan intents per home ownership type
-- Business question: Within each home ownership group, which loan purposes are the most dangerous?
SELECT person_home_ownership,
       loan_intent,
       total_loans,
       default_rate,
       intent_rank
FROM (
    SELECT person_home_ownership,
           loan_intent,
           COUNT(*) AS total_loans,
           ROUND(AVG(loan_status) * 100.0, 2) AS default_rate,
           ROW_NUMBER() OVER (PARTITION BY person_home_ownership ORDER BY AVG(loan_status) DESC) AS intent_rank
    FROM credit_risk
    GROUP BY person_home_ownership, loan_intent
) AS top_intents
WHERE intent_rank <= 3
ORDER BY person_home_ownership, intent_rank;

-- Q25: Window function — grade average vs individual loan outcome
-- Business question: Which individual loans were statistical outliers relative to their grade's average default rate?
SELECT loan_grade,
       loan_amnt,
       loan_status,
       loan_int_rate,
       ROUND(AVG(loan_status) OVER (PARTITION BY loan_grade), 2) AS avg_default_rate,
       ROUND(loan_status - AVG(loan_status) OVER (PARTITION BY loan_grade), 2) AS deviation
FROM credit_risk
LIMIT 20;

-- Q26: Executive summary — full portfolio risk analysis
-- Business question: What is the complete picture of FinTrust's loan portfolio performance and what actions are required?
WITH grade_summary AS (
    SELECT loan_grade,
           COUNT(*) AS total_loans,
           SUM(loan_status) AS total_defaults,
           ROUND(AVG(loan_status) * 100.0, 2) AS default_percentage,
           SUM(CASE WHEN loan_status = 1 THEN loan_amnt ELSE 0 END) AS default_exposure
    FROM credit_risk
    GROUP BY loan_grade
),
grade_with_tier AS (
    SELECT *,
           CASE 
               WHEN loan_grade IN ('A','B') THEN 'Low'
               WHEN loan_grade IN ('C','D') THEN 'Medium'
               WHEN loan_grade IN ('E','F') THEN 'High'
               ELSE 'Critical' 
           END AS risk_tier
    FROM grade_summary
)
SELECT g.loan_grade,
       l.risk_category,
       g.total_loans,
       g.total_defaults,
       g.default_exposure,
       l.approval_recommendation,
       r.expected_default_rate_min,
       r.expected_default_rate_max,
       CASE
           WHEN g.default_percentage > r.expected_default_rate_max + 5 THEN 'immediate_action_required'
           ELSE 'monitoring' 
       END AS final_action
FROM grade_with_tier g 
JOIN loan_grade_reference l
    ON g.loan_grade = l.grade
JOIN risk_scoring_matrix r 
    ON g.risk_tier = r.risk_tier
ORDER BY g.default_percentage DESC;

-- Q27: Grade x DTI interaction
-- Business question: How does default risk escalate across DTI tiers within each loan grade?
SELECT loan_grade,
       CASE
           WHEN loan_percent_income < 0.20 THEN 'Low DTI'
           WHEN loan_percent_income < 0.35 THEN 'Medium DTI'
           ELSE 'High DTI (35%+)'
       END AS dti_tier,
       COUNT(*) AS total_loans,
       ROUND(AVG(loan_status) * 100.0, 2) AS default_rate
FROM credit_risk
GROUP BY loan_grade, dti_tier
HAVING COUNT(*) >= 30
ORDER BY loan_grade, dti_tier;

-- Q28: Pipeline validation checksum — expect 32416 rows, 21.87%, $310,994,100, 7 grades
-- Business question: Does the loaded SQL database reconcile exactly with the validated dataset?
SELECT COUNT(*) AS row_count,
       ROUND(AVG(loan_status) * 100.0, 2) AS default_rate_pct,
       SUM(loan_amnt) AS total_loan_volume,
       COUNT(DISTINCT loan_grade) AS distinct_grades
FROM credit_risk;
