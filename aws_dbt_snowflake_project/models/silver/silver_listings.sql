{{config(materialized = 'incremental',
uniuqe_key = 'LISTING_ID')}}

{#
This unique_key will help to do UPSERT operation 
in which we add only the new data, but if suppose 
we update anything in the previous data, then the 
previous data is updated
#}

SELECT LISTING_ID,
HOST_ID,
ROOM_TYPE,
PROPERTY_TYPE,
CITY,
COUNTRY,
ACCOMMODATES,
BEDROOMS,
BATHROOMS,
PRICE_PER_NIGHT,
{{tag('CAST(PRICE_PER_NIGHT AS INT)')}} AS PRICE_PER_NIGHT_TAG,
CREATED_AT
FROM {{ref('bronze_listing')}}
