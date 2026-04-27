--Find the average billing amount per hospital, 
--then return only hospitals where the average is above 
--the overall average billing amount.

WITH avg_hospital_bill AS (
SELECT
	Hospital_name,
	AVG(billing_amount) AS avg_bill
FROM Admissions
GROUP BY hospital_name)

SELECT 
	Hospital_name
FROM avg_hospital_bill
WHERE avg_bill > ( SELECT AVG(billing_amount) 
					FROM Admissions);
--For each city, rank patients by their billing amount 
--(highest first). Return only the top 2 patients per city.

WITH patients_rank AS(

SELECT 
	p.Patient_id,
	p.city, 
	SUM(a.billing_amount) AS patient_bill,
	RANK() OVER(PARTITION BY p.city ORDER BY SUM(a.billing_amount) DESC) AS bill_rank
FROM Patients  AS p
JOIN Admissions AS a
ON p.patient_id=a.patient_id
GROUP BY p.patient_id,p.city)

SELECT 
	patient_id,
	city,
	patient_bill,
	bill_rank
FROM  patients_rank
WHERE bill_rank<=2;

--Calculate, for each hospital: Total revenue
--Number of unique patients,Average billing per patient
--Return hospitals sorted by total revenue.
WITH hospital_details  AS 
(SELECT
	Hospital_name,
	SUM(billing_amount) AS total_revenue,
	COUNT (DISTINCT Patient_id) AS unique_p
FROM Admissions
GROUP BY hospital_name)


SELECT
	Hospital_name,
	total_revenue,
	unique_p ,
	total_revenue/unique_p AS avg_billing_per_patient
	FROM hospital_details
	ORDER BY total_revenue DESC
	




