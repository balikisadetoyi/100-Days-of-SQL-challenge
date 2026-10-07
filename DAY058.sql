
--Using farmers and egg_sales, show:
-- farmer name,zone,total eggs sold,average price per egg
--Only include farmers who have sold more than 500 eggs in total.
--Order by total eggs sold descending.
SELECT
	f.name AS farmer_name,
	f.zone,
	SUM(e.eggs_sold) AS total_eggs_sold,
	AVG(e.price_per_egg) AS avg_price_per_egg
FROM farmers AS f
JOIN egg_sales AS e
ON f.farmer_id=e.farmer_id
GROUP BY
	f.name,
	f.zone
HAVING SUM(e.eggs_sold) >500
ORDER BY total_eggs_sold DESC


--Using farmers and egg_sales, show:
-- farmer name, zone,number of sales transactions,total revenue
--Only include farmers who have made at least 3 sales transactions.
--Order by total revenue descending.

SELECT
	f.name AS farmer_name,
	f.zone,
	COUNT(e.sale_id) AS total_sales_transaction,
	SUM(e.eggs_sold*e.price_per_egg) AS total_revenue
FROM farmers AS f
JOIN egg_sales AS e
ON f.farmer_id=e.farmer_id
GROUP BY
	f.name,
	f.zone
HAVING 
	COUNT(e.sale_id)>=3
ORDER BY total_revenue DESC


--Using farmers, show:
--- farmer name, zone, age
--Only include farmers who are older than 40.
--Order by age from oldest to youngest.
SELECT
	name AS farmer_name,
	zone,
	age
FROM farmers
WHERE age>40
ORDER BY age DESC
