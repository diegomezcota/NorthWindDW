-- Cuales años tienen órdenes
SELECT YEAR(OrderDate)
FROM Orders
GROUP BY YEAR(OrderDate);

-- Cuántos años existen con registros
SELECT COUNT(YEAR(OrderDate))
FROM Orders
GROUP BY YEAR(OrderDate);

-- Producto con más unidades vendidas en 1996
SELECT TOP 1 P.ProductName
FROM OrderDetails AS OD
JOIN Products AS P ON OD.ProductID = P.ProductID
JOIN Orders AS O ON OD.OrderID = O.OrderID
WHERE YEAR(O.OrderDate) = 1996
ORDER BY SUM(OD.Quantity) DESC;

-- Total de ventas en el 96
SELECT SUM((OD.UnitPrice * OD.Quantity) * (1 - OD.Discount))
FROM OrderDetails AS OD
JOIN Orders AS O ON OD.OrderID = O.OrderID
WHERE YEAR(O.OrderDate) = 1996;

-- Total de ventas en el 97
SELECT SUM((OD.UnitPrice * OD.Quantity) * (1 - OD.Discount))
FROM OrderDetails AS OD
JOIN Orders AS O ON OD.OrderID = O.OrderID
WHERE YEAR(O.OrderDate) = 1997;

-- Total de ventas histórico
SELECT SUM((OD.UnitPrice * OD.Quantity) * (1 - OD.Discount))
FROM OrderDetails AS OD
JOIN Orders AS O ON OD.OrderID = O.OrderID;

-- Producto que generó más ganancias en 1997
SELECT TOP 1 P.ProductName
FROM OrderDetails AS OD
JOIN Products AS P ON OD.ProductID = P.ProductID
JOIN Orders AS O ON OD.OrderID = O.OrderID
WHERE YEAR(O.OrderDate) = 1997
ORDER BY SUM((OD.UnitPrice * OD.Quantity) * (1 - OD.Discount)) DESC;
