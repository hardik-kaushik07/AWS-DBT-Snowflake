{{config(materialized = 'incremental'
,
unique_key = 'BOOKING_ID')
}}

{#This unique_key will help to do UPDATE+SELECT -> UPSERT operation
in which let suppose we add something  in the bronze layer then same will
be add in the silver layer, but when we suppose update anything like change 
booikng_id name to aaa from abc, then in bronze  table there is two id which is 
same but have different  name, but in the silver layer, 
the  name is update insist of adding new name with same id.
  #}

  SELECT 
    BOOKING_ID,
    LISTING_ID,
    BOOKING_DATE,
    {{ multiply('NIGHTS_BOOKED', 'BOOKING_AMOUNT',2) }} AS TOTAL_AMOUNT,
    SERVICE_FEE, 
    CLEANING_FEE, 
    BOOKING_STATUS,
    CREATED_AT
FROM 
    {{ ref('bronze_booking') }}