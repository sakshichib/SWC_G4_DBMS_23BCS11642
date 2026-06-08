
WITH first_purchase AS (
    SELECT
        user_id,
        MIN(created_at) AS first_purchase_date
    FROM amazon_transactions
    GROUP BY user_id
)

SELECT DISTINCT
    t.user_id
FROM amazon_transactions t
JOIN first_purchase fp
    ON t.user_id = fp.user_id
WHERE t.created_at > fp.first_purchase_date
  AND DATE(t.created_at) - DATE(fp.first_purchase_date) BETWEEN 1 AND 7
ORDER BY t.user_id;
