with
    creditcard as (
        select
            idcartao as id_cartao -- ajustando nome pra deixar com espaço
            ,tipocartao
        from {{ ref('stg_adw__creditcard') }}
    )
    ,
    dim_creditcard as (
        select
            {{dbt_utils.generate_surrogate_key(['creditcard.id_cartao'])}} as sk_cartao
            , *
        from creditcard
    )

select *
from dim_creditcard