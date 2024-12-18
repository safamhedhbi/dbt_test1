-- Calcul du % d'apparition du domaine Apple en payant
SELECT
    date_day,
    ad_type,
    SUM(
        CASE
            WHEN LOWER(domain_name) LIKE '%apple.com%' AND search_type = 'paid'
                THEN 1
            ELSE 0
        END
    )

    / COUNT(*) AS appearance_percentage
FROM {{ ref('stg_google_ads_scraping') }}  -- Référence à la table staging 'stg_scrap_data'
GROUP BY
    date_day,
    ad_type
