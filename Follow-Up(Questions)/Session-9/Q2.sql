-- Questions link
-- https://datalemur.com/questions/sql-avg-review-ratings

-- SELECT * FROM user_transactions;
WITH yearly_spend AS (
    SELECT
        product_id,
        EXTRACT(YEAR FROM transaction_date) AS year,
        SUM(spend) AS curr_year_spend
    FROM user_transactions
    GROUP BY product_id,
             EXTRACT(YEAR FROM transaction_date)
),
cte AS (
    SELECT
        product_id,
        year,
        curr_year_spend,
        LAG(curr_year_spend)
            OVER (
                PARTITION BY product_id
                ORDER BY year
            ) AS prev_year_spend
    FROM yearly_spend
)
SELECT
    year,
    product_id,
    curr_year_spend,
    prev_year_spend,
    ROUND(
        100.0 *
        (curr_year_spend - prev_year_spend)
        / prev_year_spend,
        2
    ) AS yoy_rate
FROM cte
ORDER BY product_id, year;
