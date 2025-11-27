USE course_registration;

-- Step 1: Test baseline performance WITHOUT any index
-- This query uses LIKE with wildcard (%...%), which forces MySQL to scan all rows.
-- Expected: Full table scan, key = NULL, high number of rows examined.
EXPLAIN SELECT * 
FROM courses
WHERE course_desc LIKE '%classification%';

SELECT * 
FROM courses
WHERE course_desc LIKE '%classification%';

-- Step 2: Create a FULLTEXT index on the course_desc column
CREATE FULLTEXT INDEX idx_course_desc ON courses(course_desc);

-- Step 3: Test performance WITH FULLTEXT index
-- This query uses MATCH...AGAINST which can utilize the FULLTEXT index.
-- Expected: key = idx_course_descp, dramatically fewer rows examined,
-- indicating that MySQL used the fulltext index instead of full table scan.
EXPLAIN SELECT *
FROM courses
WHERE MATCH(course_desc) AGAINST('classification' IN NATURAL LANGUAGE MODE);

SELECT *
FROM courses
WHERE MATCH(course_desc) AGAINST('classification' IN NATURAL LANGUAGE MODE);

-- Step 4: OPTIONAL - Remove the index after testing
DROP INDEX idx_course_desc ON courses;
