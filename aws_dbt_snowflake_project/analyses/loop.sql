{% set col = ['BEDROOMS','BATHROOMS','ACCOMMODATES']%}

SELECT 
{% for cols in col%}
{{cols}}
{% if not loop.last%}, {%endif%}
{%endfor%}
FROM {{ref('bronze_listing')}}
