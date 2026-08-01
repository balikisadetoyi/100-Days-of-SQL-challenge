--Management wants to understand how efficiently each aircraft is being used.
--Write a query that returns:
--Aircraft Model
--Manufacturer
--Total Flights Operated
--Total Passengers Carried
--Average Occupancy Rate (%)
--Order the results from the highest average occupancy rate to the lowest.

SELECT
	a.AircraftModel,
	a.Manufacturer,
	COUNT(f.AircraftID) AS TotalFlights,
	SUM(f.Passengers) AS TotalPassengers,
	(SUM(f.Passengers) * 1.0 / (a.Capacity * 
		COUNT(f.AircraftID))) * 100 AS avgOccupancyRate
FROM Aircraft AS a
JOIN Flights AS f
ON a.AircraftID=f.AircraftID
GROUP BY
	a.AircraftModel,
	a.Manufacturer,
	a.Capacity
ORDER BY
	avgOccupancyRate DESC




--The commercial team wants to know the busiest routes.
--Write a query that returns:Departure Airport Name,Arrival Airport Name,Number of Flights
--Total Revenue,Average Ticket Price

--Only include routes that generated more than £30,000 in revenue.

--Order the results by Total Revenue in descending order.

SELECT
	d.AirportName AS DepartureAirportName,
	a.AirportName AS ArrivalAirportName,
	COUNT(f.FlightNumber) AS TotalFlights,
	SUM(f.TicketPrice*f.Passengers) AS TotalRevenue,
	AVG(f.TicketPrice) AS avgTicketPrice
FROM Airports AS d
JOIN Flights AS f
	ON d.AirportID=f.DepartureAirportID
JOIN Airports AS a
ON a.AirportID=f.ArrivalAirportID
GROUP BY
	d.AirportName,
	a.AirportName
HAVING SUM(f.TicketPrice*f.Passengers) >30000
ORDER BY 
	TotalRevenue DESC