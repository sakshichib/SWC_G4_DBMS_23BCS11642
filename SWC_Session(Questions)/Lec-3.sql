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

