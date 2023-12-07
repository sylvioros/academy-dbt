with
    salesorder as (
        select *
        from {{ ref('stg_adw__salesorder') }}
    )
    ,
    salesorderheader as (
        select *
        from {{ ref('stg_adw__salesorderheader') }}
    )
    ,
    join_salesorder as (
        select
            idpedidodetalhado as id_pedidodetalhado
            , salesorder.idpedido as id_pedido
            , idproduto as id_produto
            , idofertaespecial as id_ofertaespecial
            , preco_unitario
            , preco_unitario * (1 - desconto_unitario) as preco_c_desconto
            , qtd
            , desconto_unitario
            , (preco_unitario * (1 - desconto_unitario)) * qtd as total_por_produto
            , imposto as imposto_total
            , round(imposto / (count(*) over (partition by salesorder.idpedido)) , 2) as imposto_por_pedido
            , frete as frete_total
            , round(frete / (count(*) over (partition by salesorder.idpedido)), 2) as frete_por_pedido
            , round(subtotal, 2) as subtotal
            , round(total, 2) as total
            , cast(extract(date from datapedido) as date) as datapedido
            , status_pedido
            , idcliente as id_cliente
            , idcartao as id_cartao
            , idendereco_cobranca as id_endereco_cobranca
            , idendereco_envio as id_endereco_envio
            , idmetodo_envio as id_metodo_envio
        from salesorder
        left join salesorderheader
            on salesorder.idpedido = salesorderheader.idpedido
    )

select *
from join_salesorder