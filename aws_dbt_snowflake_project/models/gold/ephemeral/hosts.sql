{{config(
    materialized = 'ephemeral'
)}}

select host_id, host_name, host_since, response_rate_quality, host_created_at
from {{ref('obt')}}