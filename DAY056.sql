--Using farmers and egg_sales, show:
 --farmer name
-- zone
-- total revenue
-- previous farmer’s total revenue within the same zone
--difference between current farmer revenue and the previous farmer’s revenue
--Order farmers by total revenue descending within each zone.
WITH Farmer_revenue AS (
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
		LAG(total_revenue) OVER(PARTITION BY zone ORDER BY total_revenue DESC) AS previous_farmer_revenue,
		total_revenue-
			LAG(total_revenue) OVER(PARTITION BY zone ORDER BY total_revenue DESC) AS difference_in_revenue
	FROM Farmer_revenue
	ORDER BY zone ASC,total_revenue DESC;

--Using farmers and egg_sales, show:
-- farmer name, - zone
-- total revenue
-- cumulative revenue within each zone
--The cumulative total should build from the highest revenue farmer downward within each zone.
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
	SUM(total_revenue)OVER(PARTITION BY zone ORDER BY total_revenue DESC 
		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cummulative_total
FROM Farmer_details
ORDER BY zone,total_revenue DESC;

--Using farmers and egg_sales, show:
--farmer name,zone,total revenue
--percentage contribution of each farmer to the total revenue of their zone
--Round the percentage to 2 decimal places.

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
	ROUND(total_revenue *100.0/SUM(total_revenue) OVER (PARTITION BY zone),2) AS percentage_contribution
FROM Farmer_contribution
ORDER BY zone,total_revenue DESC