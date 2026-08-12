---Using Suppliers and Replenishments, evaluate delivery performance for each supplier.
--Return:Supplier name,Supplier region,Number of replenishments
--Average shipping cost,Number of on-time deliveries,On-time delivery percentage
--Rank suppliers from highest to lowest on-time percentage
WITH DeliveryPerformance AS (
SELECT
	s.SupplierName,
	s.Region,
	COUNT(r.ReplenishmentID) AS total_replenishments,
	AVG(r.shippingCost) AS avg_shipmentCost,
	SUM(CASE WHEN r.ActualDeliveryDate <= r.ExpectedDeliveryDate THEN 1 ELSE 0 END ) AS Ontime_deliveries,
	SUM(CASE WHEN r.ActualDeliveryDate <= r.ExpectedDeliveryDate THEN 1 ELSE 0 END )*1.0/COUNT(r.ReplenishmentID) *100 AS Ontime_deliveries_percentage
FROM Suppliers AS s
JOIN Replenishments AS r
ON s.SupplierID=r.SupplierID
GROUP BY
	s.SupplierName,
	s.Region
HAVING COUNT(r.ReplenishmentID) >= 5)


SELECT
*,
DENSE_RANK() OVER(ORDER BY Ontime_deliveries_percentage DESC) AS rnk
FROM DeliveryPerformance


