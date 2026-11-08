--Retrieve the names and zones of all farmers who are older than 30.
SELECT
	name,
	zone
FROM farmers
WHERE age>30

--Find the total number of eggs sold by each farmer. Display farmer_id and the total eggs sold.
SELECT
	farmer_id,
	SUM(eggs_sold) AS total_eggs_sold
FROM egg_sales
GROUP BY farmer_id


--Display each farmer's name alongside the total number of eggs they have sold.
--Include only farmers who have recorded sales.
SELECT
	f.name AS farmer_name,
	SUM(e.eggs_sold) AS total_eggs_sold
FROM farmers AS f
JOIN egg_sales AS e
ON f.farmer_id=e.farmer_id
GROUP BY f.name

