with
    src_salesreason as (
        select
            cast(salesreasonid as int)
            ,cast(name as string) as salesreason_name
            ,cast(reasontype as string) as salesreason_type
        from {{ source('adw', 'salesreason') }}
    )
select *
from src_salesreason