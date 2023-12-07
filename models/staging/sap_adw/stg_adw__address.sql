with
    src_address as (
        select
            cast(addressid as int) as idendereco
            , cast(addressline1 as string) as endereco			
            , cast(city as string) as cidade
            , cast(stateprovinceid as int) as idestado		
            , cast(postalcode as string) as codigopostal											
        from {{ source('adw', 'address') }}
    )

select *
from src_address