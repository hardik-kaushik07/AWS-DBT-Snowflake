{% set config = [
    {
        "table" : "AIRBNB.DBT_SCHEMA_SILVER.silver_bookings",
        "columns" : "silver_bookings.*",
        "alias" : "silver_bookings"
    },

    {
        "table" : "AIRBNB.DBT_SCHEMA_SILVER.silver_listings",
        "columns" : "SILVER_listings.HOST_ID, SILVER_listings.PROPERTY_TYPE, SILVER_listings.ROOM_TYPE, SILVER_listings.CITY, SILVER_listings.COUNTRY, SILVER_listings.ACCOMMODATES, SILVER_listings.BEDROOMS, SILVER_listings.BATHROOMS, SILVER_listings.PRICE_PER_NIGHT, silver_listings.PRICE_PER_NIGHT_TAG, SILVER_listings.CREATED_AT AS LISTING_CREATED_AT",
        "alias" : "SILVER_listings",
        "join_condition" : "silver_bookings.listing_id = SILVER_listings.listing_id"
    },

    {
        "table" : "AIRBNB.DBT_SCHEMA_SILVER.silver_hosts",
        "columns" : "SILVER_hosts.HOST_NAME, SILVER_hosts.HOST_SINCE, SILVER_hosts.IS_SUPERHOST, SILVER_hosts.RESPONSE_RATE, SILVER_hosts.RESPONSE_RATE_QUALITY, SILVER_hosts.CREATED_AT AS HOST_CREATED_AT",
        "alias" : "SILVER_hosts",
        "join_condition" : "SILVER_listings.host_id = SILVER_hosts.host_id"
    }
]
%}

SELECT 
    {% for configs in config %}
    {{ configs['columns'] }}{% if not loop.last %},{% endif %}
    {% endfor %}

FROM
    {% for configs in config %}
    {% if loop.first %}
    {{ configs['table'] }} AS {{ configs['alias'] }}
    {% else %}
    LEFT JOIN {{ configs['table'] }} AS {{ configs['alias'] }}
        ON {{ configs['join_condition'] }}
    {% endif %}
    {% endfor %}
