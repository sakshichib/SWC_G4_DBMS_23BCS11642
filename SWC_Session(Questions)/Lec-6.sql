-- -- Create Movies table
-- CREATE TABLE Movies (
--     movie_id INT PRIMARY KEY,
--     title VARCHAR(100)
-- );

-- -- Insert data into Movies
-- INSERT INTO Movies (movie_id, title) VALUES
-- (1, 'Avengers'),
-- (2, 'Frozen 2'),
-- (3, 'Joker');


-- -- Create Users table
-- CREATE TABLE Users (
--     user_id INT PRIMARY KEY,
--     name VARCHAR(100)
-- );

-- -- Insert data into Users
-- INSERT INTO Users (user_id, name) VALUES
-- (1, 'Daniel'),
-- (2, 'Monica'),
-- (3, 'Maria'),
-- (4, 'James');

-- -- Create MovieRating table
-- CREATE TABLE MovieRating (
--     movie_id INT,
--     user_id INT,
--     rating INT,
--     created_at DATE,
--     PRIMARY KEY (movie_id, user_id),
--     FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
--     FOREIGN KEY (user_id) REFERENCES Users(user_id)
-- );

-- -- Insert data into MovieRating
-- INSERT INTO MovieRating (movie_id, user_id, rating, created_at) VALUES
-- (1, 1, 3, '2020-01-12'),
-- (1, 2, 4, '2020-02-11'),
-- (1, 3, 2, '2020-02-12'),
-- (1, 4, 1, '2020-01-01'),
-- (2, 1, 5, '2020-02-17'),
-- (2, 2, 2, '2020-02-01'),
-- (2, 3, 2, '2020-03-01'),
-- (3, 1, 3, '2020-02-22'),
-- (3, 2, 4, '2020-02-25');

-- SELECT * FROM Movies;
-- SELECT * FROM Users;
-- SELECT * FROM MovieRating;


-- -- Query 1

-- SELECT name, COUNT(rati) FROM Users AS u
-- LEFT JOIN MovieRating AS m
-- ON u.user_id = m.userid
-- WHERE ;


(9/6/26)

-- Ques 1

-----------------------------
CREATE TABLE student(
    id INT,
    name VARCHAR(20),
    age INT
);

INSERT INTO student VALUES
(1,'Alice',20),
(2,'Bob',22),
(3,'Charlie',21),
(4,'Diana',23);

CREATE TABLE groups(
    group_id INT,
    group_name VARCHAR(20)
);

INSERT INTO groups VALUES
(1,'Group1'),
(2,'Group2'),
(3,'Group3');

CREATE TABLE group_rating(
    group_id INT,
    group_rating DECIMAL(2,1)
);

INSERT INTO group_rating VALUES
(1,3.5),
(2,4.0),
(3,5.0);


-- WITH Rating AS (
-- 	SELECT g.group_id, g.group_name, gr.group_rating
-- 	FROM groups AS g
-- 	JOIN group_rating AS gr
-- 	ON g.group_id = gr.group_id
-- 	WHERE gr.group_rating >= 4.0
-- )

-- SELECT * FROM Rating;

WITH Rating AS (
    SELECT g.group_id, g.group_name, gr.group_rating
    FROM groups AS g
    JOIN group_rating AS gr
    ON g.group_id = gr.group_id
    WHERE gr.group_rating >= 4.0
)
-- SELECT * FROM Rating;


SELECT s.id, s.name, r.group_name
FROM student AS s
CROSS JOIN Rating AS r;



-- Ques 2
CREATE TABLE saless (
    id INT,
    month VARCHAR(10),
    ytd_sales INT
);

INSERT INTO saless VALUES
(1,'Jan',15),
(2,'Feb',22),
(3,'Mar',35),
(4,'Apr',45),
(5,'May',60);

SELECT * FROM saless;

SELECT month, ytd_sales, ytd_sales - COALESCE(LAG(ytd_sales, 1) OVER(ORDER BY id), 0) AS Periodic_Sales
FROM saless;



