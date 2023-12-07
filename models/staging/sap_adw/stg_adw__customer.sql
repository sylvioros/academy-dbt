with
    src_customer as (
        select
            cast(customerid as int) as idcliente
            ,cast(personid as int) as personid -- mesmo que businessentityid na tabela Person
            ,cast(storeid as int) as idloja -- mesmo que businessentityid na tabela Store
            ,cast(territoryid as int) as idterritorio
        from {{ source('adw', 'customer') }}
    )
select *
from src_customer