with
    src_store as (
        select
            cast(businessentityid as int) as idbusiness		
            ,cast(name as string) as loja
            ,cast(salespersonid as int)	 as salespersonid
            --cast(jobtitle as string) as cargo				
            --cast(salariedflag as bool) as flag_salario							
            --cast(currentflag as bool) as flag_atual
        from {{ source('adw', 'store') }}
    )
select *
from src_store