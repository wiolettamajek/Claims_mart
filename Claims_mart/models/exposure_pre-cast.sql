WITH convert_validation AS (
    SELECT
        *,
        {{ target.schema }}.can_convert_to_bigint(exposure_id) IS TRUE
        AND {{ target.schema }}.can_convert_to_bigint(claim_id) IS TRUE
        AND {{ target.schema }}.can_convert_to_money(total_payments) IS TRUE
        AND {{ target.schema }}.can_convert_to_date(ingestion_date) IS TRUE
        AS can_row_be_converted
    FROM {{ ref('exposure_rename') }}
)

select
    exposure_id,
    claim_id,
    exposure_type,
    total_payments,
    ingestion_date
from
    convert_validation
where
    can_row_be_converted is TRUE