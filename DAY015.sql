--DATE: 21/04/2026
--PLATFORM:HACKERRANK
--REVISING BASIC SQL

--QUESTION :Query a count of the number of cities in CITY having a Population larger than 
SELECT COUNT(*) AS number_of_cities
FROM CITY
WHERE POPULATION>100000


--Query the total population of all cities in CITY where District is California.
SELECT SUM(POPULATION) AS total_population  
FROM CITY
WHERE DISTRICT='California'

--Query the average population of all cities in CITY where District is California.
SELECT
AVG(POPULATION) AS avg_population 
FROM CITY
WHERE DISTRICT='California'
  
--Query the average population for all cities in CITY, rounded down to the nearest integer
SELECT ROUND(AVG(POPULATION),0) AS avg_population
FROM CITY

--Query the sum of the populations for all Japanese cities in CITY. The COUNTRYCODE for Japan is JPN

SELECT SUM(POPULATION) AS jpn_population
FROM CITY
WHERE COUNTRYCODE='JPN'

--Query the difference between the maximum and minimum populations in CITY.

SELECT 
MAX(POPULATION)-MIN(POPULATION) AS diff_population
FROM CITY



