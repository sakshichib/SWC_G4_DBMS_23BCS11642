(28/05/2026)
-- Ques 1
CREATE TABLE tbl_happiness (
    sno INT,
    rankings INT,
    country VARCHAR(50)
);

-- Insert Data
INSERT INTO tbl_happiness (sno, rankings, country) VALUES
(1, 1, 'Finland'),
(2, 2, 'Denmark'),
(3, 3, 'Iceland'),-['']
(4, 4, 'Israel'),
(5, 5, 'Netherlands'),
(6, 6, 'Sweden'),
(7, 7, 'Norway'),
(8, 126, 'India'),
(9, 128, 'Sri Lanka');

solution:
Approach 1
(i)
(
SELECT RANKINGS ,COUNTRY FROM tbl_happiness
WHERE COUNTRY IN ('India','Sri Lanka')
)
UNION ALL
(
SELECT RANKINGS ,COUNTRY FROM tbl_happiness
WHERE COUNTRY NOT IN ('India','Sri Lanka')
ORDER BY RANKINGS ASC
)

-- (ii)

(
SELECT RANKINGS ,COUNTRY FROM tbl_happiness
WHERE COUNTRY IN ('India','Sri Lanka')
)
UNION ALL
(
SELECT RANKINGS ,COUNTRY FROM tbl_happiness
WHERE COUNTRY NOT IN ('India','Sri Lanka')
ORDER BY RANKINGS DESC
)	



Approach 2


(I)

SELECT RANKINGS ,COUNTRY
FROM tbl_happiness
ORDER BY CASE WHEN COUNTRY ='India' then 1
WHEN COUNTRY='Sri Lanka' then 2
ELSE 3 END 
,RANKINGS 


(II)

SELECT RANKINGS ,COUNTRY
FROM tbl_happiness
ORDER BY CASE WHEN COUNTRY ='India' then 1
WHEN COUNTRY='Sri Lanka' then 2
ELSE 3 END 
,RANKINGS DESC





Ques 2
-- Create Table
CREATE TABLE employee (
    eid INT,
    dept VARCHAR(10),
    scores DECIMAL(5,2)
);

-- Insert Data
INSERT INTO employee (eid, dept, scores) VALUES
(1, 'D1', 1),
(2, 'D1', 5.28),
(3, 'D1', 4),
(4, 'D2', 8),
(5, 'D1', 2.5),
(6, 'D2', 7),
(7, 'D3', 9),
(8, 'D4', 10.2);


--- Join

WITH CTE_EMP AS(
SELECT DEPT ,MAX(SCORES) AS MAXI_SCORE
FROM EMPLOYEE
GROUP BY DEPT
)

SELECT E1.EID,E1.DEPT,E2.MAXI_SCORE AS SCORE FROM EMPLOYEE AS E1
LEFT JOIN CTE_EMP AS E2
ON E1.DEPT=E2.DEPT

-- Approach 2
CO-RELATED Subquery+ Scaler Subquery
SELECT EID,DEPT ,
(

SELECT MAX(E2.SCORES) 
FROM EMPLOYEE AS E2
WHERE E2.DEPT=E1.DEPT
) AS SCORES

FROM EMPLOYEE AS E1
