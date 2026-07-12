----Rank doctors by total revenue generated.
WITH Doctor_reveneue AS (SELECT
	d.DoctorID,
	d.DoctorName,
	SUM(a.Cost) AS total_rev
FROM Doctors AS d
JOIN Appointments AS a
ON d.DoctorID=a.DoctorID
GROUP BY 
	d.DoctorID,
	d.DoctorName)
SELECT
DoctorName,
total_rev,
DENSE_RANK()OVER(ORDER BY total_rev DESC) AS rnk
FROM Doctor_reveneue;


--For every patient, show:Appointment ,Cost,Previous Appointment Cost
SELECT
	ApptDate,
	Cost,
	LAG(Cost) OVER(PARTITION BY PatientID 
		ORDER BY ApptDate) AS prev_cost
FROM Appointments;

--Return each patient's most expensive appointment.
WITH patient_costRank AS(
SELECT
PatientID,
AppointmentID,
Cost ,
DENSE_RANK()OVER(PARTITION BY PatientID ORDER BY Cost DESC) AS cost_rnk
FROM Appointments
)

SELECT 
	PatientID,
	AppointmentID,
	Cost
FROM patient_costRank
WHERE cost_rnk=1


--Find the patient whose spending is above the average patient spending.
SELECT PatientID FROM (
SELECT 
PatientID,
SUM(Cost) AS total_amount
FROM Appointments
GROUP BY PatientID)t

WHERE total_amount>(SELECT AVG(total_amount)
	FROM (SELECT 
PatientID,
SUM(Cost) AS total_amount
FROM Appointments
GROUP BY PatientID)x);


SELECT* FROM Appointments