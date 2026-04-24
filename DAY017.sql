
--Categorise farmers by age — Under 30, 30 to 40, Over 40

SELECT 
	farmer_id,
	name,
	age,
	CASE 
		WHEN age <30 THEN 'Under 30'
		WHEN age BETWEEN 30 AND 40 THEN '30 to 40'
		ELSE 'Over 40' 
	END AS age_bands
FROM farmers;

--Count how many farmers fall into each age category

WITH age_bands AS (
SELECT
	farmer_id,
	name,
	CASE 
		WHEN age <30 THEN 'Under 30'
		WHEN age BETWEEN 30 AND 40 THEN '30 to 40'
		ELSE 'Over 40' 
	END AS age_band
FROM farmers)

SELECT 
	age_band,
	COUNT(*) AS total_farmer
FROM age_bands 
GROUP BY age_band

--
--Apply a 10% bonus to revenue for female 
--farmers and 5% for male farmers
SELECT 
f.farmer_id,
f.name,
f.gender,
e.eggs_sold * e.price_per_egg AS revenue,
CASE WHEN f.gender='Female' THEN (e.eggs_sold * e.price_per_egg) * 1.10
	WHEN f.gender='Male' THEN (e.eggs_sold * e.price_per_egg) * 1.05
ELSE (e.eggs_sold * e.price_per_egg) END AS  adjusted_revenue
FROM farmers AS f
JOIN egg_sales AS e
ON f.farmer_id=e.farmer_id

--If price_per_egg is NULL show 0 otherwise show the actual price

SELECT 
price_per_egg,
CASE 
	WHEN price_per_egg IS NULL THEN 0
	ELSE price_per_egg END AS adjusted_price_per_egg
FROM egg_sales

--
--Label each sale as High if revenue is above 40000, 
--Medium if between 20000 and 40000, Low if below 20000
SELECT 
sale_id,
eggs_sold*price_per_egg AS revenue,
CASE
	WHEN eggs_sold*price_per_egg >40000 THEN 'High revenue'
	WHEN eggs_sold*price_per_egg  BETWEEN 20000 AND 40000 THEN 'Medium revenue'
	WHEN eggs_sold*price_per_egg <20000 THEN 'Low revenue' 
END AS revenue_bands
FROM egg_sales
	


SELECT 
	price_per_egg,
	ISNULL(Price_per_egg,0) AS price_per_egg_clean
FROM egg_sales

-- Return farmer name, if NULL return zone, 
--if both NULL return 'Unknown'
SELECT
	COALESCE(name,zone,'Unknown') AS non_null
FROM farmers

--Return NULL if eggs_sold equals 0, otherwise return eggs_sold
SELECT
NULLIF (eggs_sold,0)--SQL server specific
FROM egg_sales
--2nd method
SELECT 
	price_per_egg,
	COALESCE(Price_per_egg,0) AS price_per_egg_clean
FROM egg_sales
--— Find all farmers who have no payments recorded
SELECT f.farmer_id,
f.name
FROM farmers AS f
LEFT JOIN payments AS p
ON f.farmer_id=p.farmer_id
WHERE p.farmer_id IS NULL


--Find all egg sales where either eggs_sold OR price_per_egg is NULL. 
--Show the sale_id and farmer_id
SELECT 
	sale_id,
	farmer_id
FROM egg_sales
WHERE eggs_sold IS NULL 
OR price_per_egg IS NULL