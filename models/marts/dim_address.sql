with
    address as (
        select *
        from {{ ref('stg_adw__address') }}
    )
    , stateprovince as (
        select *
        from {{ ref('stg_adw__stateprovince') }}
    )
    , countryregion as (
        select *
        from {{ ref('stg_adw__countryregion') }}
    )
    , dim_address as (
        select
            {{ dbt_utils.generate_surrogate_key(['address.idendereco']) }} as sk_endereco
            ,address.idendereco as id_endereco
            ,address.endereco
            ,address.cidade
            ,countryregion.pais
            ,stateprovince.estado
        from address
        left join  stateprovince
            on address.idestado = stateprovince.idestado
        left join countryregion
            on stateprovince.cod_pais = countryregion.cod_pais
    )
select *
from dim_address