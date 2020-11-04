-- Q0.1 Cuales años tienen órdenes
SELECT YEAR(OrderDate)
FROM DimTime
GROUP BY YEAR(OrderDate);

-- Q0.2 Cuántos años existen con registros
SELECT COUNT(DISTINCT(YEAR(OrderDate)))
FROM DimTime

-- Q1 Producto con más unidades vendidas en 1996
SELECT TOP 1 DP.ProductName
FROM DimProduct as DP
	JOIN FactSales as FS on DP.ProductID = FS.ProductID
WHERE YEAR(FS.orderDate) = 1996
GROUP BY DP.ProductName
ORDER BY SUM(FS.Quantity) DESC

-- Q2 Total de ventas en el 96
SELECT SUM(total)
FROM FactSales
where Year(OrderDate) = 1996

-- Q3 Total de ventas en el 97
SELECT SUM(total)
FROM FactSales
where Year(OrderDate) = 1997

-- Q4 Total de ventas histórico
SELECT SUM(total)
FROM FactSales

-- Q6 Region que generó más ventas en 1997
	-- función que regresa la región con mayor ventas en 1997
	CREATE FUNCTION region_ventas_max_1997()
		RETURNS VARCHAR(15) 
		AS
		BEGIN
			DECLARE @VARCHAR VARCHAR(15);
			SELECT TOP 1 @VARCHAR = DC.Region
			FROM 
				DimCustomer AS DC
				JOIN FactSales AS FS ON FS.CustomerID = DC.CustomerID
			WHERE YEAR(FS.orderDate) = 1997
			GROUP BY DC.Region
			ORDER BY SUM(FS.UnitPrice * FS.Quantity) DESC;
			RETURN @VARCHAR
		END
	GO
	-- llamado a la función
	select dbo.region_ventas_max_1997()

-- Q7 Estado o pais que mas genero de la region de ventas maxima
	-- query
	SELECT TOP 1
		CASE WHEN DC.Country = 'USA' THEN DC.Region ELSE DC.Country END
		AS topStateOrRegion
	FROM DimCustomer AS DC
		JOIN FactSales AS FS ON FS.CustomerID = DC.CustomerID
	WHERE DC.Region = dbo.region_ventas_max_1997()
		AND YEAR(FS.orderDate) = 1997
	GROUP BY
		CASE WHEN DC.Country = 'USA' THEN DC.Region ELSE DC.Country END
	ORDER BY SUM(FS.UnitPrice * FS.Quantity) DESC;

-- Q8 Total de ventas org por region, estado y/o pais
SELECT DC.Country, DC.Region, SUM(FS.UnitPrice * FS.Quantity) AS Ventas
FROM DimCustomer AS DC
JOIN FactSales AS FS ON FS.CustomerID = DC.CustomerID
GROUP BY DC.Region, DC.Country
