
--For each farmer, show each sale date, the revenue for that sale, and a running total of
--their revenue up to and including that sale. Order by farmer then by date.

SELECT farmer_id,
sale_date,
(eggs_sold* price_per_egg) AS revenue,

SUM(eggs_sold* price_per_egg) OVER (PARTITION BY farmer_id ORDER BY sale_date
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS runningtotal
FROM egg_sales;

--For each farmer, calculate their total revenue in 2023 and total revenue in 2024. 
--show both side by side with the difference between the two years. 
--Only include farmers who have sales in both years

WITH revenue2023 AS (SELECT 
    farmer_id,
    SUM(eggs_sold * price_per_egg) AS total_revenue_2023
FROM egg_sales
WHERE YEAR(sale_date) = 2023
GROUP BY farmer_id),

revenue2024 AS (
SELECT 
    farmer_id,
    SUM(eggs_sold * price_per_egg) AS total_revenue_2024
FROM egg_sales
WHERE YEAR(sale_date) = 2024
GROUP BY farmer_id)

SELECT ra.farmer_id,
 total_revenue_2023,
 total_revenue_2024,
 total_revenue_2024-total_revenue_2023 AS diff

 FROM revenue2023 AS ra
 JOIN revenue2024 AS ri
 ON ra.farmer_id=ri.farmer_id

 --For each zone, return only the farmer with the highest total revenue. 
 --If two farmers in the same zone have the same revenue, 
 --return both. Show farmer name, zone and total revenue.

 WITH revenue_per_farmer AS (
    SELECT 
        f.farmer_id,
        f.name,
        f.zone,
        SUM(e.eggs_sold * e.price_per_egg) AS totalrevenue
    FROM farmers AS f
    JOIN egg_sales AS e
        ON f.farmer_id = e.farmer_id
    GROUP BY f.farmer_id, f.name, f.zone
),
ranked AS (
    SELECT 
        farmer_id,
        name,
        zone,
        totalrevenue,
        RANK() OVER (PARTITION BY zone ORDER BY totalrevenue DESC) AS rnk
    FROM revenue_per_farmer
)
SELECT 
    farmer_id,
    name,
    zone,
    totalrevenue
FROM ranked
WHERE rnk = 1
