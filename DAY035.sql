--Return the top 3 patients for each doctor based on the number of appointments.
--If two patients are tied, they should receive the same ranking.


WITH Appointment_countS AS(
SELECT
	d.DoctorID,
	d.DoctorName,
	p.PatientID,
	p.FullName AS patientName,
	COUNT(a.AppointmentID) AS total_appointments
FROM Doctors AS d
JOIN Appointments AS a
ON d.DoctorID=a.DoctorID
JOIN Patients AS p
ON p.PatientID=a.PatientID
GROUP BY
	d.DoctorID,
	d.DoctorName,
	p.PatientID,
	p.fullName
	)
, patient_rank AS (
SELECT *,
DENSE_RANK()OVER(PARTITION BY DoctorID ORDER BY total_appointments DESC) AS appt_rank
FROM Appointment_countS)

SELECT *
FROM patient_rank
WHERE appt_rank<=3;


--Find patients who had appointments in two or more different departments on the same date.
--only include patients who visited more than one department on the same day.
SELECT
    p.PatientID,
    p.FullName,
    a.ApptDate,
    COUNT(DISTINCT d.Specialty) AS department_count
FROM Patients AS p
JOIN Appointments AS a
    ON p.PatientID = a.PatientID
JOIN Doctors AS d
    ON d.DoctorID = a.DoctorID
GROUP BY
    p.PatientID,
    p.FullName,
    a.ApptDate
HAVING COUNT(DISTINCT d.Specialty) > 1
ORDER BY
    a.ApptDate,
    p.PatientID