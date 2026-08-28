---Management wants to identify farmers whose egg sales are consistently improving.
--Write a query that returns:

--farmer_id,name,sale_date,eggs_sold,previous_sale_eggs,percentage_change
--Only return sales where the farmer sold more eggs than in their previous sale.
--order by farmer_id,sale_date


WITH Farmer_details AS (
SELECT
	f.farmer_id,
	f.name,
	e.sale_date,
	e.eggs_sold,
	LAG(e.eggs_sold) OVER(PARTITION BY f.farmer_id ORDER BY e.sale_date ASC) AS previous_sale_eggs
FROM farmers AS f
JOIN egg_sales AS e
ON f.farmer_id=e.farmer_id)


SELECT
	farmer_id,
	name,
	sale_date,
	eggs_sold,
	previous_sale_eggs,
	((eggs_sold-previous_sale_eggs)*1.0/previous_sale_eggs)*100.0 AS Percentage_change
FROM Farmer_details
WHERE eggs_sold>previous_sale_eggs
ORDER BY farmer_id,sale_date