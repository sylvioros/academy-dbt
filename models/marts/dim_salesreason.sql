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
    transform_salesreason as (
        select
            {{dbt_utils.generate_surrogate_key(['idpedido', 'salesreason_name_descr'])}} as sk_salesreason -- _name_descr foi renomeado para motivo
            , salesorderheader_salesreason.idpedido as id_pedido
            , salesorderheader_salesreason.salesreasonid as id_salesreason
            , salesreason.salesreason_name_descr
            , case salesreason.salesreason_name_descr
                when 'Promoção' then 'Sim'
                else 'Não'
            end as ispromocao
            , salesreason.salesreason_type_descr
        , row_number() over (partition by idpedido order by salesorderheader_salesreason.salesreasonid desc) as pedido 
       /* objetivo da window function é tornar id_pedido único para não duplicar as entradas na fato. Esta solução
       faz com que se um pedido tem 2 motivos correlatos (e eles sempre são correlatos), apenas o mais adequado é selecionado.
       Assim, se exibir preço e promoção, o motivo do pedido será considerado promoção. Se exibir fabricação e qualidade, será
       considerado qualidade. Se tiver promoção e outro, será considerado*/
        from salesorderheader_salesreason
        left join salesreason
            on salesorderheader_salesreason.salesreasonid = salesreason.salesreasonid
    )
    ,
    dim_salesreason as (
        select
            sk_salesreason
            ,id_pedido
            ,id_salesreason
            ,salesreason_name_descr as motivo
            ,salesreason_type_descr as motivo_tipo
            ,ispromocao
        from transform_salesreason
        where pedido IN (1)
    )
select *
from dim_salesreason