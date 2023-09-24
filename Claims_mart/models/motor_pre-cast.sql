WITH convert_validation AS (
    SELECT
        *,
        {{ target.schema }}.can_convert_to_bigint(motor_id) IS TRUE
        AND {{ target.schema }}.can_convert_to_timestamp(loss_date) IS TRUE
        AND {{ target.schema }}.can_convert_to_date(year) IS TRUE
        AND {{ target.schema }}.can_convert_to_int(engine_capacity) IS TRUE
        AND {{ target.schema }}.can_convert_to_money(pre_accident_value) IS TRUE
        AND {{ target.schema }}.can_convert_to_money(repair_cost) IS TRUE
        AND
        {{ target.schema }}.can_convert_to_int(average_mileage_for_valuation)
        IS TRUE
        AND {{ target.schema }}.can_convert_to_date(driver_date_of_birth)
        IS TRUE
        AND {{ target.schema }}.can_convert_to_int(doors) IS TRUE
        AND {{ target.schema }}.can_convert_to_int(seats) IS TRUE
        AND {{ target.schema }}.can_convert_to_date(ingestion_date) IS TRUE
        AS can_row_be_converted
    FROM {{ ref('motor_rename') }}
)

select
    motor_id,
    loss_date,
    vehicle_registration_number,
    year,
    make,
    model,
    engine_capacity,
    colour,
    damage_description,
    total_loss_decision,
    pre_accident_value,
    repair_cost,
    average_mileage_for_valuation,
    policy_number,
    driver_date_of_birth,
    fuel_type,
    doors,
    seats,
    ingestion_date
from
    convert_validation
where
    can_row_be_converted is TRUE