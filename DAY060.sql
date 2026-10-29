--Write a query to display farmer_id, name, zone and age for farmers who are older than 40.
SELECT
	Farmer_id,
	name,
	zone,
	age
FROM farmers
WHERE age>40


--Write a query to show the number of farmers in each zone.

--Return zone and total_farmers, ordered from highest to lowest.

SELECT
	Zone,
	COUNT(Farmer_id) AS total_farmers
FROM farmers
GROUP BY zone
ORDER BY total_farmers DESC


--Using egg_sales, write a query to calculate the total number of eggs sold by each farmer.

SELECT
	farmer_id,
	SUM(eggs_sold) AS total_eggs_sold
FROM egg_sales
GROUP BY farmer_id