--Write a query to show each farmer’s name, zone, total eggs sold, and a category:
---High Seller if total eggs sold is greater than 700
---Medium Seller if total eggs sold is between 300 and 700
--- Low Seller if total eggs sold is below 300

SELECT
	f.name AS farmer_name,
	f.zone,
	SUM(e.eggs_sold) AS total_eggs_sold,
	CASE
		WHEN SUM(e.eggs_sold)>700 THEN 'High Seller'
		WHEN SUM(e.eggs_sold) BETWEEN 300 AND 700 THEN 'Medium Seller'
		WHEN SUM(e.eggs_sold) <300 THEN 'Low Seller'
		END AS Sales_category
FROM farmers AS f
JOIN egg_sales AS e
	ON f.farmer_id=e.farmer_id
GROUP BY 
	f.name,
	f.zone

--Show each farmer’s name, first sale date, and most recent sale date.
SELECT
	f.farmer_id,
	f.name AS farmer_name,
	MIN(e.sale_date) AS first_sale_date,
	MAX(e.sale_date) AS recent_sale_date
FROM farmers AS f
JOIN egg_sales AS e
ON f.farmer_id=e.farmer_id
GROUP BY 
	f.farmer_id,
	f.name

	--Show each zone, the number of farmers in that zone, and the average age of farmers, 
	--but only return zones where the average age is greater than 35.

SELECT
	zone,
	COUNT(Farmer_id) AS number_of_farmers,
	AVG(age) AS avg_farmer_age
FROM farmers
GROUP BY zone
HAVING AVG(age)>35



