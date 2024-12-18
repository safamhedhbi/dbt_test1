-- Sélectionner tous les scrapes payants de type "search"
SELECT
    *,
    SUM(
        CASE
            WHEN LOWER(domain_name) LIKE '%apple.com%'
                THEN 1
            ELSE 0
        END
    ) OVER (PARTITION BY _scraping_key)
        AS apple_present,  -- Vérifie si Apple est présent

    COUNT(
        DISTINCT
        _scraping_key
    ) OVER (PARTITION BY 1)
        AS scrape_count  -- Nombre de domaines distincts par scraping_key
FROM {{ ref('stg_google_ads_scraping') }}
WHERE
    search_type = 'paid'
    AND ad_type = 'TXT'
