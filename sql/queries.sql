-- FinTrust Lending Co. — SQL Analysis
-- Analyst: T Snuhith Reddy
-- Phase 6: 26 Business Intelligence Queries
-- Database: fintrust_lending | MySQL 8.0
-- Dataset: 32,416 loan records (post-cleaning)

USE fintrust_lending;

-- Q1: Overall default rate
-- Business question: What is FinTrust's current overall loan default rate across all 32,416 loans?
select count(*) as total_loans,
sum(loan_status) as total_defaults,
count(*)-sum(loan_status) as total_non_defaults,
round(avg(loan_status)*100,2) as default_rate_pct
from credit_risk;

-- Q2: Default rate by loan grade
-- Business question: Which loan grades are performing worst and what is the default rate within each grade?
select loan_grade,count(*) as total_loans,sum(loan_status) as total_defaults,round(avg(loan_status)*100,2) as default_rate
from credit_risk
group by loan_grade
order by default_rate desc;

-- Q3: Default rate by loan intent
-- Business question: Which loan purposes carry the highest default risk for FinTrust?
select loan_intent,count(*) as total_loans,sum(loan_status) as total_defaults,round(avg(loan_status)*100,2) as default_rate
from credit_risk
group by loan_intent
order by default_rate desc;

-- Q4: Default rate by home ownership
-- Business question: Does home ownership status reliably predict default risk?
select person_home_ownership,count(*) as total_loans,round(avg(loan_status)*100,2) as default_rate
from credit_risk
group by person_home_ownership
order by default_rate desc;

-- Q5: High volume high risk loan intents
-- Business question: Which loan purposes are simultaneously high volume and high risk?
select loan_intent,count(*) as total_loans,sum(loan_status) as total_defaults,round(avg(loan_status)*100,2) as default_rate
from credit_risk
group by loan_intent
having count(*)>5000 and avg(loan_status)*100>20;

-- Q6: Age group segmentation
-- Business question: Which age group carries the highest default risk at FinTrust?
select 
case
when person_age<25 then 'Young'
when person_age between 25 and 35 then 'Early Career'
when person_age between 36 and 50 then 'Mid Career'
when person_age>50 then 'Senior'
end as age_group,
count(*) as total_loans,
sum(loan_status) as total_defaults,
round(avg(loan_status)*100,2) as default_rate
from credit_risk
group by age_group
order by default_rate desc;

-- Q7: Income band analysis
-- Business question: At what income level does default risk drop significantly?
select
case 
when person_income<30000 then 'Low'
when person_income between 30000 and 59999 then 'medium'
when person_income between 60000 and 99999 then 'High'
else 'Very High'
end as income_band,
count(*) as total_loans,sum(loan_status) as total_defaults,
round(avg(loan_status)*100,2) as default_rate
from credit_risk
group by income_band
order by default_rate desc;

-- Q8: DTI risk classification
-- Business question: Does FinTrust's 35% DTI threshold correctly identify high-risk borrowers?
select
case 
when loan_percent_income<0.20 then 'Low'
when loan_percent_income between 0.20 and 0.34 then 'Medium'
when loan_percent_income between 0.35 and 0.49 then 'High'
else 'Critical'
end as dti_risk,
count(*) as total_loans,sum(loan_status) as total_defaults,
round(avg(loan_status)*100,2) as default_rate
from credit_risk
group by dti_risk
order by default_rate desc;

-- Q9: Employment stability classification
-- Business question: Does employment stability predict loan default probability?
select
case
when is_unemployed=1 then 'Unemployed'
when person_emp_length<2 then 'New'
when person_emp_length between 2 and 4.9 then 'Developing'
when person_emp_length between 5 and 9.9 then 'Stable'
else 'Veteran'
end as employment_stability,
count(*) as total_loans,sum(loan_status) as total_defaults,
round(avg(loan_status)*100,2) as default_rate
from credit_risk
group by employment_stability
order by default_rate desc;

-- Q10: Composite risk flag
-- Business question: How many borrowers meet FinTrust's high-risk criteria and what is their default rate?
select risk_flag,
count(*) as total_borrowers,sum(loan_status) as total_defaults,
round(avg(loan_status)*100,2) as default_rate
from risk_flagged_loans
group by risk_flag
order by default_rate DESC;

-- Q11: Grade with reference data
-- Business question: How does actual default rate compare to FinTrust's internal grade classification?
SELECT
    l.grade AS loan_grade,
    l.risk_category,
    COUNT(c.loan_status) AS total_loans,
    ROUND(AVG(c.loan_status) * 100, 2) AS default_rate,
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
select l.grade,l.typical_rate_min,l.typical_rate_max,round(avg(c.loan_int_rate),2) as avg_rate,
case
when avg(c.loan_int_rate)< l.typical_rate_min then 'Underpriced'
when avg(c.loan_int_rate)> l.typical_rate_max then 'Overpriced'
else 'Appropriately priced'
end as pricing_status
from loan_grade_reference l
join credit_risk c
on c.loan_grade=l.grade
group by l.grade,l.typical_rate_min, l.typical_rate_max
order by l.grade;

-- Q13: Risk tier assignment
-- Business question: How do actual default rates compare to expected ranges in FinTrust's risk scoring matrix?
select r.risk_tier,r.tier_description,count(*) as total_loans,
sum(c.loan_status) as total_defaults,round(avg(c.loan_status)*100,2) as default_rate,
r.expected_default_rate_min as expected_min,r.expected_default_rate_max as expected_max,
case 
when avg(c.loan_status)*100>r.expected_default_rate_max then 'Worse than expected'
when avg(c.loan_status)*100<r.expected_default_rate_min then 'Better than expected'
else 'Within expected range'
end as expected_performance
from credit_risk c 
join risk_scoring_matrix r 
on case
when c.loan_grade in ('A','B') then 'Low'
when c.loan_grade in ('C','D') then 'Medium'
when c.loan_grade in ('E','F') then 'High'
else 'Critical'
end=r.risk_tier
group by
r.risk_tier,r.tier_description,r.expected_default_rate_max,r.expected_default_rate_min
order by default_rate desc;

-- Q14: Financial exposure by grade
-- Business question: Which loan grades are costing FinTrust the most money in absolute default losses?
select loan_grade,sum(loan_amnt) as total_loan_amount,
sum(
case
when loan_status=1 then loan_amnt
else 0
end) as defaulted_amount,
round(sum(
case
when loan_status=1 then loan_amnt
else 0
end)*100/Sum(loan_amnt),2) as default_percentage
from credit_risk
group by loan_grade
order by defaulted_amount desc;

-- Q15: Prior default impact
-- Business question: How much more likely is a borrower with a prior default to default again with FinTrust?
with default_by_prior as (
    select cb_person_default_on_file, count(*) as total_loans,
           round(avg(loan_status)*100, 2) as default_rate
    from credit_risk
    group by cb_person_default_on_file
),
baseline as (
    select default_rate as baseline_rate from default_by_prior
    where cb_person_default_on_file = 'N'
)
select d.cb_person_default_on_file, d.total_loans, d.default_rate,
       round(d.default_rate / b.baseline_rate, 2) as times_more_likely
from default_by_prior d
cross join baseline b
order by d.cb_person_default_on_file;

-- Q16: CTE — default rate by grade with ranking
-- Business question: Which grade ranks as the single highest default risk in FinTrust's portfolio?
with grade_stats as
( select loan_grade,round(avg(loan_status)*100,2) as default_rate
from credit_risk
group by loan_grade)
select loan_grade,default_rate,rank() over(order by default_rate desc) as ranked from grade_stats;

-- Q17: CTE — above average default segments
-- Business question: Which loan intents consistently exceed FinTrust's overall average default rate?
with avg_default_rate as
(select loan_intent,round(avg(loan_status)*100,2) as default_rate
from credit_risk
group by loan_intent),
overall_avg as 
(select round(avg(loan_status)*100,2) as overall_default
from credit_risk)
select a.loan_intent,a.default_rate,o.overall_default
from avg_default_rate a
cross join overall_avg o
where a.default_rate>o.overall_default;

-- Q18: CTE — financial exposure summary with cumulative running total
-- Business question: How does FinTrust's total default exposure accumulate as loan grade quality decreases?
with grade_details as
(select loan_grade,sum(loan_amnt) as total_loan_amount,
sum(case
when loan_status=1 then loan_amnt else 0 end) as total_defaulted_amount
from credit_risk
group by loan_grade)
select loan_grade,total_loan_amount,total_defaulted_amount,
round(total_defaulted_amount*100/sum(total_defaulted_amount) over(),2) as percent_of_total_portfolio,
sum(total_defaulted_amount) over(order by total_defaulted_amount desc) as cumulative_exposure
from grade_details
order by total_Defaulted_amount desc;

-- Q19: CTE — high risk borrower profile
-- Business question: What does the typical high-risk FinTrust borrower look like demographically?
with profile as
(select * from credit_risk
where loan_grade in ('E','F','G') and cb_person_default_on_file='Y'),
intent as
( select loan_intent,count(*) as intent_count,
row_number() over(order by count(*) desc) as rnk
from profile
group by loan_intent)
select
(select count(*) from profile) as total_high_risk_borrowers,
(select round(avg(person_age),1) from profile) as avg_age,
(select round(avg(person_income),0) from profile) as avg_income,
(select round(avg(loan_amnt),0) from profile) as avg_loan_amount,
(select round(avg(loan_status)*100,2) from profile) as default_rate,
loan_intent as most_common_intent
from intent where rnk=1;

-- Q20: CTE — revenue vs loss analysis
-- Business question: Which loan grades are actually profitable for FinTrust after accounting for default losses?
with revenue_per_grade as
( select loan_grade,round(sum(loan_amnt*loan_int_rate/100),2) as expected_revenue
from credit_risk
where loan_status=0
group by loan_grade
),loss_per_grade as
(select loan_grade,round(sum(loan_amnt),2) as total_loss
from credit_risk
where loan_status=1
group by loan_grade)
select r.loan_grade,r.expected_revenue,coalesce(l.total_loss,0) as total_loss,
case
when r.expected_revenue>coalesce(l.total_loss,0) then 'Profitable'
when r.expected_revenue<coalesce(l.total_loss,0) then 'Loss'
else 'No profit and loss'
end as revenue_vs_loss
from revenue_per_grade r
left join loss_per_grade l
on r.loan_grade=l.loan_grade
order by r.loan_grade;

-- Q21: Window function — rank grades by default rate
-- Business question: What is the official risk ranking of all 7 loan grades in FinTrust's portfolio?
select loan_grade,total_loans,default_rate,rank() over(order by default_rate desc) as risk_rank
from (
select loan_grade,count(*) as total_loans,
round(avg(loan_status)*100,2) as default_rate
from credit_risk
group by loan_grade) as grade_summary
order by risk_rank;

-- Q22: Window function — running total of default exposure
-- Business question: How does FinTrust's cumulative default loss build from Grade A through Grade G?
select loan_grade,count(*) as defaulted_loans,sum(loan_amnt) as default_exposure,sum(sum(loan_amnt)) over(order by loan_grade) as running_total
from credit_risk
where loan_status=1
group by loan_grade
order by loan_grade;

-- Q23: Window function — income quartile analysis
-- Business question: Do higher income borrowers consistently default less across all income levels?
select income_quartile,min(person_income) as quartile_income_min,max(person_income) as quartile_income_max,
count(*) as total_borrowers,round(avg(loan_status)*100,2) as default_rate
from(
select person_income,loan_status,
ntile(4) over(order by person_income) as income_quartile from credit_risk) as income_groups
group by income_quartile
order by income_quartile; 

-- Q24: Window function — top 3 riskiest loan intents per home ownership type
-- Business question: Within each home ownership group, which loan purposes are the most dangerous?
select person_home_ownership,loan_intent,total_loans,default_rate,intent_rank
from (
select person_home_ownership,loan_intent,count(*) as total_loans,
round(avg(loan_status)*100,2) as default_rate,
row_number() over(partition by person_home_ownership order by avg(loan_status) desc) as intent_rank
from credit_risk
group by person_home_ownership,loan_intent) as top_intents
where intent_rank<=3
order by person_home_ownership,intent_rank;

-- Q25: Window function — grade average vs individual loan outcome
-- Business question: Which individual loans were statistical outliers relative to their grade's average default rate?
select loan_grade,loan_amnt,loan_status,loan_int_rate,
round(avg(loan_status) over(partition by loan_grade),2) as avg_default_rate,
round(loan_status-avg(loan_status) over(partition by loan_grade),2) as deviation
from credit_risk
limit 20;

-- Q26: Executive summary — full portfolio risk analysis
-- Business question: What is the complete picture of FinTrust's loan portfolio performance and what actions are required?
with grade_summary as
(select loan_grade,count(*) as total_loans,sum(loan_status) as total_defaults,round(avg(loan_status)*100,2) as default_percentage,
sum(case when loan_status=1 then loan_amnt else 0 end) as default_exposure
from credit_risk
group by loan_grade),
grade_with_tier as
(select *,
case when loan_grade in ('A','B') then 'Low'
when loan_grade in ('C','D') then 'Medium'
when loan_grade in ('E','F') then 'High'
else 'Critical' end as risk_tier
from grade_summary)
select g.loan_grade,l.risk_category,g.total_loans,g.total_defaults,g.default_exposure,l.approval_recommendation,r.expected_default_rate_min,r.expected_default_rate_max,
case
when g.default_percentage>r.expected_default_rate_max+5 then 'immediate_action_required'
else 'monitoring' end as final_action
from grade_with_tier g join loan_grade_reference l
on g.loan_grade=l.grade
join risk_scoring_matrix r on g.risk_tier=r.risk_tier
order by g.default_percentage desc;

-- Q27: Grade x DTI interaction
select loan_grade,
case
when loan_percent_income<0.20 then 'Low DTI'
when loan_percent_income<0.35 then 'Medium DTI'
else 'High DTI (35%+)'
end as dti_tier,
count(*) as total_loans, round(avg(loan_status)*100,2) as default_rate
from credit_risk
group by loan_grade, dti_tier
having count(*)>=30
order by loan_grade, dti_tier;

-- Q28: Pipeline validation checksum — expect 32416 rows, 21.87%, $310,994,100, 7 grades
select count(*) as row_count, round(avg(loan_status)*100,2) as default_rate_pct,
sum(loan_amnt) as total_loan_volume, count(distinct loan_grade) as distinct_grades
from credit_risk;
