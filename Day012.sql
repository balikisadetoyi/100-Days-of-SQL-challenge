
--For each farmer, calculate total revenue and rank them within their zone by revenue

With farmer_revenue AS (SELECT
farmer_id,
SUM(eggs_sold * price_per_egg) AS totalrevenue
FROM egg_sales
GROUP BY farmer_id
)

SELECT 
	fr.farmer_id,
	fr.totalrevenue,
	F.zone,
	RANK()OVER( PARTITION BY F.zone ORDER BY fr.totalrevenue DESC) AS farmer_rank
FROM farmer_revenue AS fr
	JOIN farmers AS F
ON fr.farmer_id=F.farmer_id;


--For each farmer, calculate the sum of their current sale + previous sale
WITH farmer_sales AS (
SELECT farmer_id,
eggs_sold * price_per_egg AS current_sale ,
LAG(eggs_sold * price_per_egg) OVER (PARTITION BY farmer_id ORDER BY sale_date) AS previous_sale

FROM egg_sales)

SELECT 
	farmer_id,
	current_sale,
    previous_sale,
current_sale + previous_sale AS total_sale
FROM farmer_sales;



--Return farmers whose total revenue is greater than the average revenue of their zone.
WITH revenue_per_farmer AS (
SELECT farmer_id,
SUM(eggs_sold * price_per_egg)AS totalrevenue
FROM egg_sales
GROUP BY farmer_id)


,zone_avg AS(
SELECT f.farmer_id,
f.zone,
totalrevenue,
AVG(totalrevenue) OVER (PARTITION BY f.zone) AS avg_zonerevenue
FROM revenue_per_farmer AS r
JOIN farmers AS f
on r.farmer_id=f.farmer_id)

Select farmer_id 
FROM zone_avg
WHERE totalrevenue > avg_zonerevenue
 




--Return only the latest sale for each farmer.
--If two sales have the same date, return the one with more eggs_sold.
SELECT 
	farmer_id,
	sales
FROM (
SELECT farmer_id,
eggs_sold* price_per_egg AS sales,
RANK() OVER(PARTITION BY farmer_id ORDER BY sale_date DESC, eggs_sold DESC) AS sales_rank

FROM egg_sales)t
WHERE sales_rank=1


--For each farmer and each month, return:

--month,monthly revenue,previous month revenue,difference
WITH monthlysales AS (
SELECT 
	farmer_id,
	MONTH(Sale_date) AS month_sold ,
	SUM(eggs_sold* price_per_egg) AS monthly_rev
FROM egg_sales
GROUP BY farmer_id,MONTH(Sale_date))

SELECT *,
LAG(monthly_rev) OVER(PARTITION BY farmer_id ORDER BY month_sold) AS previous_revenue,
monthly_rev-LAG(monthly_rev) OVER(PARTITION BY farmer_id ORDER BY month_sold) AS diff_insales
FROM monthlysales

