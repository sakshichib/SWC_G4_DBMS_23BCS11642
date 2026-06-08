SELECT EXTRACT(month FROM curr_month.event_date) AS month,
COUNT(DISTINCT curr_month.user_id) AS monthly_active_users
FROM user_actions AS curr_month
WHERE EXISTS(
  SELECT 1 FROM user_actions AS prev_month
  WHERE prev_month.user_id = curr_month.user_id
  AND EXTRACT(MONTH FROM prev_month.event_date) = EXTRACT(MONTH FROM curr_month.event_date - interval '1 month')
)
AND EXTRACT(MONTH FROM curr_month.event_date) = 7
AND EXTRACT(YEAR FROM curr_month.event_date) = 2022
GROUP BY 1;
