WITH latest_date AS (
    SELECT MAX(event_timestamp)::date AS max_date
    FROM search_events
),

user_segments AS (
    SELECT
        a.user_id,
        CASE
            WHEN a.registration_date >= (
                SELECT max_date - INTERVAL '30 days'
                FROM latest_date
            )
            THEN 'new'
            ELSE 'existing'
        END AS user_segment
    FROM accounts a
),

searches AS (
    SELECT
        event_id,
        user_id,
        event_timestamp AS search_time
    FROM search_events
    WHERE event_type = 'search'
),

search_clicks AS (
    SELECT
        s.event_id,
        s.user_id,
        s.search_time,
        MIN(c.event_timestamp) AS first_click_time
    FROM searches s
    LEFT JOIN search_events c
        ON c.user_id = s.user_id
       AND c.event_type = 'click'
       AND c.event_timestamp > s.search_time
    GROUP BY
        s.event_id,
        s.user_id,
        s.search_time
)

SELECT
    us.user_segment,
    COUNT(*) AS total_searches,
    SUM(
        CASE
            WHEN first_click_time IS NOT NULL
             AND first_click_time <= search_time + INTERVAL '30 seconds'
            THEN 1
            ELSE 0
        END
    ) AS successful_searches,
    ROUND(
        SUM(
            CASE
                WHEN first_click_time IS NOT NULL
                 AND first_click_time <= search_time + INTERVAL '30 seconds'
                THEN 1
                ELSE 0
            END
        )::numeric
        / COUNT(*),
        2
    ) AS success_rate
FROM search_clicks sc
JOIN user_segments us
    ON sc.user_id = us.user_id
GROUP BY us.user_segment
ORDER BY us.user_segment;
