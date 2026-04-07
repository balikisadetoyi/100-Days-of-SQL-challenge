-- Day 001 | 08 April 2026
-- Platform: LeetCode
-- Question: Write a solution to find the ids of products that are both low fat and recyclable.
--Return the result table in any order.


-- Solution
SELECT Product_id
FROM Products
WHERE low_fats='Y' AND 
recyclable='Y'
