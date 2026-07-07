
--Write a CTE that returns total appointments per patient.

WITH Total_apts AS (
SELECT
PatientID,
COUNT(AppointmentID) AS Apts_total
FROM Appointments
GROUP BY PatientID)

SELECT 
p.PatientID,
p.FullName,
p.Gender,
p.City,
t.Apts_total
FROM Patients  AS p
JOIN Total_apts AS t
ON p.PatientID=t.PatientID

--Return patients who have appointments costing more than the average cost.
SELECT
	PatientID
FROM Appointments
WHERE Cost >
	(SELECT AVG(Cost)
		FROM Appointments)

--Return each appointment with count of appointments per doctor.
SELECT 
	AppointmentID,
	DoctorID,
	COUNT(AppointmentID) OVER(PARTITION BY DoctorID) AS appointmentcounts
FROM Appointments

--Categorize appointments as 'High Cost' if Cost > 100 else 'Low Cost'.
SELECT 
	AppointmentID,
	Cost,
	CASE 
		WHEN Cost >100 THEN 'High Cost'
			ELSE 'Low Cost' END AS cost_division
FROM Appointments

--Return appointments replacing NULL cost with 0 
SELECT
	AppointmentID,
	COALESCE(Cost,0) AS non_nullCost
FROM Appointments

--Return patients where City IS NULL.
SELECT 
	*
FROM Patients
WHERE City IS NULL


--Return year of each appointment date
SELECT 
AppointmentID,
ApptDate,
YEAR(ApptDate) AS appt_year
FROM Appointments

--Return month name of each appointment date
SELECT 
AppointmentID,
ApptDate,
DATENAME(MONTH,ApptDate) AS appt_month
FROM Appointments

--Return number of days between appointment date and registered date.


SELECT
	p.RegisteredDate,
	a.ApptDate,
	DATEDIFF(DAY,p.RegisteredDate,a.ApptDate) AS days_first_appointement
FROM Patients AS p
JOIN Appointments AS a
ON p.PatientID=a.PatientID


--Return appointments with ApptDate truncated to month
SELECT 
AppointmentID,
ApptDate,
DATETRUNC(MONTH,ApptDate) AS yr_mnth
FROM Appointments


