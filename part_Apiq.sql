USE course_registration;

-- Part C Data Retrieval (DQL / SELECT)

-- Question 7 : Subqueries
-- Single Row : Find students who intake in very recent year
SELECT student_id, student_fname, student_lname, email, program, intake_year
FROM students
WHERE intake_year = (
	SELECT MAX(intake_year)
    FROM students
);

-- Multiple Row : Find course who teach by a lecturer from Applied Computing department
SELECT lecturer_id,	course_id, course_code, course_title
FROM courses
WHERE lecturer_id IN (
	SELECT lecturer_id
    FROM lecturers
    WHERE department = 'Applied Computing'
);

-- Correlated : Find students who register more than 2 courses
SELECT r1.student_id, r1.course_id, r1.semester
FROM registrations r1
WHERE (
	SELECT COUNT(*)
    FROM registrations
    WHERE r1.student_id = student_id
) > 2;

-- Question 8 : Set Operations
-- UNION : List all courses that are 3 credit hours or have a capacity more than 40
SELECT course_id, course_title, credit_hours
FROM courses
WHERE credit_hours = 3
UNION
SELECT course_id, course_title, credit_hours
FROM courses
WHERE capacity > 40;

-- NOT EXIST : Find student who doesnt enroll in course of Introduction to Computer Science - C0000001
SELECT s.student_id, CONCAT(s.student_fname,' ', s.student_lname) AS student_fullname
FROM students s
WHERE NOT EXISTS (
    SELECT 1
    FROM registrations r
    WHERE r.student_id = s.student_id
      AND r.course_id = 'C0000001'
);

-- Question 9 : Joins
-- NATURAL : All list registration with students name
SELECT student_id, CONCAT(student_fname,' ', student_lname) AS fullname,
		course_id, semester
FROM registrations
NATURAL JOIN students;

-- INNER : List all courses with assigned lecturer
SELECT 	c.course_code, c.course_title,
		UPPER(CONCAT(l.lecturer_fname,' ', l.lecturer_lname)) AS lecturer_fullname,
        l.lecturer_id
FROM courses c
INNER JOIN lecturers l
ON c.lecturer_id = l.lecturer_id;

-- LEFT OUTER : List all courses and the students registered (if any)
SELECT c.course_id, c.course_title, s.student_id, 
		LOWER(CONCAT(s.student_fname,' ', s.student_lname)) AS fullname_student
FROM courses c
LEFT OUTER JOIN registrations r
ON c.course_id = r.course_id
LEFT OUTER JOIN students s
ON r.student_id = s.student_id;

-- SELF : List of students in the same program
SELECT 	s1.student_id AS student1_id, CONCAT(s1.student_fname,' ', s1.student_lname) AS student1_fullname,
		s2.student_id AS student2_id, CONCAT(s2.student_fname,' ', s2.student_lname) AS student2_fullname,
        s1.program
FROM students s1
INNER JOIN students s2
ON s1.program = s2.program
AND s1.student_id < s2.student_id;