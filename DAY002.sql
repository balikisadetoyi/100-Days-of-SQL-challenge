--Day002/ 9th April, 2026
--SOURCE: hackerrank 
--CHALLENGE:Query the two cities in STATION with the shortest and longest CITY names, 
--as well as their respective lengths (i.e.: number of characters in the name). 
--If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.

--SOLUTION:
SELECT TOP 1  CITY,
LEN(CITY) AS MIN_city
FROM STATION 
ORDER BY LEN(CITY) ASC, CITY ASC ;
SELECT TOP 1
 CITY,
LEN(CITY) AS MAX_city
FROM STATION 
ORDER BY LEN(CITY) DESC,CITY  ASC
