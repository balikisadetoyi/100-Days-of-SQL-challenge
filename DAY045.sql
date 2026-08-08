--Using the Replenishments table, identify routes 
--whose average shipping cost is higher than
--the overall average shipping cost for their transport mode.
--RETURN Transport mode
--Route
--Number of replenishments
--Route average shipping cost
--Transport mode average shipping cost
--Difference between the two averages
--Order the results by the largest difference first.

WIth route_avgShipCost AS (
SELECT 
	TransportMode,
	route,
	COUNT(ReplenishmentID) AS numberOfReplenishment,
	AVG(ShippingCost) AS avg_routeShippingCost
FROM Replenishments
GROUP BY
	Route,
	TransportMode),

transport_modeAvgShipCost AS(
SELECT
	TransportMode,
	AVG(ShippingCost) AS transportMode_avgShippingCost
FROM Replenishments
GROUP BY 
	TransportMode)

SELECT
	r.TransportMode,
	r.route,
	r.numberOfReplenishment,
	r.avg_routeShippingCost,
	t.transportMode_avgShippingCost,
	r.avg_routeShippingCost-t.transportMode_avgShippingCost AS difference
FROM route_avgShipCost AS r
JOIN transport_modeAvgShipCost AS t
ON r.TransportMode=t.TransportMode
WHERE r.avg_routeShippingCost > t.transportMode_avgShippingCost
ORDER BY difference DESC