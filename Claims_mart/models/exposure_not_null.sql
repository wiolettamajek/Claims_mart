{% 
    set exposure_null_table = select_table(ref('exposure_pre-cast'), 
                                        ref('exposure_null_input')) 
%}

select *
from
    {{exposure_null_table}}
where
    exposure_id is not null
    and claim_id is not null
    and total_payments is not null
    and ingestion_date is not null
    and exposure_type is not null
