--Identify all flights where the arrival airport is in a different country from the departure airport.
SELECT
    f.FlightNumber,
    d.AirportName AS DepartureAirport,
    d.Country AS DepartureCountry,
    a.AirportName AS ArrivalAirport,
    a.Country AS ArrivalCountry
FROM Flights AS f
JOIN Airports AS d
    ON f.DepartureAirportID = d.AirportID
JOIN Airports AS a
    ON f.ArrivalAirportID = a.AirportID
WHERE d.Country <> a.Country


--Determine which aircraft model generated the highest total revenue across all flights.
SELECT TOP 1
	a.AircraftModel,
	SUM(f.TicketPrice * f.Passengers) AS total_revenue
FROM Aircraft AS a
JOIN Flights AS f
ON a.AircraftID=f.AircraftID
GROUP BY 
	a.AircraftModel
ORDER BY 
	total_revenue DESC

--Find the top 3 busiest routes (DepartureAirport → ArrivalAirport) 
--based on total passengers carried across all flights.
SELECT TOP 3
    f.DepartureAirportID,
    f.ArrivalAirportID,
    SUM(f.Passengers) AS TotalPassengers
FROM Flights AS f
GROUP BY 
    f.DepartureAirportID,
    f.ArrivalAirportID
ORDER BY 
    TotalPassengers DESC

