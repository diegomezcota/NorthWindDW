-- Q6 Region que generó más ventas en 1997
	-- función que regresa la región con mayor ventas en 1997
	CREATE FUNCTION region_ventas_max_1997()
		RETURNS VARCHAR 
		AS
		BEGIN
			DECLARE @VARCHAR VARCHAR;
			SELECT TOP 1 @VARCHAR = DC.Region
			FROM 
				DimCustomer AS DC
				JOIN [FactSales] AS FS ON FS.CustomerID = DC.CustomerID
				JOIN DimTime AS T ON T.orderDate = FS.orderDate
			WHERE YEAR(T.orderDate) = 1997
			GROUP BY DC.Region
			ORDER BY SUM(FS.UnitPrice * FS.Quantity) DESC;
			RETURN @VARCHAR
		END
	GO
	-- llamado a la función
	select dbo.region_ventas_max_1997()

-- Q7 Estado o pais que mas genero de la region de ventas maxima
	-- definición de función de comparación de 2 strings, STRCMP
	CREATE FUNCTION STRCMP(@str1 varchar, @str2 varchar)
		RETURNS int
		AS
		BEGIN
			DECLARE @ans int;
			IF @str1 = @str2 BEGIN SET @ans = 0 END
			ELSE BEGIN SET @ans = 1 END
			RETURN @ans
		END
	GO
	-- query
	SELECT TOP 1
		CASE WHEN dbo.STRCMP(DC.Country, 'USA') = 0
			THEN DC.Region
			ELSE DC.Country
		END AS topStateOrRegion
	FROM DimCustomer AS DC
	JOIN [FactSales] AS FS ON FS.CustomerID = DC.CustomerID
	JOIN [DimTime] AS T ON T.orderDate = FS.orderDate
	WHERE DC.Region = dbo.region_ventas_max()
		AND YEAR(T.orderDate) = 1997
	
	GROUP BY
		CASE WHEN dbo.STRCMP(O.ShipCountry, 'USA') = 0
			THEN DC.Region
			ELSE DC.Country
		END
	ORDER BY SUM(FS.UnitPrice * FS.Quantity) DESC;

-- Q8 Total de ventas org por region, estado y/o pais
SELECT DC.Country, DC.Region, SUM(FS.UnitPrice * FS.Quantity) AS Ventas
FROM DimCustomer AS DC
JOIN FactSales AS FS ON FS.CustomerID = DC.CustomerID
GROUP BY DC.Region, DC.Country
