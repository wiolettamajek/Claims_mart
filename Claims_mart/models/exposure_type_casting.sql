SELECT
    exposure_id::BIGINT AS exposure_id,
    claim_id::BIGINT AS claim_id,
    total_payments::MONEY AS total_payments,
    exposure_type,
    ingestion_date::DATE AS ingestion_date
FROM {{ ref('exposure_values') }}
