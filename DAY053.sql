--Find the total eggs sold and total sales revenue for each farmer.
SELECT
	f.Farmer_id,
	f.name,
	SUM(e.eggs_sold) AS total_eggs_sold,
	SUM(e.eggs_sold *e.price_per_egg) AS Revenue
FROM farmers AS f
JOIN egg_sales AS e
ON f.farmer_id=e.farmer_id
GROUP BY
	f.farmer_id,
	f.name;


--Show each farmer’s total sales revenue, total payments received, and outstanding balance
WITH farmer_sales AS (
    SELECT
        farmer_id,
        SUM(eggs_sold * price_per_egg) AS total_sales
    FROM egg_sales
    GROUP BY farmer_id),

Total_payments AS (
    SELECT
       farmer_id,
       SUM(amount_paid) AS total
    FROM payments
    GROUP BY farmer_id)

SELECT
    f.farmer_id,
    f.name,
    s.total_sales,
    p.total,
    s.total_sales - p.total AS outstanding_balance
FROM farmers AS f
LEFT JOIN farmer_sales AS s
    ON f.farmer_id = s.farmer_id
LEFT JOIN Total_payments AS p
    ON f.farmer_id = p.farmer_id
ORDER BY outstanding_balance DESC
