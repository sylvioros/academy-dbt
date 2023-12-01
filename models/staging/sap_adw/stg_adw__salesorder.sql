with
    src_salesorder as (
        select
            cast(salesorderdetailid as int) as idpedidodetalhado -- id desta tabela salesorderdetail
            ,cast(salesorderid as int) as idpedido --id da tabela salesorderheader
            ,cast(orderqty as int) as qtd
            ,cast(productid as int) as idproduto
            ,cast(specialofferid as int) as idoferta
            ,cast(unitprice as float64) as preco_unitario
            ,cast(unitpricediscount as float64) as desconto
        from {{ source('adw', 'salesorderdetail') }}
    )
select *
from src_salesorder