CREATE DATABASE IF NOT EXISTS Employee_Churn;
USE Employee_Churn;

--  Show All Things Of DataBase
SELECT * FROM `hr & employee-attrition`;

-- Change the table name
RENAME TABLE `hr & employee-attrition` TO employee_attrition;

-- Again see the all things means entire table
SELECT * FROM employee_attrition;

-- 1.Workforce Overview (Baseline Metrics)
SELECT 
COUNT(*) AS TotalEmployees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS EmployeesLeft,
SUM(CASE WHEN Attrition='No' THEN 1 ELSE 0 END) AS EmployeesRetained,
ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) AS AttritionRate
FROM employee_attrition;

-- 2.Department Attrition Risk Ranking
SELECT 
Department,
COUNT(*) AS TotalEmployees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS AttritionCount,
ROUND(AVG(MonthlyIncome),0) AS AvgSalary,
ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) AS AttritionRate
FROM  employee_attrition
GROUP BY Department
ORDER BY AttritionRate DESC;

-- 3. Job Role Risk Segmentation
SELECT 
JobRole,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS AttritionCount,
ROUND(AVG(MonthlyIncome),0) AS AvgIncome,
ROUND(AVG(JobSatisfaction),2) AS AvgSatisfaction,
ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) AS AttritionRate
FROM employee_attrition
GROUP BY JobRole
ORDER BY AttritionRate DESC;
-- Purpose -> Identifies high-risk job roles with lower satisfaction or pay.

-- 4. Salary Band vs Attrition
SELECT 
CASE
WHEN MonthlyIncome < 3000 THEN 'Low Salary'
WHEN MonthlyIncome BETWEEN 3000 AND 7000 THEN 'Medium Salary'
ELSE 'High Salary'
END AS SalaryBand,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS AttritionCount,
ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) AS AttritionRate
FROM employee_attrition
GROUP BY SalaryBand
ORDER BY AttritionRate DESC;
-- Shows whether compensation affects attrition decisions.

-- 5. Overtime vs Work-Life Balance Impact
SELECT 
OverTime,
WorkLifeBalance,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS EmployeesLeft,
ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) AS AttritionRate
FROM employee_attrition
GROUP BY OverTime, WorkLifeBalance
ORDER BY AttritionRate DESC;
-- Identifies burnout patterns due to overtime and poor work-life balance.

-- 6. Promotion Stagnation Analysis
SELECT 
YearsSinceLastPromotion,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS EmployeesLeft,
ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) AS AttritionRate
FROM employee_attrition
GROUP BY YearsSinceLastPromotion
ORDER BY AttritionRate DESC;
-- Employees without promotion for long periods show higher attrition risk.

-- 7. Experience vs Attrition Pattern
SELECT 
CASE
WHEN TotalWorkingYears < 5 THEN 'Early Career'
WHEN TotalWorkingYears BETWEEN 5 AND 15 THEN 'Mid Career'
ELSE 'Senior'
END AS ExperienceCategory,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS AttritionCount,
ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) AS AttritionRate
FROM employee_attrition
GROUP BY ExperienceCategory
ORDER BY AttritionRate DESC;
-- Shows career stage where employees leave most.

ALTER TABLE employee_attrition 
CHANGE `ï»¿Age` Age INT;

-- 8.  Age vs Attrition Dynamics
SELECT 
CASE 
WHEN Age < 30 THEN 'Young Professionals'
WHEN Age BETWEEN 30 AND 40 THEN 'Mid-Level Employees'
ELSE 'Senior Employees'
END AS AgeGroup,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS AttritionCount,
ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) AS AttritionRate
FROM employee_attrition
GROUP BY AgeGroup
ORDER BY AttritionRate DESC;
-- Young employees often leave more due to career mobility.

-- 9.  Commute Distance Impact
SELECT 
DistanceFromHome,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS AttritionCount
FROM employee_attrition
GROUP BY DistanceFromHome
ORDER BY AttritionCount DESC;
-- Identifies whether long commuting distance increases turnover.

-- 10. Job Satisfaction vs Attrition
SELECT 
JobSatisfaction,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS AttritionCount,
ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) AS AttritionRate
FROM employee_attrition
GROUP BY JobSatisfaction
ORDER BY AttritionRate DESC;
-- Low satisfaction strongly correlates with attrition.

-- 11. Manager Relationship Influence
SELECT 
YearsWithCurrManager,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS AttritionCount
FROM employee_attrition
GROUP BY YearsWithCurrManager
ORDER BY AttritionCount DESC;
-- Analyzes whether manager stability affects employee retention.

-- 12. Training Investment Impact
SELECT 
TrainingTimesLastYear,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS AttritionCount
FROM employee_attrition
GROUP BY TrainingTimesLastYear
ORDER BY AttritionCount DESC;
-- Employees receiving less training may feel less valued.

-- 13. Gender Diversity Attrition
SELECT 
Gender,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS AttritionCount,
ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) AS AttritionRate
FROM employee_attrition
GROUP BY Gender;
-- Checks gender equality in retention.

-- 14. Attrition Rate by Job Level and Department (Multi-Dimensional Analysis)
SELECT 
Department,
JobLevel,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS AttritionCount,
ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) AS AttritionRate
FROM employee_attrition
GROUP BY Department, JobLevel
ORDER BY AttritionRate DESC;
-- Shows which job levels in each department have highest attrition.

-- 15. Salary Growth vs Attrition Behavior
SELECT 
PercentSalaryHike,
COUNT(*) AS Employees,
AVG(MonthlyIncome) AS AvgSalary,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS AttritionCount
FROM employee_attrition
GROUP BY PercentSalaryHike
ORDER BY AttritionCount DESC;
-- Analyzes whether salary hikes influence retention.
  
-- 16.High Performers Leaving the Company
SELECT 
PerformanceRating,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS HighPerformersLeaving
FROM employee_attrition
GROUP BY PerformanceRating
ORDER BY HighPerformersLeaving DESC;
-- Checks if top performers are leaving the organization.

-- 17. Attrition by Marital Status and Overtime
SELECT 
MaritalStatus,
OverTime,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS AttritionCount
FROM employee_attrition
GROUP BY MaritalStatus, OverTime
ORDER BY AttritionCount DESC;
# Detects personal life vs workload influence.

-- 18. Attrition by Education Field
SELECT 
EducationField,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS AttritionCount,
ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) AS AttritionRate
FROM employee_attrition
GROUP BY EducationField
ORDER BY AttritionRate DESC;
# Identifies fields where employees switch jobs more often.

-- 20. Employee Engagement Score Analysis
SELECT 
JobRole,
ROUND(AVG(JobSatisfaction + EnvironmentSatisfaction + RelationshipSatisfaction)/3,2) AS EngagementScore,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS AttritionCount
FROM employee_attrition
GROUP BY JobRole
ORDER BY EngagementScore ASC;
# Shows low engagement roles driving attrition.

-- 21. Employees Working in Many Companies (Career Switching Behavior)
SELECT 
NumCompaniesWorked,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS AttritionCount
FROM employee_attrition
GROUP BY NumCompaniesWorked
ORDER BY AttritionCount DESC;
# Detects frequent job switchers.

-- 22. Attrition by Stock Option Level
SELECT 
StockOptionLevel,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS AttritionCount,
ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) AS AttritionRate
FROM employee_attrition
GROUP BY StockOptionLevel;
# Checks whether equity incentives reduce attrition.

-- 23. Attrition vs Business Travel Frequency
SELECT 
BusinessTravel,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS AttritionCount
FROM employee_attrition
GROUP BY BusinessTravel
ORDER BY AttritionCount DESC;
# Frequent travel may increase attrition.

-- 24. Highest Paid Employees in Each Department
SELECT *
FROM (
SELECT 
Department,
EmployeeNumber,
MonthlyIncome,
RANK() OVER(PARTITION BY Department ORDER BY MonthlyIncome DESC) AS SalaryRank
FROM employee_attrition
) t
WHERE SalaryRank <= 3;
# Finds top 3 highest paid employees per department.

-- 25. Attrition Percentage by Salary Quartile
SELECT 
SalaryQuartile,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS AttritionCount
FROM (
SELECT 
Attrition,
NTILE(4) OVER(ORDER BY MonthlyIncome) AS SalaryQuartile
FROM employee_attrition
) t
GROUP BY SalaryQuartile;
# Detects attrition trends across salary segments.

-- 26. Employee Tenure Ranking Within Department
SELECT 
Department,
EmployeeNumber,
YearsAtCompany,
RANK() OVER(PARTITION BY Department ORDER BY YearsAtCompany DESC) AS TenureRank
FROM employee_attrition;
# Identifies longest-serving employees in each department.

--  27. Department Salary Gap Analysis
SELECT 
Department,
AVG(MonthlyIncome) AS AvgSalary,
MAX(MonthlyIncome) AS HighestSalary,
MIN(MonthlyIncome) AS LowestSalary,
(MAX(MonthlyIncome) - MIN(MonthlyIncome)) AS SalaryGap
FROM employee_attrition
GROUP BY Department
ORDER BY SalaryGap DESC;
# Shows pay inequality within departments.

-- 28. Attrition Risk Percentile (Advanced Segmentation)
SELECT 
EmployeeNumber,
Age,
MonthlyIncome,
YearsSinceLastPromotion,
PERCENT_RANK() OVER(ORDER BY YearsSinceLastPromotion DESC) AS PromotionDelayRisk
FROM employee_attrition;
# Identifies employees at risk due to promotion delay.

-- 29. Workload vs Compensation Efficiency
SELECT 
OverTime,
AVG(MonthlyIncome) AS AvgSalary,
AVG(JobSatisfaction) AS AvgSatisfaction,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS AttritionCount
FROM employee_attrition
GROUP BY OverTime;
# Measures workload vs satisfaction imbalance.

--  30. Predictive Attrition Scoring Model (Risk Prediction)
SELECT 
EmployeeNumber,
Department,
JobRole,
MonthlyIncome,
OverTime,
JobSatisfaction,
YearsSinceLastPromotion,
WorkLifeBalance,

CASE
WHEN OverTime = 'Yes'
     AND WorkLifeBalance <= 2
     AND YearsSinceLastPromotion >= 3
THEN 'Critical Risk'

WHEN MonthlyIncome < 4000
     AND JobSatisfaction <= 2
THEN 'High Risk'

WHEN YearsSinceLastPromotion >= 2
     OR JobSatisfaction <= 2
THEN 'Medium Risk'

ELSE 'Low Risk'
END AS AttritionRiskScore

FROM employee_attrition;
# Identifies employees likely to resign

-- 31. Cohort Retention Analysis (Employee Tenure Behavior)
SELECT 
CASE
WHEN YearsAtCompany <= 2 THEN '0-2 Years (New Employees)'
WHEN YearsAtCompany BETWEEN 3 AND 5 THEN '3-5 Years'
WHEN YearsAtCompany BETWEEN 6 AND 10 THEN '6-10 Years'
ELSE '10+ Years (Veterans)'
END AS TenureCohort,

COUNT(*) AS TotalEmployees,

SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS EmployeesLeft,

ROUND(
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)*100 / COUNT(*),
2
) AS AttritionRate

FROM employee_attrition
GROUP BY TenureCohort
ORDER BY AttritionRate DESC;
# Shows when employees leave during career lifecycle

-- Root Cause Attrition Driver Analysis
SELECT 
OverTime,
JobSatisfaction,
YearsSinceLastPromotion,
CASE
    WHEN MonthlyIncome < 4000 THEN 'Low Salary'
    WHEN MonthlyIncome BETWEEN 4000 AND 8000 THEN 'Medium Salary'
    ELSE 'High Salary'
END AS SalaryBand,

COUNT(*) AS Employees,

SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS EmployeesLeft,

ROUND(
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100 / COUNT(*),
2
) AS AttritionRate

FROM employee_attrition

GROUP BY 
OverTime,
JobSatisfaction,
YearsSinceLastPromotion,
SalaryBand

HAVING AttritionRate > 20

ORDER BY AttritionRate DESC;

# What This Analysis Reveals

# This query identifies combinations of conditions where employees leave the most.

# Example high-risk patterns you may observe:

# • Employees with Overtime = Yes + Low Job Satisfaction
#• Employees with Low Salary + Promotion Delay
#• Employees with Poor Work-Life Balance + Overtime

# Instead of analyzing one factor at a time, this query shows real root causes.
