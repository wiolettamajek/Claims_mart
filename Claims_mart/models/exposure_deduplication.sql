{%
    set exposure_table = select_table(ref('exposure_type_casting'),
                                      ref('exposure_deduplication_input'))
%}
select
    *,
    row_number() over (
        partition by exposure_id, claim_id
        order by ingestion_date desc
    ) as row_number
from {{ exposure_table }}
