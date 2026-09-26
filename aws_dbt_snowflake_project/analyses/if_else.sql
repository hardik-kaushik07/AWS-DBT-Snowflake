{% set flag = 1%}

    SELECT * FROM {{ref('bronze_listing')}}
    {% if  flag == 1%}
    WHERE PRICE_PER_NIGHT >100
    {%else%}
    WHERE PRICE_PER_NIGHT <=100
    {%endif%}

    {# SELECT * FROM {{ ref('bronze_listing') }} #}
