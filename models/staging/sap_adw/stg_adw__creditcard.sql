with
    src_creditcard as (
        select
            cast(creditcardid as int) as idcartao
            , cast(cardtype as string) as tipocartao
        from {{ source('adw', 'creditcard') }}
    )
select *
from src_creditcard