with
    dim_address as (
        select *
        from {{ ref('dim_address') }}
    )
    ,
    dim_creditcard as (
        select sk_cartao as fk_cartao
        , id_cartao
        from {{ ref('dim_creditcard') }}
    )
    ,
    dim_customer as (
        select *
        from {{ ref('dim_customer') }}
    )
    ,
    dim_dates as (
        select *
        from {{ ref('dim_dates') }}
    )
    ,
    dim_product as (
        select *
        from {{ ref('dim_product') }}
    )
    ,
    dim_salesreason as (
        select sk_salesreason as fk_salesreason
        , id_pedido
        , id_salesreason
        , ispromocao
        from {{ ref('dim_salesreason') }}
    )
    ,
    int_sales as (
        select *
        from {{ ref('int_fctsales_salesorder') }}
    )
    ,
    join_fct_sales as (
        select
            fk_cartao
            , fk_salesreason
            , id_pedidodetalhado
            , int_sales.id_pedido
            , int_sales.id_produto
            , int_sales.id_cliente
            , dim_creditcard.id_cartao
            --, dim_salesreason.id_salesreason
            , dim_address.id_endereco -- utilizada a chave da tabela dim para lidar com a divergência de endereços (em alguns records, é usado endereco de cobranca, em outros endereco de envio)
            , preco_c_desconto as preco_pago
            , qtd as unidades
            , total_por_produto
            , subtotal as total_bruto
            , total
            , ispromocao
            , datapedido
            --, motivo
            --, motivo_tipo
            , status_pedido
            --, tipocartao as cartao
        from int_sales
        left join dim_address
            on int_sales.id_endereco_envio = dim_address.id_endereco
        left join dim_creditcard
            on int_sales.id_cartao = dim_creditcard.id_cartao
        left join dim_customer
            on int_sales.id_cliente = dim_customer.id_cliente
        left join dim_product
            on int_sales.id_produto = dim_product.id_produto
        left join dim_salesreason
            on int_sales.id_pedido = dim_salesreason.id_pedido
        left join dim_dates
            on int_sales.datapedido = dim_dates.data
    )
    ,
    fct_sales as (
        select
            {{dbt_utils.generate_surrogate_key(['id_pedidodetalhado', 'id_pedido'])}} as sk_vendas
            , {{dbt_utils.generate_surrogate_key(['id_produto'])}} as fk_produto
            , {{ dbt_utils.generate_surrogate_key(['id_cliente']) }} as fk_cliente
            , {{ dbt_utils.generate_surrogate_key(['id_endereco']) }} as fk_endereco
            --, {{dbt_utils.generate_surrogate_key(['id_pedido', 'motivo'])}} as fk_salesreason
            --, {{dbt_utils.generate_surrogate_key(['id_cartao'])}} as fk_cartao
            , *
        from join_fct_sales
    )
select *
from fct_sales