-- Ques 1

CREATE TABLE Department_Tbl (
    Id INT PRIMARY KEY,
    Name VARCHAR(50)
);

CREATE TABLE Employee_Tbl (
    Id INT PRIMARY KEY,
    Name VARCHAR(50),
    Salary INT,
    DepartmentId INT,
    FOREIGN KEY (DepartmentId) REFERENCES Department_Tbl(Id)
);

INSERT INTO Department_Tbl VALUES
(1, 'IT'),
(2, 'Sales');

INSERT INTO Employee_Tbl VALUES
(1, 'Joe', 85000, 1),
(2, 'Henry', 80000, 2),
(3, 'Sam', 60000, 2),
(4, 'Max', 90000, 1),
(5, 'Janet', 69000, 1),
(6, 'Randy', 85000, 1),
(7, 'Will', 70000, 1);


SELECT * FROM Department_Tbl;

SELECT * FROM Employee_Tbl;

WITH CTE AS(
SELECT d.name AS department, e.name AS Employee, e.salary AS salary, ROW_NUMBER() OVER(PARTITION BY d.name ORDER BY salary DESC) AS rnk FROM Employee_Tbl as e
JOIN Department_Tbl as d
ON d.id = e.departmentId
)

-- SELECT * FROM CTE;

SELECT department, employee, salary FROM CTE
WHERE rnk BETWEEN 2 AND 4;


-- Question - 3

-- Create Orders table
CREATE TABLE Orders (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    amount DECIMAL(10,2),
    order_date TIMESTAMP
);

-- Insert data
INSERT INTO Orders (id, name, amount, order_date) VALUES
(1, 'SHALABH', 2200, '2025-04-24 00:26:46.190'),
(2, 'SHALABH', 2400, '2025-04-24 00:27:04.760'),
(3, 'SHALABH', 400,  '2025-04-24 00:27:38.850'),
(4, 'AJAY',    200,  '2025-04-24 00:28:28.863'),
(5, 'AJAY',    300,  '2025-04-24 00:28:28.873'),
(6, 'AJAY',    400,  '2025-04-24 00:29:19.200'),
(7, 'AJAY',   9900,  '2025-04-24 00:44:08.757');

SELECT * FROM Orders;


-- (i)
SELECT *, COALESCE(LAG(amount) OVER()::NUMERIC(10,0), -1) AS prev_order_amount, 
COALESCE(LEAD(amount) OVER()::NUMERIC(10,0), -1) AS next_order_amount FROM Orders;

-- (ii)

SELECT *, 
COALESCE(ABS(amount::NUMERIC(10, 0) - LAG(amount) OVER()::NUMERIC(10,0)), amount::NUMERIC(10, 0)) 
AS abs_diff FROM Orders;

-- (iii)

WITH CTE1 AS(
SELECT *, LAG(amount, 1,0) OVER(order by order_date)::NUMERIC(10,0) AS prev_order_amount, 
LEAD(amount, 1,0) OVER(order by order_date)::NUMERIC(10,0) AS next_order_amount FROM Orders
)

-- Approach 1
SELECT id, name, amount, order_date, ((prev_order_amount + amount + next_order_amount)/(3.0))::NUMERIC(10, 2) AS average
FROM CTE1;

-- Approach 2
SELECT id, name, amount, order_date, AVG(amount) OVER(ORDER BY order_date ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS average
FROM Orders;

-- (iv)

WITH CTE AS(
SELECT name, FIRST_VALUE(amount) OVER(Partition BY name ORDER BY order_date ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as first_value, 
LAST_VALUE(amount) OVER(PARTITION BY name ORDER BY order_date ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_value
FROM Orders
)

SELECT DISTINCT name, first_value::NUMERIC(10,0), ROUND(last_value) FROM CTE
ORDER BY name;

-- (v)

WITH CTE2 AS (
SELECT *, LAG(amount) OVER(PARTITION BY name Order by order_date) AS prev_amount
FROM ORDERS
)

SELECT name FROM CTE2
GROUP BY name
HAVING COUNT(*) > 1
   AND SUM(
        CASE
            WHEN prev_amount IS NOT NULL
                 AND amount <= prev_amount
            THEN 1
            ELSE 0
        END
   ) = 0;
