--DATE:16/04/2026
--PLATFORM: STRATASCRATCH

--QUESTION:Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT 
CITY FROM STATION
WHERE CITY NOT LIKE '[aeiou]%' AND
    CITY NOT LIKE '%[aeiou]'

--QUESTION:Query the Name of any student in STUDENTS who scored higher than  Marks. Order your output by the last three characters of each name. 
--If two or more students both have names ending in the same last three characters  secondary sort them by ascending ID.

SELECT name
FROM STUDENTS
WHERE marks > 75
ORDER BY RIGHT (name,3) ASC,
ID ASC

--QUESTION: Write a query that prints a list of employee names (i.e.: the name attribute) from the Employee table in alphabetical order.

SELECT name FROM 
EMPLOYEE 
ORDER BY name ASC

--QUESTION:Write a query that prints a list of employee names for employees in Employee having a salary greater than  
--per month who have been employees for less than  months. Sort your result by ascending employee_id.

SELECT name FROM 
EMPLOYEE 
WHERE salary >2000 AND 
months <10
ORDER BY employee_id ASC


