{% 
    set motor_table = select_table(source('raw', 'motor'), 
                                        ref('motor_rename_input')) 
%}
select
    mid as motor_id,
    ld as loss_date,
    vrn as vehicle_registration_number,
    y as year,
    m as make,
    mo as model,
    ec as engine_capacity,
    col as colour,
    dd as damage_description,
    tld as total_loss_decision,
    pav as pre_accident_value,
    rc as repair_cost,
    amfv as average_mileage_for_valuation,
    pn as policy_number,
    ddob as driver_date_of_birth,
    ft as fuel_type,
    d as doors,
    s as seats,
    id as ingestion_date
from
    {{ motor_table }}
