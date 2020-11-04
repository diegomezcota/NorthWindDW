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
