--Management wants to identify aircraft models with inconsistent passenger demand.
--Return:
--Aircraft Model
--Number of Flights
--Minimum Passengers
--Maximum Passengers
--Passenger Range
--Order by the largest passenger range first.

SELECT
	a.AircraftModel,
	COUNT(f.FlightID) AS totalFlights,
	MIN(f.Passengers) AS min_Passengers,
	MAX(f.Passengers) AS max_Passengers,
	MAX(f.Passengers)-MIN(f.Passengers) AS passenger_range
FROM Aircraft AS a
JOIN Flights AS f
ON a.AircraftID=f.AircraftID
GROUP BY
	a.AircraftModel
ORDER BY passenger_range DESC;



--Management wants to know which arrival airports receive the greatest share of total airline revenue
--Return Arrival airport name,total revenue, percentage of overall revenue
--Order by percentage of overall revenue from highest to lowest.

SELECT
	a.AirportName AS ArrivalAirportName,
	SUM(f.TicketPrice*f.Passengers) AS total_revenue,
	ROUND(
		SUM(f.TicketPrice*f.Passengers)*1.0/
					(SELECT SUM(TicketPrice*Passengers) FROM Flights)*100,
						2) AS Percentage_of_total
FROM Airports AS a
JOIN Flights AS f
ON a.AirportID=f.ArrivalAirportID
GROUP BY
	a.AirportName
ORDER BY Percentage_of_total DESC

