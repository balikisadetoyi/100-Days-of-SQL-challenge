

--List all farmers from Northfield.
SELECT * FROM farmers
WHERE zone='Northfield'

--Count how many farmers are in each zone.
SELECT
	Zone,
	COUNT(Farmer_id) AS totalfarmers
FROM farmers
GROUP BY zone

--Show all egg sales for farmer_id = 1

SELECT * FROM egg_sales
WHERE farmer_id=1

--. Calculate total eggs sold per farmer.

SELECT 
	farmer_id,
	SUM(eggs_sold) AS totaleggs
FROM egg_sales
GROUP BY farmer_id

--Find the average price_per_egg across all sales.

SELECT AVG(price_per_egg) AS avg_eggprice
FROM egg_sales

--Show all payments made in 2024.

SELECT * FROM payments
WHERE YEAR (Payment_date)=2024

--Return the youngest and oldest farmer
SELECT TOP 1 farmer_id,
age AS youngestfarmer
FROM farmers
ORDER BY age ASC
---oldest
SELECT TOP 1 farmer_id,
age AS oldestfarmer
FROM farmers
ORDER BY age DESC

--. Count how many male vs female farmers.
SELECT gender,
COUNT(farmer_id) AS totalfarmers
FROM farmers
GROUP BY gender

--Show all farmers who joined in 2023.
SELECT farmer_id,join_date
FROM farmers
WHERE YEAR(Join_date)=2023


--Calculate total revenue per sale
SELECT 
	SUM(eggs_sold* price_per_egg)  AS totalrevenue
FROM egg_sales

-- Total revenue per farmer
SELECT farmer_id,
SUM(eggs_sold * price_per_egg) AS revenue_perfarmer
FROM egg_sales
GROUP BY farmer_id

--Total payments per farmer
SELECT 
farmer_id,
SUM(amount_paid) AS payment_per_farmer
FROM payments
GROUP BY farmer_id;

--Top 5 farmers by total revenue.
SELECT TOP 5
farmer_id,
SUM(eggs_sold * price_per_egg) AS revenue
FROM egg_sales
GROUP BY farmer_id
ORDER BY SUM(eggs_sold * price_per_egg) DESC

--Average eggs sold per zone

SELECT 
	F.zone,
	AVG(E.eggs_sold) AS avg_eggs_sold
FROM farmers AS F
JOIN egg_sales AS  E
ON F.farmer_id=E.farmer_id
GROUP BY F.zone

--Farmers who have made more than 2 sales
SELECT farmer_id
FROM (
SELECT 
	farmer_id,
	COUNT(Sale_id) AS total_sales
FROM egg_sales
GROUP BY farmer_id
)t
WHERE total_sales > 2

--Farmers with no payments recorded.

SELECT 
	F.farmer_id
FROM farmers AS F
LEFT JOIN payments AS P
ON F.farmer_id=P.farmer_id
	WHERE P.farmer_id IS NULL

