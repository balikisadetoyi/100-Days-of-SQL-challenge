
--WINDOW FUNCTIONS 
-- For each doctor return only their single most expensive appointment using ROW_NUMBER 
WITH Appt_cost AS(SELECT
DoctorID,
AppointmentID,
SUM(cost) AS appt_cost
FROM Appointments
GROUP BY
	DoctorID,
	AppointmentID),

dr_rank AS (SELECT
AppointmentID,
Appt_cost,
 ROW_NUMBER()OVER(PARTITION BY DoctorID ORDER BY appt_cost DESC) AS cost_rnk
 FROM Appt_cost)
 SELECT *
 FROM dr_rank
 WHERE cost_rnk=1

--Assign a row number to each appointment ordered by ApptDate ascending. 
--Show AppointmentID, PatientID and the row number.

SELECT 
	AppointmentID,
	PatientID,
	ROW_NUMBER()OVER(ORDER BY ApptDate ASC) AS appt_order
FROM Appointments

--For each patient, assign a row number to their appointments ordered by Cost descending. S
--show PatientID, AppointmentID, Cost and row number.

SELECT 
	PatientID,
	AppointmentID,
	Cost,
	ROW_NUMBER() OVER(PARTITION BY PatientID ORDER BY Cost DESC) AS patient_order
FROM Appointments;

-- Rank doctors by total number of appointments using both rank and dense rank
WITH totalAppointments AS (SELECT
	d.DoctorID,
	d.DoctorName,
	COUNT(a.AppointmentID) AS total_appts 
FROM Doctors AS d
JOIN Appointments AS a 
ON d.DoctorID=a.DoctorID
GROUP BY 
	d.DoctorID,
	d.DoctorName)
SELECT 
DoctorID,
DoctorName,
total_appts,
RANK() OVER( ORDER BY total_appts DESC) AS doctor_order,
DENSE_RANK()OVER(ORDER BY total_appts DESC) AS dr_order
FROM totalAppointments;


--Rank patients by total amount spent on Completed appointments only. 
WITH Patient_cost AS (SELECT
p.PatientID,
p.FullName,
SUM(a.Cost) AS appt_cost
FROM Patients AS p
JOIN Appointments AS a 
ON p.PatientID=a.PatientID
WHERE a.Status='Completed'
GROUP BY
	p.PatientID,
	p.FullName)

SELECT 
	PatientID,
	FullName,
	appt_cost,
	DENSE_RANK() OVER(ORDER BY appt_cost DESC) AS patientCost_rank
FROM Patient_cost

--For each appointment show AppointmentID, DoctorID, Cost, and the average cost
--for that specific doctor alongside each row.

SELECT
	AppointmentID,
	DoctorID,
	Cost,
	AVG(Cost) OVER(PARTITION BY DoctorID) AS avg_cost

FROM Appointments

--Show each patient's AppointmentID, ApptDate, 
--Cost and a running total of their costs ordered by date.

SELECT
PatientID,
AppointmentID,
ApptDate,
Cost,
SUM(Cost) OVER(PARTITION BY PatientID order by ApptDate ASC 
	ROWS BETWEEN  UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM Appointments;



