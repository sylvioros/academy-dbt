with
    src_salesorder as (
        select
            cast(salesorderid as int) as idpedido
            ,cast(salesorderdetailid as int) as idpedidodetalhado			
            ,cast(orderqty as int) as qtd
            ,cast(productid as int) as idproduto
            ,cast(specialofferid as int) as idoferta
            ,cast(unitprice as float) as preco_unitario
            ,cast(unitpricediscount as float) as desconto
        from {{ source('adw', 'salesorderdetail') }}
    )
select *
from src_salesorder