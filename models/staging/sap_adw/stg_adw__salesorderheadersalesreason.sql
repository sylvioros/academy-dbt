with
    src_salesorderheader_salesreason as (
        select
            cast(salesorderid as int) as idpedido
            ,cast(salesreasonid as int) as idmotivo		
        from {{ source('adw', 'salesorderheadersalesreason') }}
    )
select *
from src_salesorderheader_salesreason