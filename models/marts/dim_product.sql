with
    product as (
        select *
        from {{ ref('stg_adw__product') }}
    )
    ,
    product_category as (
        select *
        from {{ ref('stg_adw__productcategory') }}
    )
    ,
    product_subcategory as (
        select *
        from {{ ref('stg_adw__productsubcategory') }}
    )
    ,
    dim_product as (
        select
            {{dbt_utils.generate_surrogate_key(['product.idproduto'])}} as sk_produto
            , product.idproduto as id_produto
            , product.nome_produto as produto
            , product.cor 
            , product_category.categoria
            , product_subcategory.subcategoria
        from product
        left join product_subcategory
            on product.idprodutosubcategoria = product_subcategory.idprodutosubcategoria
        left join product_category
            on product_subcategory.idprodutocategoria = product_category.idprodutocategoria
    )

select *
from dim_product