insert into DimCustomer
    select
        cast(CustomerID as char(5)),
        cast(CompanyName as varchar(40)),
        cast(City as varchar(15)),
        cast(Country as varchar(15)),
        cast(Region as varchar(15))
    from
        NorthwindDB.dbo.Customers