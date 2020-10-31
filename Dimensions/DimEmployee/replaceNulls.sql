-- Reemplazar valores nulos por continente
update DimCustomer
    set Region = 'Europe'
    where Country = 'UK'
        and Region is null