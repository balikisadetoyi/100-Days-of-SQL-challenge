--DATE: 15/04/2026
--PLATFORM:LEETCODE

--QUESTION:A country is big if:it has an area of at least three million (i.e., 3000000 km2), or
--it has a population of at least twenty-five million (i.e., 25000000).
--Write a solution to find the name, population, and area of the big countries.
SELECT 
    name,
    population,
    area
FROM World
WHERE area>=3000000 OR
population >= 25000000


--QUESTION:Write a solution to find all the classes that have at least five students.
SELECT class
FROM 
( SELECT class,
    COUNT (student) AS stds
    FROM Courses
    GROUP BY class 
)t
WHERE stds>5


--QUESTION:Write a solution to report the first name, last name, city, and state of each person in the Person table. 
  --f the address of a personId is not present in the Address table, report null instead.

SELECT P.firstName, P.lastName,A.city, A.state
FROM person AS P 
LEFT JOIN Address AS A
ON P.personId=A.personId



