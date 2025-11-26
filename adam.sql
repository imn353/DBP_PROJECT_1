USE course_registration;

# Question 4
-- Count of lecturers for each departments which exceeds 2
SELECT department, COUNT(lecturer_id) AS total_lecturer
FROM lecturers
GROUP BY department
HAVING total_lecturer > 2;

-- Students total registration for each course
SELECT 
    course_id, 
    COUNT(student_id) AS total_registered
FROM registrations
GROUP BY course_id
HAVING total_registered > 1;

-- Courses with more than 1 prerequisites
SELECT 
    course_id, 
    COUNT(prereq_course_id) AS total_prereqs
FROM prerequisites
GROUP BY course_id
HAVING total_prereqs > 1;

# Question 5 
-- Students uppercased full name intake year
SELECT 
    student_id, 
    UPPER(CONCAT(student_fname, ' ', student_lname)) AS full_name, 
    SUBSTR(student_id, 2, 2) AS year_intake, 
    LENGTH(CONCAT(student_fname, ' ', student_lname)) AS name_count
FROM students
WHERE LENGTH(CONCAT(student_fname, ' ', student_lname)) > 12;

-- Calculate 80% of capacity for courses

SELECT course_code, capacity, 
ROUND(capacity * 0.8, 0) AS warning_level_rounded,
TRUNCATE(capacity * 0.8, 0) AS warning_level_truncated
FROM courses;

-- Average students per intake year
SELECT ROUND(AVG(capacity), 2) AS average_class_capacity
FROM courses;

# Question 6

-- Categorize course based on the capacity of class
SELECT course_title, capacity,
	CASE
		WHEN capacity <= 30 THEN 'SMALL'
        WHEN capacity >= 50 THEN 'LARGE'
        ELSE 'STANDARD'
	END AS class_size
FROM courses;

-- Classify students by seniority based on intake year
SELECT 
    student_id, 
    intake_year,
    CASE 
        WHEN intake_year = 2023 THEN 'Senior'
        WHEN intake_year = 2024 THEN 'Junior'
        WHEN intake_year = 2025 THEN 'Freshman'
        ELSE 'Unknown'
    END AS student_year_group
FROM students;

-- Courses for department of Faculty Computing
SELECT 
    lecturer_fname,
    department,
    CASE 
        WHEN department = 'Computer Science' THEN 'Faculty of Computing'
        WHEN department = 'Software Engineering' THEN 'Faculty of Computing'
        ELSE 'Other Faculty'
    END AS faculty_group
FROM lecturers;





