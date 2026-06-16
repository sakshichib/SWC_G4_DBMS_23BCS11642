-- Ques 1
CREATE TABLE Employe (
    Emp_Id INT PRIMARY KEY,
    Emp_Name VARCHAR(50),
    Emp_Salary INT
);

INSERT INTO Employe (Emp_Id, Emp_Name, Emp_Salary) VALUES
(1, 'Alice', 4000),
(2, 'Bob', 6000),
(3, 'Charlie', 2000),
(4, 'David', 8000),
(5, 'Akash', 8000),
(6, 'Ajay', 6000);

SELECT * FROM Employe;

WITH CTE AS(
SELECT *, DENSE_RANK() OVER(ORDER BY emp_salary) AS rnk 
FROM Employe 
)

SELECT *
FROM CTE 
WHERE rnk = 3
LIMIT 1;

DROP TABLE Employe;



-- Ques 2

CREATE TABLE reviews (
    review_id INT,
    user_id INT,
    submit_date DATE,
    restaurant_id INT,
    rating INT
);

-- INSERT DATA

INSERT INTO reviews VALUES
(1001, 501, '2022-01-15', 101, 4),
(1002, 502, '2022-01-20', 101, 5),
(1003, 503, '2022-01-25', 102, 3),
(1004, 504, '2022-01-15', 102, 4),
(1005, 505, '2022-02-20', 101, 5),
(1006, 506, '2022-02-26', 101, 4),
(1007, 507, '2022-03-01', 101, 4),
(1008, 508, '2022-03-05', 102, 2);


SELECT * FROM reviews;


-- Approach 1
WITH CTE AS (
SELECT EXTRACT(MONTH FROM submit_date) AS month, restaurant_id, AVG(rating) as avg_rating
FROM reviews
GROUP BY month, restaurant_id
)

SELECT restaurant_id, month, ROUND(avg_rating, 2) FROM CTE
ORDER BY restaurant_id, month;


-- Approach 2
-- How to change decomal in window function
WITH CTE AS (
SELECT EXTRACT(MONTH FROM submit_date) AS month, restaurant_id, 
AVG(rating) OVER(PARTITION BY restaurant_id, EXTRACT(MONTH FROM submit_date) ORDER BY restaurant_id, EXTRACT(MONTH FROM submit_date)) as avg_rating,
ROW_NUMBER() OVER(PARTITION BY restaurant_id, EXTRACT(MONTH FROM submit_date) ORDER BY restaurant_id, EXTRACT(MONTH FROM submit_date)) as r
FROM reviews
)

SELECT restaurant_id, month, ROUND(avg_rating, 2) FROM CTE WHERE r=1;


-- Ques 3

DROP TABLE Employee;

CREATE TABLE employee (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT,
    dept_name VARCHAR(30),
    joining_date DATE
);

INSERT INTO employee (id, name, salary, dept_name, joining_date) VALUES
(1, 'AKASH', 25000, 'IT', '2021-05-14'),
(2, 'VIKAS', 5000, 'SALES', '2022-08-01'),
(3, 'ANAY', 5000, 'IT', '2020-11-23'),
(4, 'ADITYA', 51000, 'SALES', '2023-03-10'),
(5, 'RAVI', 6000, 'IT', '2021-09-17'),
(6, 'ANUJ', 7000, 'SALES', '2020-07-05'),
(7, 'DEEP', 21000, 'IT', '2022-02-25'),
(8, 'NISHA', 52000, 'SALES', '2023-12-19'),
(9, 'KARAN', 18000, 'HR', '2022-06-08'),
(10, 'SNEHA', 35000, 'IT', '2023-01-12'),
(11, 'MOHIT', 27000, 'MARKETING', '2021-03-19'),
(12, 'RIYA', 40000, 'HR', '2020-10-28'),
(13, 'AMAN', 15000, 'MARKETING', '2022-11-05');


SELECT * FROM Employee;


WITH dept AS(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY dept_name ORDER BY joining_date DESC) AS rnk
FROM Employee
)

SELECT * FROM dept
WHERE rnk <= 2;
