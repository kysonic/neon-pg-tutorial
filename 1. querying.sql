-- SELECT: DISTINCT, ORDER BY, WHERE, LIMIT, FETCH, GROUP BY, HAVING, JOINS, UNION, INTERSECT, EXCEPT 

-- SELECT --

SELECT first_name FROM customer;

SELECT
   first_name,
   last_name,
   email
FROM
   customer;

SELECT * FROM customer;

SELECT
   first_name || ' ' || last_name as "fullname alias",
   email
FROM
   customer;

-- ORDER BY --

SELECT
  first_name,
  last_name
FROM
  customer
ORDER BY
  first_name ASC,
  last_name DESC;

SELECT
  first_name,
  LENGTH(first_name) len
FROM
  customer
ORDER BY
  len DESC NULLS FIRST;

-- DISTINCT -- 

SELECT DISTINCT
  rental_rate
FROM
  film
ORDER BY
  rental_rate;

-- DISTINCT ON -- 

SELECT
  DISTINCT ON (name) name,
  subject,
  score
FROM
  student_scores
ORDER BY
  name,
  score DESC;