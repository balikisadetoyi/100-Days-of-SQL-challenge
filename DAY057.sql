--Using farmers and egg_sales, show:
-- farmer name, zone, total revenue, the average revenue of all farmers
-- the difference between each farmer’s revenue and the overall average
--Order the result by total_revenue from highest to lowest.

WITH Farmer_record AS (
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
	AVG(total_revenue) OVER() AS avg_revenue,
	total_revenue-AVG(total_revenue) OVER() AS diff_from_average
FROM Farmer_record
ORDER BY total_revenue DESC;


--Using farmers and egg_sales, show:
--- farmer name, zone
--total revenue,the highest farmer revenue in that farmer’s zone
 --the difference between the farmer’s revenue and the highest revenue in their zone
--Order by zone, then total_revenue descending.

WITH Farmer_details AS (
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
	MAX(total_revenue) OVER(PARTITION BY zone) AS highest_zone_revenue,
	total_revenue-MAX(total_revenue) OVER(PARTITION BY zone) AS difference_from_zone_highest
FROM Farmer_details
ORDER BY zone,total_revenue DESC;


--Using farmers and egg_sales, show:
--farmer name,zone, total revenue
-- the percentage of the zone’s total revenue contributed by each farmer
-- the rank of each farmer within their zone by total revenue
--Round the percentage to 2 decimal places.
--Order by zone, then rank.


WITH Farmer_contribution AS (
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
	ROUND(total_revenue *100.0/
		SUM(total_revenue) OVER(PARTITION BY zone),2) AS zone_percentage_contribution,
		DENSE_RANK()OVER(PARTITION BY zone ORDER BY total_revenue DESC) AS farmer_rank
FROM Farmer_contribution
ORDER BY 
	zone,
	farmer_rank
