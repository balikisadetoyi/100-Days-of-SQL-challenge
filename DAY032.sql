

--Find all patients who have never had an appointment.

SELECT
p.PatientID,
p.FullName
FROM Patients AS p
LEFT JOIN Appointments AS a
ON p.PatientID=a.PatientID
WHERE a.PatientID IS NULL;




--Using your Patients, Appointments, and Doctors tables:
--Return the doctor(s) who have seen the highest number of unique patients.
WITH patients_seen AS (SELECT
	d.DoctorID,
	d.DoctorName,
	COUNT(DISTINCT a.PatientID) AS total_patients
FROM Doctors AS d
JOIN Appointments AS a
ON d.DoctorID=a.DoctorID
GROUP BY 
	d.DoctorID,
	d.DoctorName),

Highest_seen AS (
SELECT MAX(total_patients) AS max_pt_seen
FROM patients_seen
)

SELECT s.*
FROM patients_seen AS s
JOIN Highest_seen AS h
ON s.total_patients=h.max_pt_seen