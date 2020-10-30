insert into DimProduct
    select 
        p.ProductID, 
        cast(p.ProductName as varchar(40)),
        cast(c.categoryName as varchar(15)),
        cast(s.CompanyName as varchar(40)),
        cast(s.Address as varchar(60)),
        cast(s.City as varchar(15)),
        cast(s.Region as varchar(15)),
        cast(s.PostalCode as varchar(10)),
        cast(s.Country as varchar(15))
    from NorthwindDB.dbo.Products p, 
        NorthwindDB.dbo.Categories c, 
        NorthwindDB.dbo.Suppliers s
    where p.CategoryID = c.CategoryID
        and p.SupplierID = s.SupplierID