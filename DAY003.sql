-- Day 003 | 09 April 2026
-- Platform: Hackerrank
-- Question1: Query all columns for all American cities in the CITY table with populations larger than 100000. The CountryCode for America is USA.

--SOLUTUION:
SELECT * FROM CITY
WHERE COUNTRYCODE='USA'
AND POPULATION>100000


--QUESTION 2: Query the NAME field for all American cities in the CITY table with populations larger than 120000. The CountryCode for America is USA.

--SOLUTION:
SELECT NAME
FROM CITY
WHERE 
COUNTRYCODE='USA' AND POPULATION >120000


--QUESTION 3: Query all columns (attributes) for every row in the CITY table.

--SOLUTION:
SELECT * FROM CITY

--QUESTION 4:Query all columns for a city in CITY with the ID 1661.

--SOLUTION:
SELECT *
FROM CITY
WHERE ID=1661

--QUESTION 5:Query all attributes of every Japanese city in the CITY table. 

--SOLUTION: 
SELECT * FROM CITY
WHERE COUNTRYCODE='JPN'

