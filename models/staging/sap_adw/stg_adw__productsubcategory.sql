with
    src_productsubcategory as (
        select
            cast(productsubcategoryid as int) as idprodutosubcategoria
            ,cast(productcategoryid as int) as idprodutocategoria
            ,cast(name as string) as subcategoria
        from {{ source('adw', 'productsubcategory') }}
    )
select *
with
    src_productsubcategory as (
        select
            cast(productsubcategoryid as int) as idprodutosubcategoria
            ,cast(productcategoryid as int) as idprodutocategoria
            ,cast(name as string) as subcategoria
        from {{ source('adw', 'productsubcategory') }}
    )
select *
from src_productsubcategory