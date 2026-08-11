---Using the OutboundShipments table, analyse shipping-cost variability for each transport mode.
--Return:
--Transport mode
--Number of shipments
--Minimum shipping cost
--Maximum shipping cost
--Average shipping cost
--Median shipping cost
--Standard deviation of shipping cost
--Order the results from the highest to the lowest average shipping cost.


WITH Median_cost AS(
SELECT DISTINCT
	TransportMode,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY ShippingCost)
        OVER (PARTITION BY TransportMode) AS median_shippingCost
FROM OutboundShipments),

Shipping_Summary AS(
SELECT
	TransportMode,
	COUNT(ShipmentID) AS totalShipments,
	MIN(ShippingCost) AS min_shippingCost,
	MAX(ShippingCost) AS max_shippingCost,
	AVG(ShippingCost) AS avg_shippingCost,
	STDEV(ShippingCost) AS stdev_ShippingCost
FROM OutboundShipments
GROUP BY
	TransportMode)

SELECT
	s.TransportMode,
	s.totalShipments,
	s.min_shippingCost,
	s.max_shippingCost,
	s.avg_shippingCost,
	m.median_shippingCost,
	s.stdev_ShippingCost
FROM Shipping_Summary AS s
JOIN Median_cost AS m
ON s.TransportMode=m.TransportMode
ORDER BY avg_shippingCost DESC

