(1/6/2026)

-- Create Table
CREATE TABLE Books (
    BOOK_ID INT PRIMARY KEY,
    BOOK_CODE VARCHAR(50)
);

-- Insert Data
INSERT INTO Books (BOOK_ID, BOOK_CODE) VALUES
(1, 'NOVEL-HARRY'),
(2, 'STORY-MOANA'),
(3, 'POEM-RIVER');


SELECT * FROM Books;

-- Approach_1
SELECT SPLIT_PART(BOOK_CODE, '-', 2) AS book_tiles
FROM Books;



DROP TABLE EMPLOYEE
-- Create Department Table
CREATE TABLE Department (
    DEPT_ID INT PRIMARY KEY,
    DEPT_NAME VARCHAR(50)
);

-- Create Employee Table
CREATE TABLE Employee (
    EMP_ID INT PRIMARY KEY,
    SALARY INT,
    DEPT_ID INT,
    FOREIGN KEY (DEPT_ID) REFERENCES Department(DEPT_ID)
);

-- Insert Data into Department
INSERT INTO Department VALUES
(101, 'HR'),
(102, 'FINANCE'),
(103, 'MARKETING');

-- Insert Data into Employee
INSERT INTO Employee VALUES
(1, 70000, 101),
(2, 50000, 101),
(3, 60000, 101),
(4, 65000, 102),
(5, 65000, 102),
(6, 55000, 102),
(7, 60000, 103),
(8, 70000, 103),
(9, 80000, 103);

SELECT * FROM Department;
SELECT * FROM Employee;

SELECT d.dept_name, e.emp_id, e.salary
FROM Employee e
JOIN Department d ON e.dept_id = d.dept_id
WHERE e.salary = (
    SELECT MAX(salary)
    FROM Employee
    WHERE dept_id = e.dept_id
);

SELECT * FROM DEPARTMENT AS D1	
LEFT JOIN EMPLOYEE AS E1
ON D1.DEPT_ID = E1.DEPT_ID
AND E1.SALARY = (
    SELECT MAX(E3.SALAR)
    SELECT MAX(E2.SALARY) FROM EMPLOYEE AS E2
	WHERE E2.DEPT_ID = E1.DEPT_ID
)


(2/6/2026)

-- Ques 2

CREATE TABLE test_data (
    col1 INT,
    col2 VARCHAR(50)
);

INSERT INTO test_data (col1, col2) VALUES
(1, 'A,B,C'),
(2, 'A,B');

-- Approach 1

SELECT col1,
       col2,
       LENGTH(col2) - LENGTH(REPLACE(col2, ',', '')) + 1 AS num_chars
FROM test_data;


-- Ques3

CREATE TABLE UnitsSold (
    Product_id INT,
    Purchase_date DATE,
    Units INT
);

-- Insert Data
INSERT INTO UnitsSold VALUES
(1, '2019-02-25', 100),
(1, '2019-03-01', 15),
(2, '2019-02-10', 200),
(2, '2019-03-22', 30);

CREATE TABLE prices (
    product_id INT,
    start_date DATE,
    end_date DATE,
    price INT,
    PRIMARY KEY (product_id, start_date, end_date)
);

INSERT INTO prices (product_id, start_date, end_date, price) VALUES
(1, '2019-02-17', '2019-02-28', 5),
(1, '2019-03-01', '2019-03-22', 20),
(2, '2019-02-01', '2019-02-20', 15),
(2, '2019-02-21', '2019-03-31', 30);

SELECT * FROM prices;


-- Approach 1
SELECT u.product_id, ROUND(SUM(u.units * p.price):: numeric / SUM (u.units), 2) AS Avergae_price FROM UnitsSold AS u
LEFT JOIN Prices AS p
ON u.Product_id = p.product_id
WHERE u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY u.product_id
ORDER BY product_id ASC;

