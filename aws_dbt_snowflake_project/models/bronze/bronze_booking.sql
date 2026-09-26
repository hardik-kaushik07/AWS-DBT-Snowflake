{# IN todays era we do not store all the date repeatedly, suppose todat we store data in the db
tomorrow we upload something in the data, so previous data should not be repeatedly store in the db
so only the new data id store in the db and it is called
"incremental load" #}


{# {%set incremental_flag = 1%}
{%set incremental_load = 'CREATED_AT'%}


SELECT * FROM {{ source('staging', 'bookings') }}

{%if incremental_flag == 1%}
WHERE {{incremental_load}} > (SELECT MAX({{incremental_load}}) FROM {{ref('bronze_booking')}})
{%endif%} #}


{# OR #}


{{config(materialized = 'incremental')}}


SELECT * FROM {{ source('staging', 'bookings') }}

{% if is_incremental() %}
    WHERE CREATED_AT > (SELECT COALESCE(MAX(CREATED_AT), '1900-01-01') FROM {{ this }})
{% endif %}