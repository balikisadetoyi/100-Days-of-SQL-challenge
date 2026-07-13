
--Return every appointment and show:AppointmentID,DoctorID
--Appointment Date,Cost
--Running total revenue per doctor ordered by appointment date.

SELECT AppointmentID,
		DoctorID,
		ApptDate,
		Cost,
		SUM(Cost) OVER (PARTITION BY DoctorID ORDER BY ApptDate ROWS BETWEEN
			UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM Appointments;

--For each specialty, return:Specialty
--Number of doctors,Total appointments,Total revenue
--Average appointment cost

SELECT 
	d.Specialty,
	COUNT(DISTINCT d.DoctorID) AS total_drs,
	COUNT(a.AppointmentID) AS total_appts,
	SUM(a.Cost) AS total_revenue,
	AVG(a.Cost) AS avg_cost
FROM Doctors AS d
JOIN Appointments AS a
ON d.DoctorID=a.DoctorID
GROUP BY
	d.Specialty;


--For every patient, return:
--First appointment date
--Most recent appointment date
--Days between first and last appointment
--Total appointments

SELECT
	PatientID,
	MIN(ApptDate) AS first_appt,
	MAX(ApptDate) AS recent_appt,
	COUNT(AppointmentID) AS total_appts,
	DATEDIFF(DAY,MIN(ApptDate),MAX(ApptDate)) AS days_between
	FROM Appointments
	GROUP BY 
		PatientID;


--The hospital wants to identify high-value doctors.
--Return doctors who satisfy both,Generated above-average completed revenue,
--Completion rate greater than 80%

--Return Doctor Name,Specialty,Completed Revenue,Completion Rate

WITH CompletedRevenue AS (
SELECT 
	d.DoctorName,
	d.Specialty,
	SUM(CASE WHEN a.Status='Completed' THEN a.Cost ELSE 0 END ) AS completed_rev,
	SUM(CASE WHEN a.Status='Completed' THEN 1 ELSE 0 END ) *1.0/COUNT(*)*100 AS completion_rate
FROM Doctors AS d
JOIN Appointments AS a
ON d.DoctorID=a.DoctorID
GROUP BY
	d.DoctorName,
	d.Specialty	
HAVING 
	SUM(CASE WHEN a.Status='Completed' 
		THEN a.Cost ELSE 0 END ) >(SELECT 
								AVG(costCompleted) FROM 
								(SELECT
									SUM(CASE WHEN Status='Completed' THEN Cost ELSE 0 END) AS costCompleted
										FROM Appointments GROUP BY DoctorID)t)
	AND SUM(CASE WHEN a.Status='Completed' THEN 1 ELSE 0 END ) 
								*1.0/COUNT(*) *100 > 80 )


SELECT *
FROM CompletedRevenue