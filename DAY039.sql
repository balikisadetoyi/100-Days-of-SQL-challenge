--Display:Flight Number
--Departure Airport Name
--Arrival Airport Name
--Flight Date
--Ticket Price 
--sort by flight Date
SELECT * FROM Flights
SELECT 
	f.FlightNumber,
	d.AirportName AS DepartureAirportName,
	a.AirportName AS ArrivalAirportName,
	f.FlightDate,
	f.TicketPrice
FROM Flights AS f
JOIN Airports AS d
ON d.AirportID=f.DepartureAirportID
JOIN Airports AS a
ON a.AirportID=f.ArrivalAirportID
ORDER BY f.FlightDate DESC



--Display Flight Number,Flight Date
--Ticket Price,Number of Passengers
--Only show flights where:Ticket Price is greater than £140
--Sort by Ticket Price from highest to lowest.

SELECT
	FlightNumber,
	FlightDate,
	TicketPrice,
	Passengers
FROM Flights
WHERE TicketPrice>140
ORDER BY TicketPrice DESC



--Display:Flight Number,Aircraft Model,Manufacturer
--Capacity,Passengers

--Add a new column called:SeatsAvailable

SELECT
	f.FlightNumber,
	a.AircraftModel,
	a.Manufacturer,
	a.Capacity,
	f.Passengers,
	a.Capacity-f.Passengers AS SeatsAvailable
FROM Flights AS f
JOIN Aircraft AS a
ON f.AircraftID=a.AircraftID




