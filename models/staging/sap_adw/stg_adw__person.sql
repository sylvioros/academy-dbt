with
    src_person as (
        select
            cast(businessentityid as int) as idbusiness
            ,cast(firstname || ' ' || lastname as string) as nome
            ,cast(persontype as string) as persontype
            ,cast(case persontype
                when 'EM' then 'Employee (non-sales)'
                when 'GC' then 'General contact'
                when 'IN' then 'Individual customer'
                when 'SC' then 'Store Contact'
                when 'SP' then 'Sales person'
                when 'VC' then 'Vendor contact'
                else 'Others'
            end as string) as persontype_descr
        from {{ source('adw', 'person') }}
    )
select *
from src_person
