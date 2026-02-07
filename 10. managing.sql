-- DATA TYPES -- 

-- Boolean -- 

-- 1, yes, y, t, true
-- 0, no, false, f 

SELECT 1::Boolean;

-- Character -- 

-- CHAR(n), VARCHAR(n), and TEXT

VARCHAR(256)

-- Numeric -- 

-- INT, SERIAL, SMALLINT
-- FLOAT, REAL

id SERIAL PRIMARY KEY

-- DATE -- 

-- DATE, TIME, TIMESTAMP, TIMESTAMPZ, INTERVAL

created_at TIMESTAMP NOT NULL

-- JSON -- 

data JSON/JSONB 

-- UUID -- 

id UUID 

-- SELECT INTO -- 

SELECT
    film_id,
    title,
    rental_rate
INTO TABLE film_r
FROM
    film
WHERE
    rating = 'R'
AND rental_duration = 5
ORDER BY
    title;

-- CREATE TABLE AS - The CREATE TABLE AS statement creates a new table and fills it with the data returned by a query. -- 

CREATE TABLE action_film
AS
SELECT
    film_id,
    title,
    release_year,
    length,
    rating
FROM
    film
INNER JOIN film_category USING (film_id)
WHERE
    category_id = 1;

-- SERIAL -- 

CREATE TABLE table_name(
    id SERIAL
);

-- SEQUENCE -- 

CREATE SEQUENCE mysequence
INCREMENT 5
START 100;

-- GENERATED -- 

color_id GENERATED AS IDENTITY,
 full_name VARCHAR(101) GENERATED ALWAYS AS (first_name || ' ' || last_name) STORED,

 -- ALTER TABLE -- 

 ADD COLUMN 
 DROP COLUMN 
 ALTER COLUMN
 RENAME COLUMN

 -- TRUNCATE: DELETE without WHERE (DROP removes all, TRUNCATE only data) --
 TRUNCATE TABLE table_name 

 