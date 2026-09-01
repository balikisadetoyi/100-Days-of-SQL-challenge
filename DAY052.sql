--write a query that returns each customer's order,
--their previous order value, and the difference between the
--current order value and their previous order value.

SELECT
	CustomerID,
	OrderDate,
	OrderValue,
	LAG(OrderValue) OVER(PARTITION BY CustomerID
		ORDER BY OrderDate) AS previousOrderValue,
	OrderValue-
		LAG(OrderValue) OVER(PARTITION BY CustomerID 
			ORDER BY OrderDate)  AS ValueDifference
FROM Orders
	