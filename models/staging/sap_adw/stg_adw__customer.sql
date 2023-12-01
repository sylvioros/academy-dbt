with
    src_customer as (
        select
            cast(customerid as int) as idcliente
            ,cast(personid as int) as personid
            ,cast(storeid as int) as idloja
            ,cast(territoryid as int) as idterritorio
        from {{ source('adw', 'customer') }}
    )
select *
from src_customer