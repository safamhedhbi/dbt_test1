WITH apple_absent_scraps AS (
    -- Sélectionner les scrapes où Apple est absent et où il y a des concurrents
    SELECT
        date_day,
        _scraping_key,
        scrape_count
    FROM {{ ref('int_paid_search_scraps') }}  -- Utilisation de la table mise à jour
    WHERE apple_present = 0  -- Apple n'est pas présent dans ce scrape

)

SELECT
    -- Calcul du pourcentage de scrapes où Apple est absent
    date_day,
    (COUNT(DISTINCT apple_absent_scraps._scraping_key) * 100.0) / MAX(scrape_count)
        AS apple_not_present_percentage
FROM apple_absent_scraps
GROUP BY date_day
