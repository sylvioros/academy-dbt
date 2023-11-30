with
    src_productcategory as (
        select
            cast(productcategoryid as int) as idprodutocategoria
            ,cast(name as string) as categoria
        from {{ source('adw', 'productcategory') }}
    )
select *
from src_productcategory