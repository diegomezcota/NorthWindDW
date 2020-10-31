-- insertar valores
insert into FactSales
    select 
        od.ProductID,
        o.EmployeeID,
        cast(o.CustomerID as char(5)),
        o.OrderDate,
        od.OrderID,
        od.Quantity,
        od.UnitPrice,
        od.Discount,
        cast(od.Quantity*od.unitPrice*od.Discount as money),
        cast(od.Quantity*od.unitPrice*(1-od.Discount) as money)
    from 
        NorthwindDB.dbo.[Order Details] od, NorthwindDB.dbo.Orders o
    where
        od.OrderID = o.OrderID
        