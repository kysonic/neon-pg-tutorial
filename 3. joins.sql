-- JOINS: INNER, LEFT, RIGHT, SELF, FULL, CROSS, NATURAL --

-- INNER -- 

SELECT
  c.customer_id,
  c.first_name,
  c.last_name,
  p.amount,
  p.payment_date
FROM
  customer c
  INNER JOIN payment p ON p.customer_id = c.customer_id
ORDER BY
  p.payment_date;

-- LEFT -- 

SELECT
  film.film_id,
  film.title,
  inventory.inventory_id
FROM
  film
  LEFT JOIN inventory ON inventory.film_id = film.film_id
ORDER BY
  film.title;

SELECT
  f.film_id,
  f.title,
  i.inventory_id
FROM
  film f
  LEFT JOIN inventory i USING (film_id) -- same film_id in both tables
ORDER BY
  i.inventory_id;

SELECT
  f.film_id,
  f.title,
  i.inventory_id
FROM
  film f
  LEFT JOIN inventory i USING (film_id)
WHERE
  i.film_id IS NULL
ORDER BY
  f.title;

--- RIGHT --- 

SELECT
  f.film_id,
  f.title,
  i.inventory_id
FROM
  inventory i
RIGHT JOIN film f USING(film_id)
WHERE i.inventory_id IS NULL
ORDER BY
  f.title;

--- SELF ---

-- Find film pairs with the same length -- 

SELECT
  f1.title,
  f2.title,
  f1.length
FROM
  film f1
  INNER JOIN film f2 ON f1.film_id > f2.film_id
  AND f1.length = f2.length;

-- FULL OUTER JOIN: LEFT + RIGHT --

SELECT
  employee_name,
  department_name
FROM
  employees e
FULL OUTER JOIN departments d
  ON d.department_id = e.department_id
WHERE
  employee_name IS NULL;

-- CROSS JOIN --

-- In practice, you can find the CROSS JOIN useful when you need to combine data from two tables 
-- without specific matching conditions. --

SELECT *
FROM employees
CROSS JOIN shift;

-- NATURAL: any INNER, LEFT, RIGHT but it automatically join by same names --

SELECT *
FROM categories
NATURAL LEFT JOIN products;