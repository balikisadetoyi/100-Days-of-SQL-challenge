
--For each appointment show AppointmentID, PatientID, ApptDate and 
--the date of their next appointment 

SELECT
	AppointmentID,
	PatientID,
	ApptDate,
	LEAD(ApptDate) OVER(PARTITION BY PatientID ORDER BY ApptDate ) AS next_appt
FROM Appointments

--Show each appointment with the 
--previous appointment cost for the same patient.  
--Where there is no previous appointment show 0
SELECT
	AppointmentID,
	PatientID,
	ApptDate,
	COALESCE (LAG(Cost) OVER(PARTITION BY PatientID 
		ORDER BY ApptDate ) ,0)AS previous_apptCost
FROM Appointments

--For each appointment show the difference in cost 
--between the current appointment and the previous one for the same patient.

SELECT
	AppointmentID,
	PatientID,
	ApptDate,
	Cost,
	COALESCE (LAG(Cost) OVER(PARTITION BY PatientID 
		ORDER BY ApptDate ) ,0)AS previous_apptCost,
	Cost-COALESCE (LAG(Cost) OVER(PARTITION BY PatientID 
		ORDER BY ApptDate ) ,0) AS diff_in_cost
FROM Appointments

--For each appointment show the cost of the first ever 
--appointment that doctor had, alongside every row.
SELECT
	AppointmentID,
	DoctorID,
	FIRST_VALUE(Cost) OVER(PARTITION BY DoctorID 
		ORDER BY ApptDate) AS first_apptCost
FROM Appointments

--For each appointment show the cost of the most recent 
--appointment for that patient alongside every row.
	SELECT
		AppointmentID,
		PatientID,
		ApptDate,
		LAST_VALUE(Cost) OVER(PARTITION BY PatientID
			ORDER BY ApptDate ROWS BETWEEN
			UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_apptCost
	FROM Appointments

	-- Divide all appointments into 4 equal groups based on Cost. 
	--Show AppointmentID, Cost and the group number.

	SELECT
	AppointmentID,
	Cost,
	NTILE(4) OVER(ORDER BY Cost) AS group_number
	FROM Appointments

-- Show each appointment's Cost and its cumulative distribution

SELECT
	AppointmentID,
	Cost,
	CUME_DIST() OVER(ORDER BY Cost) AS cum_dist
FROM Appointments

--Show each appointment's Cost and its percent rank among all appointments.
SELECT
	AppointmentID,
	Cost,
	PERCENT_RANK()OVER(ORDER BY Cost) AS pcnt_rnk
FROM Appointments