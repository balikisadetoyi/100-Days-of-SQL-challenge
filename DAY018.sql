-- Assign a unique row number to each sale ordered by date
SELECT 
	Sale_id,
	sale_date,
	eggs_sold,
	price_per_egg,
	ROW_NUMBER()OVER(ORDER BY sale_date) AS sales_rank
FROM egg_sales;


--Rank farmers by total revenue within each zone

WITH farmer_rev AS (SELECT 
	f.farmer_id,
	f.name,
	f.zone,
	SUM(e.eggs_sold * e.price_per_egg) AS total_revenue
FROM farmers AS f
JOIN egg_sales AS e
ON f.farmer_id=e.farmer_id
	GROUP BY f.farmer_id,f.name,f.zone)

SELECT
farmer_id,
name,
zone,
total_revenue,
RANK() OVER(PARTITION BY zone ORDER BY total_revenue DESC) AS farmer_rev_rank
FROM farmer_rev


-- Rank farmers by age within each zone with no gaps
SELECT 
	farmer_id,
	name,
	age,
	zone,
	DENSE_RANK() OVER (
		PARTITION BY zone ORDER BY age DESC) AS farmer_age_rank
FROM farmers;

-- Divide farmers into 4 equal groups based on total revenue
 WITH farmer_rev  AS (SELECT 
f.farmer_id,
f.name,
SUM(e.eggs_sold * e.price_per_egg) AS revenue
FROM farmers AS f
JOIN egg_sales AS e ON 
f.farmer_id=e.farmer_id
GROUP BY f.farmer_id,f.name)

SELECT *,
NTILE(4) OVER (ORDER BY revenue DESC) AS rev_buckets
FROM farmer_rev

-- Show the cumulative distribution of revenue across all sales
SELECT 
	Sale_id,
	eggs_sold * price_per_egg AS revenue,
	CUME_DIST() OVER(ORDER BY eggs_sold * price_per_egg ASC) AS cum_distance
FROM egg_sales

--Show the percentage rank of each farmer's total revenue
SELECT 
	Sale_id,
	eggs_sold * price_per_egg AS revenue,
	PERCENT_RANK() OVER(ORDER BY eggs_sold * price_per_egg ASC) AS cum_distance
FROM egg_sales

-- Show the first sale date for each farmer alongside every sale
SELECT *,
FIRST_VALUE(sale_date) OVER (PARTITION BY farmer_id ORDER BY sale_date ASC) AS first_sale
FROM egg_sales

--Show the most recent sale date for each farmer alongside every sale
SELECT *,
LAST_VALUE(sale_date) OVER (PARTITION BY farmer_id ORDER BY sale_date ASC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS Last_sale
FROM egg_sales

