-- si solo se hace para los valores nulos
update DimCustomer
    set Region = 'Europe'
    where Country in ('Austria', 'Belgium', 'Denmark', 'Finland', 'France', 'Germany', 'Italy',
        'Norway', 'Poland', 'Portugal', 'Spain', 'Sweden', 'Switzerland', 'UK')
        and Region is null

update DimCustomer
    set Region = 'America'
    where Country in ('Argentina', 'Mexico')
        and Region is null
-- si solo se hace para los countries que tengan nulos
update DimCustomer
    set Region = 'Europe'
    where Country in ('Austria', 'Belgium', 'Denmark', 'Finland', 'France', 'Germany', 'Italy',
        'Norway', 'Poland', 'Portugal', 'Spain', 'Sweden', 'Switzerland', 'UK')

update DimCustomer
    set Region = 'America'
    where Country in ('Argentina', 'Mexico')