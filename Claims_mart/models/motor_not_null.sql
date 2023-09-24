{% 
    set motor_null_table = select_table(ref('motor_pre-cast'), 
                                ref('motor_null_input')) 
%}
select *
from
    {{ motor_null_table }}    
where
    motor_id is not null
    and year is not null
    and make is not null
    and model is not null
    and engine_capacity is not null
    and total_loss_decision is not null
    and policy_number is not null
    and ingestion_date is not null
