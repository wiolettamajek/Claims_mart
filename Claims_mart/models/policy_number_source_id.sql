with source as (
    select *
    from {{ ref ('motor_policy_number') }}
),

added_column as (
    select
        *,
        case
            when policy_number like 'CHB%' then 1
            when policy_number like 'IWV%' then 2
            when policy_number like 'ZOC%' then 1
            when policy_number like 'PRC%' then 1
            when policy_number like 'WZE%' then 1
        end as source_id
    from source

)

select * from added_column
