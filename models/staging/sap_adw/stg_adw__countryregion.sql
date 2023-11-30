with
    src_country as (
        select
            cast(countryregioncode as string) as cod_pais
            ,cast(name as string) as pais
        from {{ source('adw', 'countryregion') }}
    )

select *
from src_country