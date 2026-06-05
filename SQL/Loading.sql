--Load Patient Table
INSERT INTO patients
(
    patient_id,
    patient_name,
    age,
    gender,
    city
)
SELECT DISTINCT
    CAST(patient_id AS INT),
    patient_name,
    CAST(age AS INT),
    gender,
    city
FROM dataset;



--Load Admission Table
INSERT INTO admissions
(
    admission_id,
    patient_id,
    admit_date,
    discharge_date,
    department,
    icd_code,
    diagnosis,
    treatment_cost,
    insurance_type,
    doctor_name,
    discharge_status
)
SELECT
    CAST(admission_id AS INT),
    CAST(patient_id AS INT),
    admit_date,
    discharge_date,
    department,
    icd_code,
    diagnosis,
    CAST(treatment_cost AS NUMERIC(10,2)),
    insurance_type,
    doctor_name,
    discharge_status
FROM dataset;
