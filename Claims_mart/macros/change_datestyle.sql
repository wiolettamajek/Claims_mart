{% macro change_datestyle() -%}

ALTER DATABASE postgres SET datestyle TO "DMY";

{%- endmacro %}