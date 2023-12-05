with
    customer as (
        select *
        from {{ ref('stg_adw__customer') }}
    )

    , person as (
        select *
        from {{ ref('stg_adw__person') }}
    )

    , store as (
        select *
        from {{ ref('stg_adw__store') }}
    )
    ,
    dim_customer as (
        select
            {{ dbt_utils.generate_surrogate_key(['customer.idcliente']) }} as sk_cliente
            ,customer.idcliente as id_cliente
            ,person.nome
            ,store.loja
        from customer
        left join person
            on customer.personid= person.idbusiness
        left join store
            on customer.idloja = store.idbusiness
    )

select *
from dim_customer