--Using Replenishments, show for each transport mode:
--Number of replenishments,Total shipping cost,Average shipping cost
--Order from the highest to the lowest average shipping cost.

SELECT
	TransportMode,
	COUNT(ReplenishmentID) AS number_of_replenishments,
	SUM(ShippingCost) AS total_cost,
	AVG(ShippingCost) AS avg_cost
FROM Replenishments
GROUP BY
	TransportMode
ORDER BY avg_cost DESC;

--Calculate the total shipping cost for each route.
--Then  return only routes whose total shipping cost is greater than 
--the average total shipping cost across all routes.


WITH route_cost AS (
SELECT
	Route,
	SUM(ShippingCost) AS total_shipping_cost
FROM Replenishments
GROUP BY Route)

SELECT
	 Route,
	 total_shipping_cost
 FROM route_cost
WHERE total_shipping_cost > (
    SELECT AVG(total_shipping_cost)FROM route_cost)
ORDER BY total_shipping_cost DESC



--For every transport mode, rank its routes
--from the highest to the lowest total shipping cost.
--Your output should contain
--Transport mode, route,total shipping cost, rank within the transport mode
WITH Cost AS (
SELECT
	Transportmode,
	route,
	SUM(ShippingCost) AS total_shippingCost
FROM Replenishments
GROUP BY
	Transportmode,
	route)

SELECT
	transportmode,
	route,
	total_shippingCost,
	DENSE_RANK() OVER(PARTITION BY Transportmode ORDER BY total_shippingCost DESC) AS rnk
FROM Cost