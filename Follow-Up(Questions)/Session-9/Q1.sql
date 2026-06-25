-- SELECT * FROM reviews;

-- Questions link 
-- https://datalemur.com/questions/yoy-growth-rate

WITH CTE AS (
SELECT EXTRACT(MONTH FROM submit_date) AS mth, product_id AS product, ROUND(AVG(stars), 2) AS avg_stars
FROM reviews
GROUP BY mth, product_id
ORDER BY mth, product
)

SELECT mth, product, avg_stars FROM CTE;
