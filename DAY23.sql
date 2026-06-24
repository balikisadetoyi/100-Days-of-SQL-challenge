
--List all patients based in Oxford, 
--showing their name and date of birth.

SELECT 
	PatientID,
	DateOfBirth
FROM dbo.Patients
WHERE City='Oxford'

--How many appointments are there of each status 
--(Completed, Cancelled, No-Show)?

SELECT 
	Status,
	COUNT(AppointmentID) AS total_appointments
FROM dbo.Appointments
GROUP BY Status

--Show the total revenue from Completed appointments only.
SELECT 
	SUM(Cost) AS total_revenue
FROM dbo.Appointments
WHERE Status='Completed'

--List each patient's full name and 
--how many appointments they've had, ordered from most to fewest.
SELECT
	p.FullName,
	COUNT(a.AppointmentID) AS total_appointments
FROM dbo.Patients AS p
JOIN dbo.Appointments AS a
ON p.PatientID=a.PatientID
GROUP BY p.FullName
ORDER BY total_appointments DESC

--Which doctors have a specialty of Cardiology, 
--and how many appointments has each of them had?

SELECT 
	d.DoctorID,
	d.DoctorName,
	COUNT(a.AppointmentID) AS total_appointments
FROM dbo.Doctors AS d
JOIN dbo.Appointments AS a
ON d.DoctorID=a.DoctorID
WHERE Specialty='Cardiology'
GROUP BY
	d.DoctorID,
	d.DoctorName

	--Find the patients who have had at least one No-Show. 
	--Show their name and how many No-Shows.

	SELECT 
		p.FullName,
		COUNT(*) AS total_NoShows
	FROM Patients AS p
	JOIN Appointments AS a
		ON p.PatientID=a.PatientID
	WHERE a.Status='No-Show'
	GROUP BY p.FullName
	HAVING COUNT(*) >=1

--Which city generated the most revenue from Completed appointments?
SELECT TOP 1
	p.City,
	SUM(a.Cost) AS total_rev
FROM Patients AS p
JOIN Appointments AS a
	ON p.PatientID=a.PatientID
WHERE a.Status='Completed'
GROUP BY 
	p.City
ORDER BY total_rev DESC

--List the top 3 patients by total amount spent on Completed appointments.
SELECT TOP 3 
	p.PatientID,
	p.FullName,
	SUM(a.Cost) AS total_amount
FROM Patients AS p
	JOIN Appointments AS a
	ON p.PatientID=a.PatientID
	WHERE a.Status='Completed'
	GROUP BY 
		p.PatientID,
		p.FullName
	ORDER BY 
		total_amount DESC


--For each appointment, show the PatientID, ApptDate, Cost, 
--and a column showing that patient's
--running total of cost ordered by date.

SELECT 
	p.PatientID,
	a.ApptDate,
	a.Cost,
	SUM(a.Cost) OVER(PARTITION BY p.PatientID ORDER BY a.ApptDate ASC
		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS running_total
FROM Patients AS p
	JOIN Appointments AS a
ON p.PatientID=a.PatientID