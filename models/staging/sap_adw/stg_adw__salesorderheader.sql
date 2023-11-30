with
    src_salesorderheader as (
        select
            cast(salesorderid as int) as idpedido
            ,cast(customerid as int) as idcliente
            ,cast(salespersonid as int)
            ,cast(territoryid as int) as idterritorio
            ,cast(creditcardid as int) as idcartao
            ,cast(billtoaddressid as int) as idendereco_cobranca
            ,cast(shiptoaddressid as int) as idendereco_envio
            ,cast(shipmethodid as int) as idmetodo_envio
            ,cast(subtotal as float) as subtotal				
            ,cast(taxamt as float) as imposto					
            ,cast(freight as float) as frete					
            ,cast(totaldue as float) as totalc -- resultado de subtotal + taxamt + freight	
            ,cast(onlineorderflag as bool) as flag_pedidoonline		
            ,cast(orderdate as date) as datapedido
            ,cast(duedate as date) as datalimiteentrega
            ,cast(shipdate as) as dataenvio
            ,case status -- obtido do dicionário de dados (fonte: Dataedo)
                when 1 then 'em andamento'
                when 2 then 'aprovado'
                when 3 then 'pendente'
                when 4 then 'rejeitado'
                when 5 then 'enviado'
                when 6 then 'cancelado'
                else null
            end as status
        from {{ source('adw', 'salesorderheader') }}
    )
select *
from src_salesorderheader