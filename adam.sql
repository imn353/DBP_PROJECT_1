# Part C Q4-Q6
# Q4 - Show number of lecturers for each departments which exceeds 2

SELECT department, COUNT(lecturer_id) AS total_lecturer
FROM lecturers
GROUP BY department
HAVING total_lecturer > 2;

# Q5 - Show students uppercased full name and extract the intake year from student id

SELECT 
    student_id, 
    UPPER(CONCAT(student_fname, ' ', student_lname)) AS full_name, 
    SUBSTR(student_id, 2, 2) AS year_intake, 
    LENGTH(CONCAT(student_fname, ' ', student_lname)) AS name_count
FROM students
WHERE LENGTH(CONCAT(student_fname, ' ', student_lname)) > 12;

# Q5 - Calculate average students per intake

SELECT ROUND(AVG(capacity), 2) AS average_class_capacity
FROM courses;

# Q6 - Categorize course based on the capacity of class

SELECT course_title, capacity,
	CASE
		WHEN capacity <= 30 THEN 'SMALL'
        WHEN capacity >= 50 THEN 'LARGE'
        ELSE 'STANDARD'
	END AS class_size
FROM courses;





