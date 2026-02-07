-- INSERT -- 

-- SCHEMA -- 

CREATE TABLE links (
  id SERIAL PRIMARY KEY,
  url VARCHAR(255) NOT NULL,
  name VARCHAR(255) NOT NULL,
  description VARCHAR (255),
  last_update DATE
);

-- 

INSERT INTO links (url, name)
VALUES('https://neon.com/postgresql','PostgreSQL Tutorial');

INSERT INTO contacts (first_name, last_name, email)
VALUES
    ('John', 'Doe', 'john.doe@example.com'),
    ('Jane', 'Smith', 'jane.smith@example.com'),
    ('Bob', 'Johnson', 'bob.johnson@example.com');

-- UPDATE -- 

UPDATE courses
SET published_date = '2020-08-01'
WHERE course_id = 3;

-- UPDATE JOIN -- 

UPDATE table1
SET table1.c1 = new_value
FROM table2
WHERE table1.c2 = table2.c2;

-- DELETE -- 

DELETE FROM todos
WHERE id = 1;

-- DELETE JOIN -- 

DELETE FROM table1
USING table2
WHERE condition
RETURNING returning_columns;

DELETE FROM member
USING denylist
WHERE member.phone = denylist.phone;

-- DELETE CASCADE -- 

CREATE TABLE child_table(
    id SERIAL PRIMARY KEY,
    parent_id INT,
    FOREIGN_KEY(parent_id)
       REFERENCES parent_table(id)
       ON DELETE CASCADE
);

DELETE FROM departments
WHERE id = 1; -- AUTO DELETED 

-- DELETE DUPLICATES -- 

DELETE FROM
    basket a
        USING basket b
WHERE
    a.id < b.id
    AND a.fruit = b.fruit;

-- UPSERT: ON CONFLICT -- 

INSERT INTO inventory (id, name, price, quantity)
VALUES (1, 'A', 16.99, 120)
ON CONFLICT(id)
DO UPDATE SET
  price = EXCLUDED.price,
  quantity = EXCLUDED.quantity;

MERGE INTO products p
USING (
    SELECT
        name,
        price,
        stock,
        status,
        CASE
            WHEN price IS NULL AND status = 'discontinued' THEN 'DELETE'
            WHEN stock = 0 THEN 'OUT_OF_STOCK'
            ELSE status
        END as action_type
    FROM product_updates
) u
ON p.name = u.name
WHEN MATCHED AND u.action_type = 'DELETE' THEN
    DELETE
WHEN MATCHED AND u.action_type = 'OUT_OF_STOCK' THEN
    UPDATE SET
        status = 'inactive',
        stock = 0,
        last_updated = CURRENT_TIMESTAMP
WHEN MATCHED THEN
    UPDATE SET
        price = COALESCE(u.price, p.price),
        stock = u.stock,
        status = u.status,
        last_updated = CURRENT_TIMESTAMP
WHEN NOT MATCHED AND u.action_type != 'DELETE' THEN
    INSERT (name, price, stock, status)
    VALUES (u.name, u.price, u.stock, u.status)
RETURNING
    merge_action() as action,
    p.*,
    u.action_type;