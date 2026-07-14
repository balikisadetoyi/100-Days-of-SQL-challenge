--For each doctor return:

--Doctor Name
--Total Revenue
--Percentage contribution to the hospital's total revenue

--Sort highest first.
WITH Doctors_revenue AS (
SELECT 
	d.DoctorName,
	SUM(a.Cost) AS total_revenue
FROM Doctors AS d
JOIN Appointments AS a
ON d.DoctorID=a.DoctorID
GROUP BY 
	d.DoctorName)

SELECT 
	DoctorName,
	total_revenue,
	total_revenue*100/SUM(total_revenue) OVER() AS percent_contribution
	FROM Doctors_revenue
	ORDER BY percent_contribution DESC


--For every patient, calculate the number of days between consecutive appointments.
SELECT
PatientID,
ApptDate,
LAG(ApptDate) OVER(PARTITION BY PatientID ORDER BY ApptDate) AS prev_appt,
DATEDIFF(DAY,LAG(ApptDate) OVER(PARTITION BY PatientID ORDER BY ApptDate),ApptDate) AS day_between_appts

FROM Appointments;


--For every month,rank doctors by completed revenue.
WITH monthly_Dr_revenue AS (
SELECT 
	d.DoctorName,
	MONTH(a.ApptDate) AS appt_month,
	SUM(Cost) AS total_rev
FROM Doctors AS d
JOIN Appointments AS a
ON a.DoctorID=d.DoctorID
GROUP BY 
	d.DoctorName,
	MONTH(ApptDate))

SELECT
	DoctorName,
	appt_month,
	total_rev,
	DENSE_RANK() OVER(PARTITION BY appt_month ORDER BY total_rev DESC) AS reveneu_rank
FROM monthly_Dr_revenue;



--Management wants one report.
--Return for every doctor: name,specialty,total appointments,completed appointments,
--completion rate,total revenue, average appointmnet cost,revenuerank
WITH doctorReport AS (
SELECT
	d.DoctorName,
	d.Specialty,
	COUNT(a.AppointmentID) AS total_appts,
	SUM(CASE WHEN a.Status='Completed' THEN 1 ELSE 0 END) AS completed_appts,
	SUM(CASE WHEN a.Status='Completed' THEN 1 ELSE 0 END)*1.0/COUNT(a.AppointmentID)* 100 AS completion_rate,
	SUM(a.Cost) AS total_revenue,
	AVG(a.Cost) AS avg_cost
FROM Doctors AS d
JOIN Appointments AS a
ON d.DoctorID=a.DoctorID
GROUP BY 
	d.DoctorName,
	d.Specialty)

SELECT
*,
DENSE_RANK() OVER(ORDER BY total_revenue DESC) AS revenue_rank
FROM doctorReport


	