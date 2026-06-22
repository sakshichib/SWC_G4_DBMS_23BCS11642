
-- QUES 1

-- Create the table
CREATE TABLE UserVisits (
    user_id INT,
    visit_date DATE
);

-- Insert the sample records
INSERT INTO UserVisits (user_id, visit_date) VALUES
(1, '2020-11-28'),
(1, '2020-10-20'),
(1, '2020-12-03'),
(2, '2020-10-05'),
(2, '2020-12-09'),
(3, '2020-11-11');

SELECT * FROM UserVisits;

WITH CTE AS (
SELECT user_id, visit_date, COALESCE(LEAD(visit_date) 
OVER(PARTITION BY user_id ORDER BY visit_date), DATE '2021-01-01') AS next_visit FROM UserVisits
)
-- SELECT * FROM CTE;

SELECT
    user_id,
    MAX(next_visit - visit_date) AS biggest_window
FROM CTE
GROUP BY user_id
ORDER BY user_id;



-- QUES 2

--- Create the table
CREATE TABLE UserActivity (
    username VARCHAR(50),
    activity VARCHAR(50),
    startDate DATE,
    endDate DATE
);

-- Insert the sample data
INSERT INTO UserActivity (username, activity, startDate, endDate) VALUES
('Alice', 'Travel', '2020-02-12', '2020-02-20'),
('Alice', 'Dancing', '2020-02-21', '2020-02-23'),
('Alice', 'Travel', '2020-02-24', '2020-02-28'),
('Bob', 'Travel', '2020-02-11', '2020-02-18');

SELECT * FROM UserActivity;

WITH CTE AS (
SELECT *, DENSE_RANK() 
OVER(PARTITION BY username ORDER BY startdate DESC) AS rnk 
FROM UserActivity
)

SELECT username, activity, startdate, enddate
FROM CTE
WHERE rnk = 2

UNION ALL


SELECT username, activity, startDate, endDate
FROM cte c1
WHERE rnk = 1
  AND NOT EXISTS (
      SELECT 1
      FROM cte c2
      WHERE c2.username = c1.username
        AND c2.rnk = 2
  );