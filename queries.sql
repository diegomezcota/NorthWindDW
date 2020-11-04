-- Q0.1 Cuales años tienen órdenes
SELECT YEAR(OrderDate)
FROM Orders
GROUP BY YEAR(OrderDate);

-- Q0.2 Cuántos años existen con registros
SELECT COUNT(DISTINCT(YEAR(OrderDate)))
FROM Orders

-- Q1 Producto con más unidades vendidas en 1996
SELECT TOP 1 P.ProductName
FROM [Order Details] AS OD
JOIN Products AS P ON OD.ProductID = P.ProductID
JOIN Orders AS O ON OD.OrderID = O.OrderID
WHERE YEAR(O.OrderDate) = 1996
GROUP BY P.ProductName
ORDER BY SUM(OD.Quantity) DESC

-- Q2 Total de ventas en el 96
SELECT CAST(SUM((OD.UnitPrice * OD.Quantity) * (1 - OD.Discount)) as MONEY)
FROM [Order Details] AS OD
JOIN Orders AS O ON OD.OrderID = O.OrderID
WHERE YEAR(O.OrderDate) = 1996;

-- Q3 Total de ventas en el 97
SELECT CAST(SUM((OD.UnitPrice * OD.Quantity) * (1 - OD.Discount)) as MONEY)
FROM [Order Details] AS OD
JOIN Orders AS O ON OD.OrderID = O.OrderID
WHERE YEAR(O.OrderDate) = 1997;

-- Q4 Total de ventas histórico
SELECT CAST(SUM((OD.UnitPrice * OD.Quantity) * (1 - OD.Discount)) as MONEY)
FROM [Order Details] AS OD
JOIN Orders AS O ON OD.OrderID = O.OrderID;

-- Q5 Producto que generó más ganancias en 1997
SELECT TOP 1 P.ProductName
FROM [Order Details] AS OD
JOIN Products AS P ON OD.ProductID = P.ProductID
JOIN Orders AS O ON OD.OrderID = O.OrderID
WHERE YEAR(O.OrderDate) = 1997
GROUP BY P.ProductName
ORDER BY SUM((OD.UnitPrice * OD.Quantity) * (1 - OD.Discount)) DESC;

-- Q6 Region que generó más ventas en 1997
	-- definición de la función
	CREATE FUNCTION region_ventas_max_1997()
		RETURNS VARCHAR 
		AS
		BEGIN
			DECLARE @VARCHAR VARCHAR;
			SELECT TOP 1 @VARCHAR = O.ShipRegion
			FROM 
				Orders AS O
				JOIN [Order Details] AS OD ON OD.OrderId = O.OrderId
			WHERE YEAR(O.OrderDate) = 1997
			GROUP BY O.ShipRegion
			ORDER BY SUM(OD.UnitPrice * OD.Quantity) DESC;
			RETURN @VARCHAR
		END
	GO
	-- llamado a la función
	select dbo.region_ventas_max_1997()

-- Estado o pais que mas genero de la region de ventas maxima
SELECT IF(
	STRCMP(O.ShipCountry, "USA") = 0,
	O.ShipRegion,
	O.ShipCountry)
FROM Orders as O
JOIN OrderDetails AS OD ON OD.OrderId = O.OrderId
WHERE O.ShipRegion = region_ventas_max()
WHERE YEAR(O.OrderDate) = 1997
ORDER BY SUM(OD.UnitPrice * OD.Quantity) DESC;

-- Total de ventas org por region, estado y pais
SELECT SUM(OD.UnitPrice * OD.Quantity) AS Ventas,
O.ShipRegion, O.ShipState, O.ShipCountry
FROM OrderDetails AS OD
JOIN Orders AS O ON O.OrderId = OD.OrderId
GROUP BY O.ShipRegion, O.ShipState, O.ShipCountry
