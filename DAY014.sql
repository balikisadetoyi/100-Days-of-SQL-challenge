
--For each farmer show each month, their revenue that month, 
--previous month revenue and the % change between the two months. 
--Round the % change to 2 decimal places.

WITH monthly_sales AS(
SELECT 
    farmer_id,
    YEAR(sale_date) AS sale_year,
    MONTH(sale_date) AS sale_month,
    SUM(eggs_sold * price_per_egg) AS revenue
FROM egg_sales
GROUP BY farmer_id,
 YEAR(sale_date),
 MONTH(sale_date) 
 )

SELECT 
farmer_id,
sale_month,
sale_year,
revenue,
LAG(revenue) OVER (PARTITION BY farmer_id ORDER BY sale_year,sale_month)  AS previous_revenue,
ROUND((revenue - LAG(revenue) OVER (PARTITION BY farmer_id ORDER BY sale_year,sale_month))
/ LAG(revenue) OVER ( PARTITION BY farmer_id   ORDER BY sale_year, sale_month) * 100 ,2) AS pct_change_mom
FROM monthly_sales;

---For each farmer who has made more than one payment, show Farmer name,
--Each payment ,The previous payment ,The number of days between the two payments
WITH payments_than_one AS (
SELECT 
    F.farmer_id,
    F.name
FROM farmers AS F
JOIN payments AS P
