--Using the farmers and sales tables, write a query to show
--farmer name,zone,total eggs sold,total revenue
--Only include farmers whose total revenue is above the average total revenue across all farmers.
--Sort the result from highest revenue to lowest.


WITH Farmer_details AS (
	SELECT 
		f.name AS farmer_name,
		f.zone,
		SUM(e.eggs_sold) AS total_eggs_sold,
		SUM(e.eggs_sold*e.price_per_egg) AS total_revenue
	FROM farmers AS f
	JOIN egg_sales AS e 
		ON f.farmer_id=e.farmer_id
	GROUP BY 
		f.name,
		f.zone)

SELECT *
FROM Farmer_details
WHERE total_revenue> (SELECT AVG(total_revenue)
        FROM Farmer_details) 
ORDER BY total_revenue DESC;

--Using farmers and egg_sales, return:
--farmer name, zone,total revenue, rank of each farmer 
--within their zone based on total revenue


WITH Farmer_rank AS(
SELECT
	f.name AS farmer_name,
	f.zone,
	SUM(e.eggs_sold*e.price_per_egg) AS total_revenue
FROM farmers AS f
JOIN egg_sales AS e
ON f.farmer_id=e.farmer_id
GROUP BY
	f.name,
	f.zone)

SELECT 
	farmer_name,
	zone,
	total_revenue,
	DENSE_RANK()OVER(PARTITION BY zone ORDER BY total_revenue DESC) AS zone_revenue_rank
FROM Farmer_rank;

--Using farmers and egg_sales, show:
--farmer name, zone, total revenue, zone average revenue , 
--diff between farmer revenue and zone average

WITH Farmer_revenue AS(
SELECT
	f.name AS farmer_name,
	f.zone,
	SUM(e.eggs_sold*e.price_per_egg) AS total_revenue
FROM farmers AS f
JOIN egg_sales AS e
ON f.farmer_id=e.farmer_id
GROUP BY
	f.name,
	f.zone)

SELECT 
	farmer_name,
    zone,
    total_revenue,
AVG(total_revenue) OVER(PARTITION BY zone) AS zone_avg_revenue,
 total_revenue - AVG(total_revenue) OVER (PARTITION BY zone) AS revenue_difference
FROM Farmer_revenue
