{% 
    set exposure_table = select_table(source('raw', 'exposure'), 
                                        ref('exposure_rename_test_input')) 
%}
select
    eid as exposure_id,
    cid as claim_id,
    et as exposure_type,
    tp as total_payments,
    id as ingestion_date
from
    {{ exposure_table }}
