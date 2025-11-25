USE course_registration;

# Part C
# Question 1

-- Find students from the 2023 intake who are in Software Engineering
SELECT student_id, student_fname, student_lname, program
FROM students
WHERE intake_year = 2023
  AND program = 'Software Engineering';

-- Students who are in either Data Engineering OR Bioinformatics
SELECT student_id, student_fname, student_lname, program
FROM students
WHERE program = 'Data Engineering'
   OR program = 'Bioinformatics';

-- Courses that are NOT taught by the Applied Computing department
SELECT course_code, course_title, lecturer_id
FROM courses
WHERE lecturer_id NOT IN (
    SELECT lecturer_id
    FROM lecturers
    WHERE department = 'Applied Computing'
);

-- Students with intake year between 2023 and 2024
SELECT student_id, student_fname, student_lname, intake_year
FROM students
WHERE intake_year BETWEEN 2023 AND 2024;

-- Students whose first name starts with 'A'
SELECT student_id, student_fname, student_lname
FROM students
WHERE student_fname LIKE 'A%';

-- Courses that do NOT have prerequisites
SELECT course_id, course_code, course_title
FROM courses
WHERE prerequisite_id IS NULL;

# Question 2

-- List all courses sorted by credit hours (ascending)
SELECT course_code, course_title, credit_hours
FROM courses
ORDER BY credit_hours ASC;

-- Most recent registrations first
SELECT reg_id, student_id, course_id, reg_date
FROM registrations
ORDER BY reg_date DESC;

-- Top 5 newest students
SELECT student_id, student_fname, student_lname, intake_year
FROM students
ORDER BY intake_year DESC
LIMIT 5;

# Question 3

-- Total number of students in each program
SELECT program, COUNT(*) AS total_students
FROM students
GROUP BY program;

-- Total credit hours a student registered in a semester
SELECT student_id, semester, SUM(credit_hours) AS total_credits
FROM registrations r
JOIN courses c ON r.course_id = c.course_id
GROUP BY student_id, semester;

-- Average course capacity across all courses
SELECT AVG(capacity) AS avg_capacity
FROM courses;

-- Course with the highest capacity
SELECT course_code, course_title, capacity
FROM courses
ORDER BY capacity DESC
LIMIT 1;

-- Course with the smallest number of credit hours
SELECT course_code, course_title, credit_hours
FROM courses
ORDER BY credit_hours ASC
LIMIT 1;
