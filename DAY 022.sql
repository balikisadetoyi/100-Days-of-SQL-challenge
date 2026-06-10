--From outcomes, count how many patients 
--Completed treatment versus those who didn't.


SELECT 
	TreatmentCompleted,
	COUNT(PatientID) AS number_of_patients
FROM outcomes
GROUP BY TreatmentCompleted

--Show PatientID, Age, Gender, and TreatmentCompleted for each patient.
SELECT
	d.PatientID,
	d.Age,
	d.Gender,
	o.TreatmentCompleted
FROM demographics AS d
JOIN outcomes AS o

ON d.PatientID=o.PatientID


-- Show the average WaitingDays for each Region, 
--ordered from highest to lowest.

SELECT 
	Region,
	AVG(waitingDays) AS avg_waiting_days
FROM referrals 
GROUP BY Region
ORDER BY avg_waiting_days DESC;

--Using a CTE, find the average number of total sessions per TreatmentType,
--then return only the treatment types
--where the average is above the overall average.

WITH avy_totalSessions AS (
SELECT 
TreatmentType,
AVG(TotalSessions) AS avg_sessions
FROM outcomes
GROUP BY TreatmentType
)

SELECT TreatmentType
FROM avy_totalSessions
WHERE avg_sessions > (SELECT AVG(TotalSessions) FROM outcomes)