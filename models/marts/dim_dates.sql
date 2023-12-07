with
    date_series as (
        {{ dbt_utils.date_spine(
            datepart="day",
            start_date="cast('2000-01-01' as date)",
            end_date="date_add('2023-12-31', interval 0 year)"
        )
        }}
    )

    , date_table as (
        select distinct
            cast(date_day as date) as data
            , extract(day from date_day) as diadomes
            , extract(month from date_day) as mesdoano
            , extract(year from date_day) as ano
            --, extract(quarter from date_day) as trimestre
            , case
                when extract(quarter from date_day) = 1 then 'T1'
                when extract(quarter from date_day) = 2 then 'T2'
                when extract(quarter from date_day) = 3 then 'T3'
                when extract(quarter from date_day) = 4 then 'T4'
            end as trimestre
            --, extract(dayofyear from date_day) as diadoano
            --, extract(week from date_day) as semana
            , case
                when
                    extract(day from date_day) != 1 and extract(dayofweek from date_day) = 1
                    then extract(week from date_day)-1
                else extract(week from date_day)
            end as semana
            , case
                when extract(dayofweek from date_day) = 1 then 'Domingo'
                when extract(dayofweek from date_day) = 2 then 'Segunda'
                when extract(dayofweek from date_day) = 3 then 'Terça'
                when extract(dayofweek from date_day) = 4 then 'Quarta'
                when extract(dayofweek from date_day) = 5 then 'Quinta'
                when extract(dayofweek from date_day) = 6 then 'Sexta'
                when extract(dayofweek from date_day) = 7 then 'Sábado'
            end as diadasemana
            , case
                when extract(month from date_day) = 1 then 'Jan'
                when extract(month from date_day) = 2 then 'Fev'
                when extract(month from date_day) = 3 then 'Mar'
                when extract(month from date_day) = 4 then 'Abr'
                when extract(month from date_day) = 5 then 'Mai'
                when extract(month from date_day) = 6 then 'Jun'
                when extract(month from date_day) = 7 then 'Jul'
                when extract(month from date_day) = 8 then 'Ago'
                when extract(month from date_day) = 9 then 'Set'
                when extract(month from date_day) = 10 then 'Out'
                when extract(month from date_day) = 11 then 'Nov'
                when extract(month from date_day) = 12 then 'Dez'
            end as mes
        from date_series
    )

select *
from date_table