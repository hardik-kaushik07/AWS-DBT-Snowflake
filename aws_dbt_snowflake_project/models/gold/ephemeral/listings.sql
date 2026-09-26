{{config(
    materialized = 'ephemeral'
)}}

select  listing_id, property_type, room_type, city, country, price_per_night,price_per_night_tag, listing_created_at 
from {{ref('obt')}}