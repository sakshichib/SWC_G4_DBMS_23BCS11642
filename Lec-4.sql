(4/6/2026)
-- QUES 2
CREATE TABLE employee (
    emp_id INT,
    email VARCHAR(100)
);

INSERT INTO employee (emp_id, email)
VALUES
(1, 'AMAN@GMAIL.COM'),
(2, 'SHREYA@OUTLOOK.COM'),
(3, 'PIYUSH@HOTMAIL.COM');

-- Approach 1
SELECT SPLIT_PART(email, '@', 2) AS domains_name
FROM employee;


-- QUES 3
-- Create Movies table
CREATE TABLE Movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(100)
);

-- Insert data into Movies
INSERT INTO Movies (movie_id, title) VALUES
(1, 'Avengers'),
(2, 'Frozen 2'),
(3, 'Joker');


-- Create Users table
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100)
);

-- Insert data into Users
INSERT INTO Users (user_id, name) VALUES
(1, 'Daniel'),
(2, 'Monica'),
(3, 'Maria'),
(4, 'James');

-- Create MovieRating table
CREATE TABLE MovieRating (
    movie_id INT,
    user_id INT,
    rating INT,
    created_at DATE,
    PRIMARY KEY (movie_id, user_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Insert data into MovieRating
INSERT INTO MovieRating (movie_id, user_id, rating, created_at) VALUES
(1, 1, 3, '2020-01-12'),
(1, 2, 4, '2020-02-11'),
(1, 3, 2, '2020-02-12'),
(1, 4, 1, '2020-01-01'),
(2, 1, 5, '2020-02-17'),
(2, 2, 2, '2020-02-01'),
(2, 3, 2, '2020-03-01'),
(3, 1, 3, '2020-02-22'),
(3, 2, 4, '2020-02-25');

SELECT * FROM Movies;
SELECT * FROM Users;
SELECT * FROM MovieRating;


-- Query 1

-- Note: remember the use of LIMIT(Restricts the maximum number of rows returned) and OFFSET(Skips a certain number of rows before starting to return results.)

SELECT u.user_id, u.name, COUNT(rating) AS highest_rating FROM Users AS u
LEFT JOIN MovieRating AS m
ON u.user_id = m.user_id
GROUP BY u.user_id
ORDER BY highest_rating DESC, u.name ASC
LIMIT 1;


-- Query 2
SELECT m.movie_id, m.title, ROUND(AVG(rating), 2) AS total_rating FROM Movies AS m
LEFT JOIN MovieRating as r
ON m.movie_id = r.movie_id
WHERE r.created_at BETWEEN '2020-02-01' AND '2020-02-29'
GROUP BY m.movie_id
ORDER BY total_rating DESC, m.title ASC
LIMIT 1;

-- Ques 2
CREATE TABLE seat_table (
    seat_id INT PRIMARY KEY,
    free INT
);

INSERT INTO seat_table (seat_id, free) VALUES
(1,1),
(2,0),
(3,1),
(4,0),
(5,1),
(6,1),
(7,1),
(8,0),
(9,1),
(10,1);

SELECT s1.seat_id AS seat1, s2.seat_id AS seat2
FROM seat_table AS s1
JOIN seat_table AS s2
ON s1.seat_id + 1 = s2.seat_id
WHERE s1.free = 1 AND s2.free = 1
ORDER BY s1.seat_id ASC;


