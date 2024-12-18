SELECT
    *,
    CURRENT_TIMESTAMP() AS __dbt_load_timestamp
FROM {{ ref('int_apple_alone_percentage') }}
