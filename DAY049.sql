--For each farmer, calculate their total sales revenue
--Sort from highest total revenue to lowest.

SELECT 
	f.Farmer_id,
	f.name,
	SUM(e.Eggs_sold) AS total_eggs_sold,
	SUM(e.eggs_sold* e.price_per_egg) AS total_revenue
FROM farmers AS f
JOIN egg_sales AS e
ON f.farmer_id=e.farmer_id
GROUP BY
	f.farmer_id,
	f.name
ORDER BY total_revenue DESC

--Calculate the total amount paid to each farmer.
--Include farmers even if they have never received a payment.

SELECT 
	f.Farmer_ID,
	f.name,
	COALESCE(SUM(p.amount_paid),0) AS payment_received
FROM farmers AS f
LEFT JOIN payments AS p
ON f.farmer_id=p.farmer_id
GROUP BY
	f.farmer_id,
	f.name;


--For each farmer, compare their:
--Total Sales Revenue vs Total Payments Received
--sort by the largest outstanding amount.

WITH Revenue AS (
SELECT  
	farmer_id,
    SUM(eggs_sold * price_per_egg)AS total_revenue
FROM egg_sales
GROUP BY farmer_id),

Payment AS (
SELECT
	farmer_id,
    SUM(amount_paid)AS total_paid
FROM payments
GROUP BY farmer_id)
SELECT
	f.farmer_id,
    f.name,
    r.total_revenue,
    COALESCE(p.total_paid,0) AS total_paid,
  COALESCE(r.total_revenue, 0)
- COALESCE(p.total_paid, 0) AS outstanding_amount 
FROM farmers AS f
LEFT JOIN revenue AS r
    ON f.farmer_id = r.farmer_id
LEFT JOIN payment AS p
    ON f.farmer_id = p.farmer_id
ORDER BY outstanding_amount DESC


