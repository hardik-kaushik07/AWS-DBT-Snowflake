{{config(
    materialized = 'ephemeral'
)}}

SELECT booking_id, booking_date, booking_status, CREATED_AT
from {{ref('obt')}}