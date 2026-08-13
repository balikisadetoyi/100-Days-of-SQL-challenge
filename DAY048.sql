---Using Products, Inventory, and Warehouses, identify inventory concentration by product category.
--Return:
--Product category
--Number of distinct products
--Number of warehouses holding that category
--Total units in stock
--Average units in stock per inventory record
--Percentage of all inventory units represented by the category
--Rank from highest to lowest total units
--Only include categories held in at least two warehouses.

SELECT 
	p.Category,
	COUNT(DISTINCT p.ProductID) AS distinctProducts_number,
	COUNT(DISTINCT w.WarehouseID) AS warehouses,
	SUM(i.stockOnHand) AS unitsInStock,
	AVG(i.stockOnHand) AS avg_unitInStock,
    SUM(i.stockOnHand)*1.0
            / (SELECT SUM(StockOnHand) FROM Inventory)*100 AS categoryPercentage,
    DENSE_RANK()OVER(ORDER BY SUM(i.stockOnHand) DESC) AS stock_rank
FROM Products AS p
JOIN Inventory AS i
    ON p.ProductID=i.ProductID
JOIN Warehouses AS w
    ON w.WarehouseID=i.WarehouseID
GROUP BY
	p.Category
HAVING COUNT(DISTINCT w.warehouseID) >= 2
ORDER BY unitsInStock DESC;



