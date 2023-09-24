{% macro create_functions() %}

create schema if not exists {{target.schema}};

{{can_convert_to_type('BIGINT')}};
{{can_convert_to_type('MONEY')}};
{{can_convert_to_type('TIMESTAMP')}};
{{can_convert_to_type('DATE')}};
{{can_convert_to_type('TIME')}};
{{can_convert_to_type('INT')}};

{% endmacro %}