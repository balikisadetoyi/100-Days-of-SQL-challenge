--DATE:12/04/2026
--Platform:HACKERRANK

--QUESTION:Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer.

--SOLUTION:

SELECT DISTINCT CITY
FROM STATION
WHERE ID % 2=0

--QUESTION:Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.

--ANSWER:
SELECT 
COUNT(CITY)-COUNT(DISTINCT CITY) AS DIFF
FROM STATION


--QUESTION:Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.

--SOLUTION:
  SELECT DISTINCT CITY
FROM STATION
WHERE CITY LIKE 'a%' OR
CITY LIKE 'e%' OR 
CITY LIKE 'i%' OR
CITY LIKE 'o%'OR
CITY LIKE 'u%'
