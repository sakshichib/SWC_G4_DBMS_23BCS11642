-- Ques 1

CREATE TABLE NPV (
    id INT,
    year INT,
    npv INT
);

CREATE TABLE Queries (
    id INT,
    year INT
);

-- INSERT DATA

INSERT INTO NPV VALUES
(1, 2018, 100),
(7, 2020, 30),
(13, 2019, 40),
(1, 2019, 113),
(2, 2008, 121),
(3, 2009, 12),
(11, 2020, 99),
(7, 2019, 0);

INSERT INTO Queries VALUES
(1, 2019),
(2, 2008),
(3, 2009),
(7, 2018),
(7, 2019),
(7, 2020),
(13, 2019);


SELECT * FROM NPV;
SELECT * FROM Queries;


SELECT Q.id, Q.year, COALESCE(N.npv, 0) FROM Queries AS Q
LEFT JOIN NPV AS N
ON Q.id = N.id 
AND Q.year = N.year;


-- Ques 2

-- Create Employee Table
CREATE TABLE Employees (
    Emp_Id INT PRIMARY KEY,
    Emp_Name VARCHAR(50),
    Emp_Salary INT
);

-- Insert Data
INSERT INTO Employees (Emp_Id, Emp_Name, Emp_Salary) VALUES
(1, 'Alice',   4000),
(2, 'Bob',     6000),
(3, 'Charlie', 2000),
(4, 'David',   8000),
(5, 'Akash',   8000),
(6, 'Ajay',    6000);


CREATE TABLE Employee_Salary (
    Emp_Salary INT
);

INSERT INTO Employee_Salary (Emp_Salary) VALUES
(4000),
(6000),
(2000),
(8000);



CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    marks INT
);

INSERT INTO students (student_id, name, city, marks)
VALUES
(1, 'A', 'Delhi', 85),
(2, 'B', 'Agra', 92),
(3, 'C', 'Delhi', 78),
(4, 'D', 'Agra', 88),
(5, 'E', 'Agra', 95),
(6, 'F', 'Agra', 95);

WITH CTE1 AS(
SELECT *, 
AVG(Marks) OVER(PARTITION BY CITY ORDER BY CITY ROWS BETWEEN 
UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS Avg_Marks,
ROW_NUMBER() OVER(PARTITION BY City) AS R_Num
FROM students
)

SELECT CITY, AVG_MARKS:: NUMERIC(10, 2) FROM CTE1
WHERE R_NUM = 1;
