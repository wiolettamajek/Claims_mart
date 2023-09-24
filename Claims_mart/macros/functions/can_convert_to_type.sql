{% macro can_convert_to_type(target_type) %}

CREATE OR REPLACE FUNCTION {{target.schema}}.can_convert_to_{{target_type}}(v_input text)
RETURNS BOOLEAN AS $$
DECLARE v_int_value {{target_type}} DEFAULT NULL;
BEGIN
    BEGIN
        v_int_value = v_input::{{target_type}};
    EXCEPTION WHEN OTHERS THEN
        RETURN FALSE;
    END;
RETURN TRUE;
END;
$$ LANGUAGE plpgsql;

{% endmacro %}