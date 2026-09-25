--Show all orders where Quantity is greater than 1.
SELECT * FROM ORDERS_PRACTICE
WHERE Quantity>1


--Show each Product and the total quantity sold for that product.
SELECT
	Product,
	SUM(Quantity) AS qty_sold
FROM ORDERS_PRACTICE
GROUP BY Product

--Show each CustomerName and their total amount spent.
SELECT 
	CustomerName,
	SUM(Quantity*UnitPrice) AS total_spent
FROM ORDERS_PRACTICE
GROUP BY
	CustomerName

--Show each CustomerName and the number of orders they placed
SELECT
	CustomerName,
	COUNT(*) AS total_orders
FROM ORDERS_PRACTICE
GROUP BY
	CustomerName




	