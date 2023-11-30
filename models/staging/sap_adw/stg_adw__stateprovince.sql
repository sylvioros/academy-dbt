with
    src_stateprovince as (
        select
            cast(stateprovinceid as int) as idestado	
            ,cast(stateprovincecode as string) as cod_estado			
            ,cast(countryregioncode as string) as cod_pais
            ,cast(name as string) as estado	
            ,cast(territoryid as int) as idterritorio										
        from {{ source('adw', 'stateprovince') }}
    )

select *
from src_stateprovince