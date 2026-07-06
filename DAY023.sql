
--BASIC FILTERING 

--Return all appointments where Status is 'Completed'.
SELECT * FROM Appointments
WHERE Status='Completed'

--Return all patients who live in Oxford.
SELECT
	PatientID,
	FullName
FROM Patients
WHERE City='Oxford'

--Return all doctors whose specialty is Cardiology.
SELECT
	DoctorID,
	DoctorName
FROM Doctors
WHERE Specialty='Cardiology'

--Return appointments with Cost greater than 100.
SELECT *
FROM Appointments
WHERE Cost > 100

--Return patients registered after 2023‑03‑01.
SELECT 
	PatientID,
	FullName,
	RegisteredDate
FROM Patients
WHERE RegisteredDate >'2023-03-01'

--ORDER BY

--Return all appointments ordered by ApptDate descending.
SELECT * 
FROM Appointments
ORDER BY ApptDate DESC
--Return all patients ordered by FullName alphabetically.
SELECT 
	PatientID,
	FullName
FROM Patients
ORDER BY FullName ASC

--Return doctors ordered by Specialty then DoctorName.
SELECT *
FROM Doctors
ORDER BY 
	Specialty ASC,
	DoctorName ASC
--Return appointments ordered by Cost, then Status.
SELECT *
FROM Appointments
ORDER BY Cost ASC, Status ASC

--Return total number of appointments per Status.
SELECT
	Status,
	COUNT(AppointmentID) AS total_appointments
FROM Appointments
GROUP BY Status

--Return total cost per DoctorID.
SELECT 
	d.DoctorID,
	SUM(a.Cost) AS total_cost
FROM Doctors AS d
JOIN Appointments AS a
ON d.DoctorID=a.DoctorID
GROUP BY d.DoctorID

--Return count of patients per City.
SELECT 
City,
COUNT(PatientID) AS total_patients
FROM Patients
GROUP BY City

--Return doctors who have more than 5 completed appointments.
SELECT 
	DoctorID,
	COUNT(AppointmentID) AS no_of_appointments
FROM Appointments
GROUP BY DoctorID

--Return cities with more than 2 registered patients.

SELECT 
	City,
	COUNT(PatientID) AS total_patients
FROM Patients
GROUP BY City
HAVING COUNT(PatientID) >2

--Return distinct cities where patients live.


SELECT DISTINCT City
FROM Patients

--Return top 5 most expensive appointments.
SELECT TOP 5 *
FROM Appointments
ORDER BY Cost DESC

--Return appointments where Status = 'Completed' AND Cost > 100.

SELECT * 
FROM Appointments
WHERE Status='Completed' AND 
Cost >100

