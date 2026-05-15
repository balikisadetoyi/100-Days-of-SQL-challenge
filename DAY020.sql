
-- Show all patients from Manchester, oldest first.
SELECT * FROM demographics
WHERE Region='Manchester'
ORDER BY Age DESC


-- Show the 5 patients who waited the longest 
--before their first appointment.

SELECT  TOP 5 
	PatientID, 
	WaitingDays
FROM referrals
ORDER BY WaitingDays DESC

-- Show every unique referral source.

SELECT DISTINCT 
	ReferralSource
FROM referrals

--Show the patients who had more than 8 appointments, 
--with their appointment counts.

SELECT 
	PatientID,
	COUNT(AppointmentID) AS total_apppointments
FROM appointments
GROUP BY PatientID
HAVING COUNT(AppointmentID) > 8
ORDER BY total_apppointments DESC

--For each region: total patients, 
--average age, youngest, oldest.

SELECT 
	Region,
	COUNT(PatientID) AS total_patients,
	AVG(Age) AS avg_age,
	MAX(Age) AS oldest_patient,
	MIN(Age) AS youngest_patient
FROM demographics
GROUP BY Region

-- Find patients aged 25 to 40 whose 
--ethnicity contains "British".

SELECT 
	PatientID,
	Age,
	Gender,
	Ethnicity
FROM demographics
WHERE Age BETWEEN 25 AND 40 AND
Ethnicity LIKE '%British%'


-- Find patients from Manchester, London, or Liverpool 
--whose treatment was CBT or EMDR.


SELECT
	PatientID,
	Region,
	TreatmentType
FROM appointments
WHERE REGION IN ('Manchester','London','Liverpool') AND 
TreatmentType IN ('CBT','EMDR')

--Find patients not from Manchester 
--whose referral source isn't GP.
SELECT 
	PatientID,
	Region,
	ReferralSource
FROM referrals
WHERE Region <>'Manchester' AND 
ReferralSource<>'GP'

-- Show patient ID, age,
--gender, treatment type, and waiting days.
SELECT 
	d.PatientID,
	d.Age,
	d.gender,
	r.TreatmentType,
	r.WaitingDays
FROM demographics AS d
JOIN referrals AS r
ON d.PatientID=r.PatientID

-- Show every patient with their region,
--total appointments, andtreatment completion status 
--— including patients with zero appointments.
SELECT 
	d.PatientID,
	d.Region,
	COUNT(a.AppointmentID) AS total_appointments,
	o.TreatmentCompleted
FROM demographics AS d 
LEFT JOIN appointments AS a ON d.PatientID=a.PatientID
LEFT JOIN outcomes AS o
ON d.PatientID=o.PatientID
GROUP BY 
	d.PatientID,
	d.Region,
	o.TreatmentCompleted

-- Show patient ID, the year of 
--first appointment, and the month 
--name of first appointment.

SELECT 
	PatientID,
	YEAR(FirstAppointmentDate) AS first_year,
	DATENAME(MONTH, FirstAppointmentDate) AS first_month
FROM referrals

--For each patient, calculate the days
--between referral date and last appointment date.
SELECT 
	r.PatientID,
	r.ReferralDate,
	MAX(a.AppointmentDate) AS last_appointmentdate,
	DATEDIFF(DAY,r.ReferralDate,MAX(a.AppointmentDate)) AS date_difference
FROM referrals AS r
JOIN appointments AS a
ON r.PatientID=a.PatientID
GROUP BY
	r.PatientID,
	r.ReferralDate

-- Categorise each patient's 
--waiting time as Short (≤14), 
--Medium (15-28), or Long (>28).
SELECT 
	PatientID,
	WaitingDays,
	CASE 
		WHEN WaitingDays  <= 14 THEN'Short'
		WHEN WaitingDays BETWEEN 15 AND 28 THEN 'Medium'
		WHEN WaitingDays > 28 THEN 'Long' 
	END AS waiting_days_category
FROM referrals;


--For each region, rank treatment types by 
--how many patients completed them. Top treatment per region = rank 1
WITH patient_completed_therapy AS (
SELECT
	d.Region,
	o.TreatmentType,
	COUNT(d.PatientID) AS patient_completed 
FROM outcomes AS o
JOIN demographics AS d ON
d.patientID=o.patientID 
WHERE TreatmentCompleted=1
GROUP BY
	o.TreatmentType,
	d.Region) 

SELECT 
	Region,
	TreatmentType,
	patient_completed,
	RANK() OVER(PARTITION BY Region ORDER BY Patient_completed DESC) AS region_rank
FROM patient_completed_therapy 

-- Find patients whose waiting days are 
--above the overall average. Show waiting days and difference from average.

SELECT 
	PatientID,
	WaitingDays,
	(SELECT AVG(WaitingDays) FROM referrals) AS overall_avg,
	WaitingDays -
		(SELECT AVG(WaitingDays) FROM referrals) AS waiting_difference
FROM referrals

WHERE WaitingDays > (SELECT AVG(WaitingDays) FROM referrals)