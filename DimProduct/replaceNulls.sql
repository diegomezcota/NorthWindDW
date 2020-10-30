-- si solo se hace para los valores nulos
update DimProduct
    set Region = 'Europe'
    where Country in ('Denmark', 'Finland', 'France', 'Germany', 'Italy', 'Netherlands',
        'Norway', 'Sweden', 'UK')
        and Region is null

update DimProduct
    set Region = 'America'
    where Country in ('Brazil')
        and Region is null

update DimProduct
    set Region = 'Asia'
    where Country in ('Japan', 'Singapore')
        and Region is null