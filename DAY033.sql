
--Return the most recent appointment for each doctor.
--return doctor id,doctor name,appointment id,appointment date,patient name
WITH Appointments_rank AS (
SELECT
	d.DoctorID,
	d.DoctorName,
	a.AppointmentID,
	a.ApptDate,
	p.FullName AS patient_name,
	DENSE_RANK()OVER(PARTITION BY d.DoctorID ORDER BY a.ApptDate DESC) AS Latest_appt_rank
FROM Doctors AS d
	JOIN Appointments AS a
ON d.DoctorID=a.DoctorID
	JOIN Patients AS p
ON p.PatientID=a.PatientID
)

SELECT *
FROM Appointments_rank
WHERE Latest_appt_rank=1

--Find all patients who have been treated by more than one doctor.
SELECT
p.Patientid,
p.FullName,
COUNT(DISTINCT a.DoctorID) AS total_doctors
FROM Patients AS p
JOIN Appointments AS a 
ON p.PatientID=a.PatientID
GROUP BY 
	p.PatientID,
	p.FullName
HAVING COUNT(DISTINCT a.DoctorID)>1;
