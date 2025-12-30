-- 1. Total Admissions
SELECT COUNT(*) AS total_admissions FROM hospital_patient_master;

-- 2. Admissions per Hospital
SELECT hospital_id, COUNT(*) AS total_admissions FROM hospital_patient_master
GROUP BY hospital_id;

-- 3. Admissions per Department
SELECT department, hospital_id, COUNT(*) AS total_admissions FROM hospital_patient_master
GROUP BY department, hospital_id
ORDER BY department, hospital_id;

-- 4. Average Length of Stay by Department
SELECT department, ROUND(AVG(length_of_stay), 2) AS avg_length_of_stay 
FROM hospital_patient_master
GROUP BY department
ORDER BY avg_length_of_stay DESC;

-- 5. Average Length of Stay (LOS) per Patient
SELECT  ROUND(AVG(length_of_stay), 2) AS avg_los_days FROM hospital_patient_master;

-- 6. Long Stay Rate (% of patients with Length of Stay (LOS) > 10 days)
SELECT   ROUND(100 * SUM(CASE WHEN length_of_stay > 10 THEN 1 ELSE 0 END) / COUNT(*),2) AS long_stay_rate_pct
FROM hospital_patient_master;

SELECT department, COUNT(*) AS total_patients,
  SUM(CASE WHEN length_of_stay > 10 THEN 1 ELSE 0 END) AS long_stay_patients,
  ROUND(100 * SUM(CASE WHEN length_of_stay > 10 THEN 1 ELSE 0 END) / COUNT(*), 2 ) AS long_stay_rate_pct
FROM hospital_patient_master
GROUP BY department
ORDER BY long_stay_rate_pct DESC;

-- 7. Average Treatment Cost
SELECT ROUND(AVG(treatment_cost), 2) AS avg_treatment_cost FROM hospital_patient_master;

SELECT department, ROUND(AVG(treatment_cost), 2) AS avg_treatment_cost
FROM hospital_patient_master
GROUP BY department
ORDER BY avg_treatment_cost DESC;

SELECT diagnosis, COUNT(*) AS total_cases, ROUND(AVG(treatment_cost), 2) AS avg_treatment_cost
FROM hospital_patient_master
GROUP BY diagnosis
HAVING COUNT(*) >= 10
ORDER BY avg_treatment_cost DESC;

-- 8. Cost per Day
SELECT ROUND(AVG(treatment_cost / NULLIF(length_of_stay, 0)), 2) AS avg_cost_per_day
FROM hospital_patient_master;

-- 9.	Cost by Department
SELECT department, ROUND(AVG(treatment_cost), 2) AS avg_treatment_cost FROM hospital_patient_master
GROUP BY department
ORDER BY avg_treatment_cost DESC;

-- 10. High-Cost Case Rate (90th Percentile)
WITH ranked_costs AS (
  SELECT treatment_cost,
    PERCENT_RANK() OVER (ORDER BY treatment_cost) AS cost_percentile
  FROM hospital_patient_master
)
SELECT ROUND(100*SUM(CASE WHEN cost_percentile >= 0.9 THEN 1 ELSE 0 END) / COUNT(*),2) AS high_cost_case_rate_pct
FROM ranked_costs;

-- 11. Readmission Rate
SELECT ROUND(100 * SUM(readmitted = 'Yes') / COUNT(*),2) AS readmission_rate_pct
FROM hospital_patient_master;

-- 12. Mortality Rate
SELECT ROUND(100 * SUM(mortality = 'Yes') / COUNT(*),2) AS mortality_rate_pct
FROM hospital_patient_master;

-- 13. Mortality by Department
SELECT department,ROUND(100 * SUM(mortality = 'Yes') / COUNT(*),2) AS mortality_rate_pct
FROM hospital_patient_master
GROUP BY department
ORDER BY mortality_rate_pct DESC;

-- 14.	LOS vs Mortality Correlation
SELECT
  CASE
    WHEN length_of_stay <= 3 THEN '0–3 days'
    WHEN length_of_stay BETWEEN 4 AND 7 THEN '4–7 days'
    WHEN length_of_stay BETWEEN 8 AND 14 THEN '8–14 days'
    ELSE '15+ days'
  END AS los_bucket,
  COUNT(*) AS total_cases, ROUND(100 * SUM(mortality = 'Yes') / COUNT(*),2) AS mortality_rate_pct
FROM hospital_patient_master
GROUP BY los_bucket
ORDER BY mortality_rate_pct DESC;

-- 15.	Bed Utilization Proxy
SELECT hospital_id, COUNT(*) AS admissions,
  ROUND(AVG(length_of_stay), 2) AS avg_los,
  ROUND(COUNT(*) * AVG(length_of_stay), 2) AS bed_utilization_proxy
FROM hospital_patient_master
GROUP BY hospital_id
ORDER BY bed_utilization_proxy DESC;

-- 16.	Hospital Efficiency Score
SELECT hospital_id, ROUND(AVG(length_of_stay), 2) AS avg_los,
  ROUND(100 * SUM(readmitted = 'Yes') / COUNT(*), 2) AS readmission_rate,
  ROUND(100 * SUM(mortality = 'Yes') / COUNT(*), 2) AS mortality_rate,
  ROUND((AVG(length_of_stay)+ 100 * SUM(readmitted = 'Yes') / COUNT(*)
     + 100 * SUM(mortality = 'Yes') / COUNT(*) ),2) AS efficiency_score
FROM hospital_patient_master
GROUP BY hospital_id
ORDER BY efficiency_score ASC;

SELECT hospital_id, ROUND(AVG(length_of_stay), 2) AS avg_los,
       ROUND(100 * SUM(readmitted = 'Yes') / COUNT(*), 2) AS readmission_rate,
       ROUND(100 * SUM(mortality = 'Yes') / COUNT(*), 2) AS mortality_rate,
       ROUND(AVG(length_of_stay) + (100 * SUM(readmitted = 'Yes') / COUNT(*))
         + (100 * SUM(mortality = 'Yes') / COUNT(*)),2) AS efficiency_score
FROM hospital_patient_master
GROUP BY hospital_id
ORDER BY efficiency_score ASC;

SELECT hospital_id,
       ROUND(AVG(length_of_stay), 2) AS avg_los,
       ROUND(100 * SUM(readmitted = 'Yes') / COUNT(*), 2) AS readmission_rate,
       ROUND(100 * SUM(mortality = 'Yes') / COUNT(*), 2) AS mortality_rate,
       ROUND(
         (AVG(length_of_stay) * 0.40) +
         ((100 * SUM(readmitted = 'Yes') / COUNT(*)) * 0.35) +
         ((100 * SUM(mortality = 'Yes') / COUNT(*)) * 0.25),
         2
       ) AS hospital_efficiency_score
FROM hospital_patient_master
GROUP BY hospital_id
ORDER BY hospital_efficiency_score ASC;

-- 17.	Hospital Ranking
SELECT
  hospital_id,
  RANK() OVER (ORDER BY SUM(mortality = 'Yes') / COUNT(*)) AS mortality_rank,
  RANK() OVER (ORDER BY SUM(readmitted = 'Yes') / COUNT(*)) AS readmission_rank,
  RANK() OVER (ORDER BY AVG(length_of_stay)) AS los_rank
FROM hospital_patient_master
GROUP BY hospital_id;

-- 18. Average Age by Department
SELECT department, ROUND(AVG(age), 1) AS avg_age
FROM hospital_patient_master
GROUP BY department;

-- 19. Senior Patient Rate (65+)
SELECT ROUND(100 * SUM(age >= 65) / COUNT(*),2) AS senior_patient_rate_pct
FROM hospital_patient_master;

-- 20. Gender Distribution
SELECT gender, COUNT(*) AS total_patients,
  ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct
FROM hospital_patient_master
GROUP BY gender;

-- 21. Monthly Admission Trend
SELECT DATE_FORMAT(admission_date, '%Y-%m') AS month,
  COUNT(*) AS admissions
FROM hospital_patient_master
GROUP BY month
ORDER BY month;

-- 22. Monthly Readmission Trend
SELECT DATE_FORMAT(admission_date, '%Y-%m') AS month,
  ROUND(100 * SUM(readmitted = 'Yes') / COUNT(*),2) AS readmission_rate_pct
FROM hospital_patient_master
GROUP BY month
ORDER BY month;

-- 23. Cost Trend Over Time
SELECT DATE_FORMAT(admission_date, '%Y-%m') AS month,
  ROUND(AVG(treatment_cost), 2) AS avg_treatment_cost
FROM hospital_patient_master
GROUP BY month
ORDER BY month;
