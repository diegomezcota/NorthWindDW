insert into FactSales
    select 
        od.productID,
        o.employeeID,
        o.customerID,
        o.OrderData,
        od.OrderID,
        od.Quantity,
        od.unitPrice,
        od.Discount,
        