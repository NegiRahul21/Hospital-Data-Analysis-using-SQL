-- Create Database
CREATE DATABASE Hospital;

-- Create Tables 
CREATE TABLE Hospital_records(
	S_no SERIAL PRIMARY KEY,
	Hospital_Name	VARCHAR(100),
	Location VARCHAR(100),
	Department 	VARCHAR(100),
	Doctors_Count 	INT,
	Patients_Count	INT,
	Admission_Date	DATE,
	Discharge_Date	DATE,
	Medical_Expenses Numeric(10, 2)
);

-- Import data
SELECT * FROM Hospital_records;

-- 1. Total Number of Patients
SELECT Hospital_name, SUM(Patients_count) AS Total_Pastients_Count
FROM Hospital_records
GROUP BY Hospital_name;

-- 2. Average Number of Doctors per Hospital
SELECT Hospital_name, AVG(Doctors_count)::INT AS Doc_Count
FROM Hospital_records
GROUP BY Hospital_name;

-- 3. Top 3 Departments with the Highest Number of Patients
SELECT Department, SUM(Patients_count) AS Total_patients
FROM Hospital_records
GROUP BY Department
ORDER BY Total_patients DESC 
LIMIT 3;

-- 4. Hospital with the Maximum Medical Expenses
SELECT Hospital_name, Medical_expenses
FROM Hospital_records
ORDER BY Medical_expenses DESC
LIMIT 1;

-- 5. Daily Average Medical Expenses
SELECT hospital_name,
SUM(Discharge_date - Admission_date) AS Total_date_spent,
SUM(Medical_expenses) AS Total_expense,
ROUND(SUM(Medical_expenses)/NULLIF(SUM(Discharge_date - Admission_date),0),2) AS Avg_spent_per_day
FROM Hospital_records
GROUP BY Hospital_name;

-- 6. Longest Hospital Stay
SELECT Hospital_name, Patients_count, Admission_date, Discharge_date, (Discharge_date - Admission_date) AS stay_days
FROM hospital_records
ORDER BY stay_days DESC
LIMIT 1;

-- 7. Total Patients Treated Per City
SELECT Location, SUM(Patients_count) AS Total_patients
FROM Hospital_records
GROUP BY Location;

-- 8. Average Length of Stay Per Department.
SELECT department, ROUND(AVG(discharge_date - admission_date),2) AS avg_stay_days
FROM hospital_records
GROUP BY department;

-- 9. Identify the Department with the Lowest Number of Patients
SELECT Department, SUM(Patients_count) AS Least_patients
FROM Hospital_records
GROUP BY Department
ORDER BY Least_patients ASC
LIMIT 1;

-- 10. Monthly Medical Expenses Report
SELECT EXTRACT(MONTH FROM Discharge_date) AS Months,
SUM(Medical_expenses) AS Total_Expense
FROM Hospital_records
GROUP BY Months
ORDER BY Months;





