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
	-- función que regresa la región con mayor ventas en 1997
	CREATE FUNCTION region_ventas_max_1997()
		RETURNS NVARCHAR(15) 
		AS
		BEGIN
			DECLARE @NVARCHAR NVARCHAR(15);
			SELECT TOP 1 @NVARCHAR = E.Region
			FROM 
				Orders AS O
				JOIN [Order Details] AS OD ON OD.OrderId = O.OrderId
				JOIN Employees as E ON E.EmployeeID = O.EmployeeID
			WHERE YEAR(O.OrderDate) = 1997
			GROUP BY E.Region
			ORDER BY SUM((OD.UnitPrice * OD.Quantity) * (1 - OD.Discount)) DESC;
			RETURN @NVARCHAR
		END
	GO
	-- llamado a la función
	select dbo.region_ventas_max_1997()

-- Q7 Estado o pais que mas genero de la region de ventas maxima
	-- query
	SELECT TOP 1
		CASE WHEN E.Country = 'USA' THEN E.Region ELSE E.Country END
		AS topStateOrRegion
	FROM Orders as O
	JOIN [Order Details] AS OD ON OD.OrderId = O.OrderId
	JOIN Employees AS E ON E.EmployeeID = O.EmployeeID
	WHERE E.Region = dbo.region_ventas_max_1997()
		AND YEAR(O.OrderDate) = 1997
	GROUP BY
		CASE WHEN E.Country = 'USA' THEN E.Region ELSE E.Country END
	ORDER BY SUM((OD.UnitPrice * OD.Quantity) * (1 - OD.Discount)) DESC;

-- Q8 Total de ventas org por region, estado y/o pais
SELECT E.Country, E.Region, SUM((OD.UnitPrice * OD.Quantity) * (1 - OD.Discount)) AS Ventas
FROM [Order Details] AS OD
JOIN Orders AS O ON O.OrderId = OD.OrderId
JOIN Employees AS E ON E.EmployeeID = O.EmployeeID
GROUP BY E.Country, E.Region
