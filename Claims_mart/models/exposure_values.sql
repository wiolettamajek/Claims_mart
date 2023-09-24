{% 
    set exposure_value_table = select_table(ref('exposure_not_null'), 
                                        ref('exposure_values_input')) 
%}
select *
from
    {{ exposure_value_table }}
where
    exposure_type in ('Vehicle', 'Property', 'Bodily Injury')
