--Management wants to understand how each farmer's sales are changing over time.
--write a query that shows:
--farmer_id
--farmer name
--sale_date
--eggs_sold
---previous_sale_eggs
--change_in_eggs_sold
--For each farmer, compare every sale with their own previous sale, ordered chronologically.

SELECT
	f.Farmer_ID,
	f.name AS farmer_name,
	e.sale_date,
	e.eggs_sold,
	LAG(e.eggs_sold) OVER(PARTITION BY 
		f.Farmer_id ORDER BY e.sale_date ASC) AS previous_sale_eggs,
	e.eggs_sold-
		LAG(e.eggs_sold) OVER(PARTITION BY 
			f.Farmer_id ORDER BY e.sale_date ASC) AS change_in_eggs_sold
FROM farmers AS f
JOIN egg_sales AS e
	ON f.farmer_id=e.farmer_id
ORDER BY  f.farmer_id ASC, e.sale_date ASC
