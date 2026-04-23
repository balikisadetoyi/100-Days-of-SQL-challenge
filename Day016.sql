-- Show the year each farmer joined
SELECT
	YEAR(Join_date) AS join_year
FROM farmers

--Show the month each sale was made
SELECT 
	MONTH(Sale_date) AS sale_month
FROM egg_sales

-- Show the day of the month each payment was made
SELECT
	DAY(Sale_date) AS day_ofthe_month
FROM egg_sales

--Extract the quarter of each sale date

SELECT
	sale_date,
	DATEPART(QUARTER,sale_date) AS quarter_year
	FROM egg_sales
	
--Show the full month name of each sale date
SELECT
	Sale_date,
	DATENAME(MONTH,sale_date) AS month_full
FROM egg_sales

-- Show the last day of the month for each sale date
SELECT
	Sale_date,
	EOMONTH(Sale_date) AS sale_monthend
FROM egg_sales

-- Calculate how many days between each farmer's join date and their first sale
SELECT
	f.farmer_id,
	f.Join_date,
	MIN(e.sale_date) AS first_saleDate,
	DATEDIFF(DAY,f.join_date,MIN(e.sale_date)) AS time_taken
FROM farmers AS f
	JOIN egg_sales AS e
ON f.farmer_id=e.farmer_id
GROUP BY
	f.farmer_id,
	f.join_date

--Add 30 days to each payment date to show expected next payment date
SELECT
payment_date,
DATEADD(DAY,30,Payment_date) AS next_paymentdate
FROM payments

--Display each sale date as 'DD-MM-YYYY'
SELECT
Sale_date,
FORMAT(Sale_date,'dd-MM-yyyy') AS new_dateformat
FROM egg_sales

-- Convert sale date to a different format
SELECT
Sale_date,
CONVERT(VARCHAR, Sale_date,103) AS newdate
FROM egg_sales

--Cast sale date as a string
SELECT
Sale_date,
CAST(Sale_date AS VARCHAR) AS new_dateFormat
FROM  egg_sales

--Check if '2023-13-45' is a valid date

SELECT ISDATE('2023-13-45') AS is_valid_date