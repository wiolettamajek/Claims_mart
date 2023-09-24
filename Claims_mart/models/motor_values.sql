SELECT
    *,
    total_loss_decision IN ('Repair', 'TotalLoss', 'TotalLoss/Repair')
    AND fuel_type IN (
        'DIESEL', 'DIESEL/ELECTRIC', 'DIESEL/MHEV', 'ELECTRIC', 'PETROL',
        'PETROL/ALCOHOL', 'PETROL/ELECTRIC'
    )
    AND doors IN (0, 2, 3, 4, 5, 6)
    AND seats IN (0, 2, 3, 4, 5, 6, 7, 8, 9)
    AND
    CASE
        WHEN total_loss_decision = 'TotalLoss'
            THEN repair_cost > pre_accident_value
        WHEN total_loss_decision = 'Repair'
            THEN repair_cost < pre_accident_value
        WHEN total_loss_decision = 'TotalLoss/Repair'
            THEN
                repair_cost BETWEEN (1.1 * pre_accident_value)
                AND (1.3 * pre_accident_value)
        ELSE FALSE
    END AS is_row_valid
FROM {{ ref('motor_type_casting') }}
