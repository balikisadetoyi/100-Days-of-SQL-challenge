--Business Scenario

--The Hospital Director wants to identify patients who are returning frequently for appointments with 
--the same doctor, as this may indicate ongoing treatment or the need for a care plan review.
--Return all patient-doctor pairs where the patient has had three or more appointments with the same doctor.

--Return:
--Patient ID,Patient ,Doctor ID,Doctor Name,Number of appointments
--Only include patient-doctor combinations with 3 or more appointments, 
--and display the results in descending order of the number of appointments.
SELECT
	p.PatientID,
	p.FullName,
	d.DoctorID,
	d.DoctorName,
	COUNT(a.AppointmentID) AS total_appointment
	FROM Patients AS p
JOIN Appointments AS a
ON p.PatientID=a.PatientID
JOIN Doctors AS d
ON d.DoctorID=a.DoctorID
GROUP BY
	p.PatientID,
	p.FullName,
	d.DoctorID,
	d.DoctorName
HAVING COUNT(a.AppointmentID) >=3
ORDER BY total_appointment DESC

