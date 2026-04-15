--Date: 14/04/2026
--platform:leetcode
--QUETSION:Find the names of the customer that are either:
--referred by any customer with id != 2.
--not referred by any customer.

SELECT name 
FROM Customer 
WHERE referee_id !=2 OR
referee_id IS NULL 

--QUESTION:Write a solution to find the customer_number for the customer who has placed the largest number of orders.
SELECT  TOP 1 customer_number
FROM (
    SELECT customer_number,
    COUNT(order_number) AS Orders_customer
    FROM Orders
    GROUP BY customer_number  
)T
ORDER BY Orders_customer DESC
