{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}
    {%- if custom_schema_name is none -%}

        {{ default_schema }}

    {%- else -%}

{# if we remove the default_schema then we can get name inside snowflake
like "folder name" + "file name", but if we do not remove  default_schema
then we get dbt_schema again again on dbt run. #}
        {{ default_schema }}_{{ custom_schema_name | trim }}

    {%- endif -%}

{%- endmacro %}