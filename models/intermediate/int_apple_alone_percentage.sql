-- Identifier les scrapes où Apple est seul
WITH apple_alone AS (
    SELECT _scraping_key
    FROM {{ ref('int_paid_search_scraps') }}
    GROUP BY _scraping_key
    HAVING
        COUNT(DISTINCT domain_name) = 1  -- Un seul domaine dans ce scraping_key
        AND LOWER(MAX(domain_name)) LIKE '%apple.com%' -- Vérifie que ce domaine est Apple
)

SELECT
    paid_search_scrap.date_day,
    COUNT(DISTINCT apple_alone._scraping_key)
    / MAX(paid_search_scrap.scrape_count)
        AS apple_alone_percentage
FROM {{ ref('int_paid_search_scraps') }} AS paid_search_scrap
LEFT JOIN apple_alone
    ON paid_search_scrap._scraping_key = apple_alone._scraping_key
GROUP BY 
    paid_search_scrap.date_day