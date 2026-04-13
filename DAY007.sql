--13/04/2026
--Platform: Hackerrank

--QUESTION:
--Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates

--SOLUTION:
SELECT DISTINCT CITY 
FROM STATION
WHERE CITY LIKE '%a'
OR CITY LIKE '%e'
OR CITY LIKE '%i'
OR CITY LIKE '%o'
OR CITY LIKE '%u'


--QUESTION: Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. 
  --Your result cannot contain duplicates.

--SOLUTION:

SELECT DISTINCT CITY
FROM STATION
WHERE CITY LIKE 
'[aeiou]%[aeiou]'

--QUESTION:Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
--SOLUTION:
SELECT DISTINCT CITY
FROM STATION 
WHERE CITY NOT LIKE '[aeiou]%'


--QUESTION:Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.
--SOLUTION:
SELECT DISTINCT CITY 
FROM STATION 
WHERE  CITY NOT LIKE '%[aeiou]'

--QUESTION:Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.

--SOLUTION:
SELECT DISTINCT CITY
FROM STATION
WHERE CITY NOT LIKE '[aeiou]%' OR 
CITY NOT LIKE '%[aeiou]'
