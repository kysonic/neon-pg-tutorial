-- WHERE, AND, OR, LIMIT, FETCH, IN, BETWEEN, LIKE, IS NULL --

-- WHERE -- 

SELECT
  last_name,
  first_name
FROM
  customer
WHERE
  first_name = 'Jamie';

-- AND -- 

SELECT
  title,
  length,
  rental_rate
FROM
  film
WHERE
  length > 180
  AND rental_rate < 1;

-- OR -- 

SELECT
  title,
  rental_rate
FROM
  film
WHERE
  rental_rate = 0.99 OR
  rental_rate = 2.99;

-- LIMIT -- 

SELECT
  film_id,
  title,
  rental_rate
FROM
  film
ORDER BY
  rental_rate DESC
LIMIT
  10;

-- FETCH -- 

SELECT
    film_id,
    title
FROM
    film
ORDER BY
    title
FETCH FIRST 5 ROW ONLY;

SELECT
    film_id,
    title
FROM
    film
ORDER BY
    title
OFFSET 5 ROWS
FETCH FIRST 5 ROW ONLY;

-- IN --

SELECT
  film_id,
  title
FROM
  film
WHERE
  film_id in (1, 2, 3);

-- BETWEEN --

SELECT
  customer_id,
  payment_id,
  amount,
  payment_date
FROM
  payment
WHERE
  payment_date BETWEEN '2007-02-15' AND '2007-02-20'
  AND amount > 10
ORDER BY
  payment_date;

-- LIKE: NOT LIKE, %, _, ESCAPE, ILIKE -- 

SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  first_name LIKE '%er%'
ORDER BY
  first_name;

SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  first_name NOT LIKE 'Jen%'
ORDER BY
  first_name;

-- IS NULL -- 

SELECT
  address,
  address2
FROM
  address
WHERE
  address2 IS NOT NULL;