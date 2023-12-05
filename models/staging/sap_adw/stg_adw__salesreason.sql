with
    src_salesreason as (
        select
            cast(salesreasonid as int) as salesreasonid
            ,cast(case name
                when 'Price' then 'Preço'
                when 'Manufacturer' then 'Fabricação'
                when 'Quality' then 'Qualidade'
                when 'Other' then 'Outro'
                when 'Magazine Advertisement' then 'Anúncio de revista'
                when 'Television  Advertisement' then 'Comercial de TV'
                when 'Demo Event' then 'Evento de demonstração'
                when 'Sponsorship' then 'Patrocínio'
                when 'On Promotion' then 'Promoção'
                else name
            end as string) as salesreason_name_descr
            ,cast(case reasontype
                when 'Other' then 'Outro'
                when 'Promotion' then 'Campanhas'
                else reasontype
            end as string) as salesreason_type_descr
        from {{ source('adw', 'salesreason') }}
    )
select *
from src_salesreason