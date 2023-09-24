{{ config(materialized='table') }}
select
    make,
    round(
        (
            count(*)
            filter (where total_loss_decision like 'TotalLoss')
        )::decimal / (count(*)) * 100, 2
    )
    as total_loss_ratio
from {{ ref ('motor_deduplication') }}
where total_loss_decision in ('TotalLoss', 'Repair')
group by make
order by total_loss_ratio desc
