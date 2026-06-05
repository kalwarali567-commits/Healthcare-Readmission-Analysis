CREATE TABLE dataset (
	admission_id TEXT,
	patient_id TEXT,
	patient_name VARCHAR(100), 
	gender VARCHAR(50), 
	age TEXT, 
	city VARCHAR(100),
	admit_date DATE,
	discharge_date DATE,
	department VARCHAR(100), 
	icd_code VARCHAR(50),
	diagnosis VARCHAR(100),
	treatment_cost TEXT,
	insurance_type VARCHAR(100),
	doctor_name VARCHAR(100),
	discharge_status VARCHAR(100)
);

CREATE TABLE patients (
	patient_id TEXT PRIMARY KEY,
	patient_name VARCHAR(100),
	age TEXT,
	gender VARCHAR(50),
	city VARCHAR(100) 
);
CREATE TABLE admissions (
	admission_id TEXT,
	patient_id TEXT,
	admit_date DATE, 
	discharge_date DATE, 
	department VARCHAR(100),
	icd_code VARCHAR(50),
	diagnosis VARCHAR(100),
	treatment_cost TEXT,
	insurance_type VARCHAR(100), 
	doctor_name VARCHAR(100), 
	discharge_status VARCHAR(100),
	FOREIGN KEY(patient_id) REFERENCES patients(patient_id)
);
