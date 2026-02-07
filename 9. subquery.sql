-- SUBQUERY -- 

SELECT
  city
FROM
  city
WHERE
  country_id = (
    SELECT
      country_id
    FROM
      country
    WHERE
      country = 'United States'
  )
ORDER BY
  city;

SELECT
  film_id,
  title
FROM
  film
WHERE
  film_id IN (
    SELECT
      film_id
    FROM
      film_category
      INNER JOIN category USING(category_id)
    WHERE
      name = 'Action'
  )
ORDER BY
  film_id;

-- CORRELATED SUBQUERY -- 

SELECT film_id, title, length, rating
FROM film f
WHERE length > (
    SELECT AVG(length)
    FROM film
    WHERE rating = f.rating
);

-- ANY -- 

-- SCHEMA -- 

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL
);
CREATE TABLE managers(
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL
);
INSERT INTO employees (first_name, last_name, salary)
VALUES
('Bob', 'Williams', 45000.00),
('Charlie', 'Davis', 55000.00),
('David', 'Jones', 50000.00),
('Emma', 'Brown', 48000.00),
('Frank', 'Miller', 52000.00),
('Grace', 'Wilson', 49000.00),
('Harry', 'Taylor', 53000.00),
('Ivy', 'Moore', 47000.00),
('Jack', 'Anderson', 56000.00),
('Kate', 'Hill',  44000.00),
('Liam', 'Clark', 59000.00),
('Mia', 'Parker', 42000.00);
INSERT INTO managers(first_name, last_name, salary)
VALUES
('John', 'Doe',  60000.00),
('Jane', 'Smith', 55000.00),
('Alice', 'Johnson',  58000.00);

--

SELECT
  *
FROM
  employees
WHERE
  salary = ANY (
    SELECT
      salary
    FROM
      managers
  );

-- ALL -- 

SELECT
  *
FROM
  employees
WHERE
  salary < ALL(
    select
      salary
    from
      managers
  )
ORDER BY salary DESC;

-- EXISTS: If the subquery returns at least one row, the EXISTS operator returns true. --

SELECT
  first_name,
  last_name
FROM
  customer c
WHERE
  EXISTS (
    SELECT
      1
    FROM
      payment p
    WHERE
      p.customer_id = c.customer_id
      AND amount > 11
  )
ORDER BY
  first_name,
  last_name;

-- NOT EXISTS -- 

SELECT
  first_name,
  last_name
FROM
  customer c
WHERE
  NOT EXISTS (
    SELECT
      1
    FROM
      payment p
    WHERE
      p.customer_id = c.customer_id
      AND amount > 11
  )
ORDER BY
  first_name,
  last_name;

