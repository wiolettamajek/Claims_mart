select
    *,
    row_number() over (
        partition by motor_id
        order by ingestion_date desc, loss_date desc, source_id asc
    ) as row_number
from {{ ref('policy_number_source_id') }}
