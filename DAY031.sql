--Management wants to identify the hospital's highest earners.

--Only return doctors in the top 20% by total revenue.
WITH Doctor_revenue AS (
SELECT
	d.DoctorName,
	d.Specialty,
	SUM(a.Cost) AS total_revenue
FROM Doctors AS d
JOIN Appointments AS a
On d.DoctorID=a.DoctorID
GROUP BY 
	d.DoctorName,
	d.Specialty),
Revenue_Ranking AS (SELECT
	DoctorName,
	Specialty,
	total_revenue,
	DENSE_RANK()OVER(ORDER BY total_revenue DESC) AS revenue_rank,
	NTILE(5)OVER(ORDER BY total_revenue DESC) AS revenuebuckets
FROM Doctor_revenue)

SELECT *
FROM Revenue_Ranking
WHERE revenuebuckets=1;



--For each month, 
--determine which single day had the highest number of appointments.
WITH monthly_appts AS (
SELECT 
	MONTH(ApptDate) AS appt_month,
	ApptDate,
	COUNT(AppointmentID) AS appt_counts	 ,
	DENSE_RANK()OVER(PARTITION BY MONTH(ApptDate) ORDER BY COUNT(AppointmentID) DESC) AS appt_rank
FROM Appointments
GROUP BY 
	MONTH(ApptDate),
	ApptDate)

SELECT*
FROM monthly_appts
WHERE appt_rank=1;
--note: just one year present

--Management wants to know which patients returned quickly after a previous appointment.
--Only include patients whose next appointment occurred within 30 days.Sort by shortest interval first.
WITH Patient_appointments AS (
SELECT 
PatientID,
ApptDate,
LAG(ApptDate) OVER(PARTITION BY 
	PatientID ORDER BY ApptDate) AS previous_appointment,
DATEDIFF(DAY,
	LAG(ApptDate) OVER(PARTITION BY PatientID 
		ORDER BY ApptDate),ApptDate) AS days_between
FROM Appointments
)
SELECT * FROM Patient_appointments
WHERE days_between <=30
ORDER BY days_between ASC
