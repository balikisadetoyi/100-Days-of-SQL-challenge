-- Day 004| 10 April 2026
-- Platform: Leetcode
--QUESTION: Write a solution to report all the duplicate emails. Note that it's guaranteed that the email field is not NULL.
--Return the result table in any order.


--SOLUTION :
SELECT email FROM (SELECT email, COUNT(id) AS total_email
FROM Person
GROUP BY email) AS email_group
WHERE total_email> 1

--QUESTION:Write a solution to find all customers who never order anything.Return the result table in any order.

--SOLUTION: 
SELECT  
    C.name AS customers 
FROM Customers AS C
LEFT JOIN Orders AS O
ON C.id=O.customerId
WHERE O.customerId IS NULL

--QUESTION:Write a solution to report the name and bonus amount of each employee who satisfies either of the following:
--The employee has a bonus less than 1000.
--The employee did not get any bonus

--SOLUTION:
SELECT 
E.name,B.bonus 
FROM Employee AS E
LEFT JOIN Bonus AS B
ON E.empId=B.empId
WHERE bonus<1000 OR
 B.empId IS NULL
