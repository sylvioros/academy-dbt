with
    salesorderheader_salesreason as (
        select *
        from {{ ref('stg_adw__salesorderheadersalesreason') }}
    )
    ,
    salesreason as (
        select *
        from {{ ref('stg_adw__salesreason') }}
    )
    ,
    dim_salesreason_and_status as (
        select
            {{dbt_utils.generate_surrogate_key(['salesreason.salesreasonid'])}} as sk_salesreason
            , salesorderheader_salesreason.idpedido as id_pedido
            , salesreason.salesreason_name_descr
            , salesreason.salesreason_type_descr
        from salesorderheader_salesreason
        left join salesreason
            on salesorderheader_salesreason.salesreasonid = salesreason.salesreasonid
    )

select *
from dim_salesreason_and_status