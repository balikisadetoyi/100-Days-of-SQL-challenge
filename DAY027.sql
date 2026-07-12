
--Write a CTE that calculates the average cost of appointments per doctor.
--Then use it to return only doctors whose average cost is 
--above the overall average.

WITH avg_cost AS (
SELECT
	DoctorID,
	AVG(Cost) AS Average_cost
FROM Appointments
GROUP BY DoctorID)

SELECT 
	DoctorID
FROM avg_cost
WHERE Average_cost >(
			SELECT AVG(Cost) FROM Appointments);


--Write a CTE that finds the total number of appointments per patient. 
--Then return only patients who have had more than 2 appointments.

WITH total_apppts AS (
SELECT
	PatientID,
	COUNT(AppointmentID) AS total_appointment
FROM Appointments
GROUP BY PatientID)

SELECT 
	PatientID,
	total_appointment
FROM total_apppts
WHERE total_appointment >2;


	--Write a nested  subquery to find all patients 
	--who have had at least one appointment with a Cardiology doctor.


SELECT DISTINCT
	PatientID
FROM Appointments
WHERE DoctorID IN (
SELECT 
	DoctorID
FROM Doctors 
WHERE Specialty='Cardiology');

--Using a CTE, rank patients by their total spend on Completed appointments only. 
--Return the top 3 spenders.

WITH Completed_appts AS (
SELECT
	PatientID,
	SUM(Cost) AS total_cost
FROM Appointments
WHERE Status='Completed'
GROUP BY 
	PatientID
)
SELECT TOP 3
PatientID,
total_cost
FROM Completed_appts
ORDER BY total_cost DESC;


--Write a CTE that calculates the completion rate per doctor
--Return doctors with a completion rate above 50%.
WITH dctr_complted_appt AS 
(SELECT
DoctorID,
COUNT(AppointmentID) AS appt_count
FROM Appointments
WHERE Status='Completed'
GROUP BY
	DoctorID),

Total_appt AS(
SELECT
DoctorID,
COUNT(AppointmentID) AS total
FROM Appointments
GROUP BY DoctorID)

SELECT
d.DoctorID,
d.appt_count*1.0/t.total*100 AS completion_rate

FROM dctr_complted_appt AS d
JOIN Total_appt AS t
ON 
d.DoctorID=t.DoctorID
WHERE
d.appt_count*1.0/t.total*100 >50;




--Using a subquery in the WHERE clause, find all appointments 
--that cost more than the average cost of No-Show appointments.
SELECT 
AppointmentID
FROM Appointments
WHERE Cost >
( SELECT AVG(Cost) FROM Appointments
WHERE Status='No-Show');



--Write two CTEs — one for total appointments per patient, 
--one for total cost per patient.
--Join them together and return both metrics side by side.
WITH appt_perPatient AS(
SELECT
PatientID,
COUNT(AppointmentID) AS tot_appt
FROM Appointments
GROUP BY PatientID),


Cost_perPatient AS (SELECT
PatientID,
SUM(Cost) AS tot_cost
FROM Appointments
GROUP BY PatientID)


SELECT 
a.PatientID,
a.tot_appt,
c.tot_cost
FROM appt_perPatient AS a
JOIN Cost_perPatient AS c
ON a.PatientID=c.PatientID

