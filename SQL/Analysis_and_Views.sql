

--Total Admissions
SELECT COUNT(*) FROM admissions;

--Unique Patients
SELECT COUNT(DISTINCT patient_id)
FROM admissions;
SELECT *FROM admissions
--Total Revenue
SELECT SUM(treatment_cost::numeric) 
FROM admissions;

--Average Cost
SELECT AVG(treatment_cost::numeric)
FROM admissions;

--Top Diangosis
SELECT icd_code,
       COUNT(*) AS total_cases
FROM admissions
GROUP BY icd_code
ORDER BY total_cases DESC;


--Top Department 
SELECT department,
       COUNT(*) AS admissions
FROM admissions
GROUP BY department
ORDER BY admissions DESC;






--Insurance Analysis
SELECT insurance_type,
       COUNT(*) AS admissions,
       SUM(treatment_cost::numeric) AS total_revenue
FROM admissions
GROUP BY insurance_type
ORDER BY total_revenue DESC;


--Highest Cost patient
SELECT patient_id,
       SUM(treatment_cost::numeric) AS total_cost
FROM admissions
GROUP BY patient_id
ORDER BY total_cost DESC
LIMIT 1;


--Highest Single Admission Cost
SELECT *
FROM admissions
ORDER BY treatment_cost DESC
LIMIT 1;


--Readmitted Patients List
SELECT a.patient_id,
       COUNT(*) AS visits
FROM admissions a
GROUP BY a.patient_id
HAVING COUNT(*) > 1
ORDER BY visits DESC;

--Readmission Count KPI
SELECT COUNT(*)
FROM (
    SELECT patient_id
    FROM admissions
    GROUP BY patient_id
    HAVING COUNT(*) > 1
) t;



--Readmission Rate
SELECT
	(COUNT(DISTINCT CASE WHEN visit_count > 1 THEN patient_id END) * 100.0
	/ COUNT(DISTINCT patient_id)) AS readmission_rate
FROM (
	SELECT patient_id,
	COUNT(*) AS visit_count
FROM admissions
GROUP by patient_id
)t;



--vw_admission_details
CREATE VIEW vw_admission_details AS
SELECT
    admission_id,
    patient_id,
    department,
    insurance_type,
    icd_code,
    diagnosis,
    treatment_cost::numeric AS treatment_cost,
    (discharge_date - admit_date) AS length_of_stay
FROM admissions;



--vw_patient_summary
CREATE VIEW vw_patient_summary AS
SELECT
    patient_id,
    COUNT(*) AS admission_count,
    SUM(treatment_cost::numeric) AS total_cost,
    AVG(discharge_date - admit_date) AS avg_los
FROM admissions
GROUP BY patient_id;


--vw_readmission_summary
CREATE VIEW vw_readmission_summary AS
SELECT
    patient_id,
    COUNT(*) AS visit_count,
    CASE
        WHEN COUNT(*) > 1 THEN 'Yes'
        ELSE 'No'
    END AS readmission_flag
FROM admissions
GROUP BY patient_id;


--vw_patient_demographics
CREATE VIEW vw_patient_demographics AS
SELECT
    patient_id,
    gender,
    age::int AS age,
    CASE
        WHEN age::int BETWEEN 18 AND 39 THEN '18-39'
        WHEN age::int BETWEEN 40 AND 59 THEN '40-59'
        WHEN age::int BETWEEN 60 AND 74 THEN '60-74'
        ELSE '75+'
    END AS age_group
FROM patients;
