--The Operations Director wants to identify the most profitable aircraft.
--Write a query that returns:

--Aircraft Model
--Manufacturer
--Number of Flights
--Total Revenue
--Average Revenue per Flight
--Only include aircraft that have operated at least 2 flights.
--Order the results by Average Revenue per Flight (highest first)

SELECT
	a.AircraftModel,
	a.Manufacturer,
	COUNT(f.FlightID) AS total_flights,
	SUM(f.TicketPrice *f.Passengers) AS total_revenue,
	AVG(f.TicketPrice *f.Passengers) AS avg_revenue
FROM Aircraft AS a
JOIN Flights AS f
ON a.AircraftID=f.AircraftID
GROUP BY 
	a.AircraftModel,
	a.Manufacturer
HAVING 
	COUNT(f.FlightID)>=2	
ORDER BY
	avg_revenue DESC


--Management wants to identify the busiest airports.
----Write a query that returns:

--Airport Name
--Total Departures
--Total Arrivals
--Total Flight Movements (Departures + Arrivals)
--Order the results by Total Flight Movements from highest to lowest.

SELECT
	a.AirportName,
	SUM(CASE WHEN f.DepartureAirportID =a.AirportID THEN 1 ELSE 0 END) AS TotalDepatures,
	SUM(CASE WHEN f.ArrivalAirportID =a.AirportID THEN 1 ELSE 0 END) AS TotalArrivals,
	SUM( CASE WHEN f.DepartureAirportID = a.AirportID THEN 1 
		WHEN f.ArrivalAirportID = a.AirportID THEN 1 
		ELSE 0 END) AS TotalFlightMovements
FROM Airports AS a
	JOIN Flights AS f
ON a.AirportID=f.DepartureAirportID
OR a.AirportID=f.ArrivalAirportID
GROUP BY
	a.AirportName
ORDER BY 
	 totalFlightMovements DESC