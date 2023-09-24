WITH motor_policy_cleaning AS (
    SELECT
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
        REPLACE(
            (REGEXP_REPLACE(policy_number, '[[:punct:]]', '', 'g')), ' ', ''
        )
        AS policy_number,
        driver_date_of_birth,
        fuel_type,
        doors,
        seats,
        ingestion_date
    FROM {{ ref('motor_values') }}
)

SELECT *
FROM motor_policy_cleaning
WHERE REGEXP_LIKE(
    policy_number, '[A-Z]{3}[0-9]{6}[A-Z]{2}'
)
AND REGEXP_LIKE(make, '^[a-zA-Z ]+$')
