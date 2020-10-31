insert into DimTime
    select 
        distinct(orderDate)
    from 
        NorthwindDB.dbo.Orders