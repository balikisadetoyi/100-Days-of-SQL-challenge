--Management wants to compare each flight’s passenger count with the 
--average passenger count for all flights using the same aircraft model.
--Return Flight Number
--Aircraft Model
--Passengers
--Average Passengers for Aircraft Model
--Difference from Aircraft Model Average
--Order by the largest positive difference first.

SELECT
	f.FlightNumber,
	a.AircraftModel,
	f.Passengers,
	AVG(Passengers) OVER(PARTITION BY
			a.AircraftModel) AS avg_passengers_Per_AircraftModel,
	f.Passengers-AVG(Passengers) 
			OVER(PARTITION BY a.AircraftModel) AS Difference_From_Average
FROM Aircraft AS a
JOIN Flights AS f
ON a.AircraftID=f.AircraftID
ORDER BY Difference_From_Average DESC;
	


--For each departure airport, identify the flight that generated the highest revenue.
--Return Departure Airport Name
--Flight Number
--Flight Date
--Revenue
--Return only one highest-revenue flight per departure airport.

WITH DepartureAirportReveneue AS (
SELECT
	d.AirportName AS DepartureAirportName,
	f.FlightNumber,
	f.FlightDate,
	(f.TicketPrice *f.Passengers)  AS TotalRevenue
FROM Airports AS d
JOIN Flights AS f
ON d.AirportID=f.DepartureAirportID
),

RevenueRank AS(
SELECT 
	DepartureAirportName,
	FlightNumber,
	FlightDate,
	TotalRevenue,
	ROW_NUMBER() OVER(PARTITION BY 
		DepartureAirportName ORDER BY TotalRevenue DESC,FlightNumber ASC) AS rnk
FROM DepartureAirportReveneue)

SELECT  
	DepartureAirportName,
	FlightNumber,
	FlightDate,
	TotalRevenue
FROM RevenueRank
WHERE rnk=1
