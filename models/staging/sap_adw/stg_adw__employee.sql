with
    src_employee as (
        select
            cast(businessentityid as int) as idbusiness				
            ,cast(jobtitle as string) as cargo			
            ,cast(birthdate as date) as nascimento			
            ,cast(maritalstatus as string) as estadocivil				
            ,cast(gender as string) as sexo		
            ,cast(hiredate as date) as datacontratacao		
            ,cast(salariedflag as bool) as flag_salario							
            ,cast(currentflag as bool) as flag_atual
        from {{ source('adw', 'employee') }}
    )
select *
from src_employee