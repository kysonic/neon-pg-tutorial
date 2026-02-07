-- CASE, COALESCE, ISNULL, NULLIF, CAST -- 

-- CASE -- 

SELECT
  title,
  length,
  CASE WHEN length > 0
  AND length <= 50 THEN 'Short' WHEN length > 50
  AND length <= 120 THEN 'Medium' WHEN length > 120 THEN 'Long' END duration
FROM
  film
ORDER BY
  title;

-- COALESCE: FIRST NOT NULL -- 

SELECT COALESCE (NULL, 2 , 1); -- 2

-- ISNULL -- 
ISNULL(expression, replacement)

-- NULLIF -- 
SELECT NULLIF (1, 1); -- NULL