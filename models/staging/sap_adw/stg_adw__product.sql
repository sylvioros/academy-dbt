with
    src_product as (
        select
            cast(productid as int) as idproduto
            ,cast(name as string) as nome_produto
            ,cast(productnumber as string) as cod_produto
            ,cast(case when color is null then 'NA'
                else color
            end as string) as cor
            ,cast(safetystocklevel as int) as safetystocklevel
            ,cast(productsubcategoryid as int) as idprodutosubcategoria
            ,cast(productmodelid as int) as idmodeloproduto
        from {{ source('adw', 'product') }}
    )
select *
from src_product