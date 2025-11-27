DROP DATABASE IF EXISTS course_registration;

-- Database creation with the name course_registration
CREATE DATABASE course_registration;  

USE course_registration;


-- Students table creation
CREATE TABLE students (
    student_id VARCHAR(20) PRIMARY KEY,
    student_fname VARCHAR(20) NOT NULL,
    student_lname VARCHAR(20) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    program ENUM('Data Engineering', 'Bioinformatics', 'Software Engineering', 'Networks and Security', 'Graphics and Multimedia') NOT NULL,
    intake_year INT NOT NULL CHECK (intake_year BETWEEN 2000 AND 2050),
    status VARCHAR(20) DEFAULT 'ACTIVE'
);

-- Lecturers table creation
CREATE TABLE lecturers (
    lecturer_id VARCHAR(20) PRIMARY KEY,
    lecturer_fname VARCHAR(20) NOT NULL,
    lecturer_lname VARCHAR(20) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    department ENUM('Applied Computing', 'Computer Science', 'Emergent Computing', 'Software Engineering')
);

-- Course table creation
CREATE TABLE courses (
    course_id VARCHAR(8) PRIMARY KEY,
    course_code VARCHAR(20) UNIQUE NOT NULL,
    course_title VARCHAR(150) NOT NULL,
    credit_hours INT NOT NULL,
    capacity INT NOT NULL DEFAULT 40,
    lecturer_id VARCHAR(20),
    prerequisite_id VARCHAR(8) DEFAULT NULL,
    course_desc TEXT,
    FOREIGN KEY (lecturer_id) REFERENCES lecturers(lecturer_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- Registration table creation
CREATE TABLE registrations (
    reg_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id VARCHAR(20) NOT NULL,
    course_id VARCHAR(8) NOT NULL,
    reg_date DATE,
    semester VARCHAR(10) NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
        ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
        ON DELETE CASCADE,
    UNIQUE (student_id, course_id, semester)
);

-- Prerequisite table creation
CREATE TABLE prerequisites (
    course_id VARCHAR(8) NOT NULL,
    prereq_course_id VARCHAR(8) NOT NULL,
    PRIMARY KEY (course_id, prereq_course_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
        ON DELETE CASCADE,
    FOREIGN KEY (prereq_course_id) REFERENCES courses(course_id)
        ON DELETE CASCADE
);

-- Alter table modifying course_desc column
ALTER TABLE courses
MODIFY COLUMN course_desc TEXT NOT NULL;

-- Drop prerequisites table
DROP TABLE IF EXISTS prerequisites;

-- Populate student table
INSERT INTO students (student_id, student_fname, student_lname, email, program, intake_year) VALUES
('A23CS0001', 'Iman', 'Nizwan', 'iman.nizwan@cs.edu', 'Data Engineering', 2023),
('A23CS0002', 'Afiq', 'Danial', 'afiq.danial@cs.edu', 'Software Engineering', 2023),
('A23CS0003', 'Alif', 'Fathi', 'alif.fathi@cs.edu', 'Networks and Security', 2023),
('A23CS0004', 'Irfan', 'Shaqir', 'irfan.shaqir@cs.edu', 'Graphics and Multimedia', 2023),
('A23CS0005', 'Hazim', 'Roslan', 'hazim.roslan@cs.edu', 'Bioinformatics', 2023),
('A23CS0006', 'Sarah', 'Aqilah', 'sarah.aqilah@cs.edu', 'Software Engineering', 2023),
('A23CS0007', 'Daniel', 'Hakim', 'daniel.hakim@cs.edu', 'Data Engineering', 2023),
('A23CS0008', 'Alya', 'Suhana', 'alya.suhana@cs.edu', 'Networks and Security', 2023),
('A24CS0009', 'Mika', 'Hafiz', 'mika.hafiz@cs.edu', 'Bioinformatics', 2024),
('A24CS0010', 'Syafiq', 'Amir', 'syafiq.amir@cs.edu', 'Graphics and Multimedia', 2024),
('A24CS0011', 'Hannah', 'Zulaikha', 'hannah.zulaikha@cs.edu', 'Software Engineering', 2024),
('A24CS0012', 'Faris', 'Azlan', 'faris.azlan@cs.edu', 'Data Engineering', 2024),
('A24CS0013', 'Nadia', 'Sofea', 'nadia.sofea@cs.edu', 'Networks and Security', 2024),
('A24CS0014', 'Zharif', 'Imran', 'zharif.imran@cs.edu', 'Graphics and Multimedia', 2024),
('A24CS0015', 'Amani', 'Najwa', 'amani.najwa@cs.edu', 'Bioinformatics', 2024),
('A25CS0016', 'Rayan', 'Hakimi', 'rayan.hakimi@cs.edu', 'Software Engineering', 2025),
('A25CS0017', 'Sofea', 'Nurin', 'sofea.nurin@cs.edu', 'Data Engineering', 2025),
('A25CS0018', 'Izz', 'Haikal', 'izz.haikal@cs.edu', 'Networks and Security', 2025),
('A25CS0019', 'Maisarah', 'Ismail', 'maisarah.ismail@cs.edu', 'Graphics and Multimedia', 2025),
('A25CS0020', 'Ridzuan', 'Haziq', 'ridzuan.haziq@cs.edu', 'Bioinformatics', 2025);

-- Populate lecturers table 
INSERT INTO lecturers (lecturer_id, lecturer_fname, lecturer_lname, email, department) VALUES
('L23AC001', 'Farid', 'Hamzah', 'farid.hamzah@university.edu', 'Applied Computing'),
('L23AC002', 'Alicia', 'Tan', 'alicia.tan@university.edu', 'Applied Computing'),
('L23CS001', 'Rahman', 'Yusof', 'rahman.yusof@university.edu', 'Computer Science'),
('L23CS002', 'Nadia', 'Amin', 'nadia.amin@university.edu', 'Computer Science'),
('L23EC001', 'Suhana', 'Ariffin', 'suhana.ariffin@university.edu', 'Emergent Computing'),
('L23SE001', 'Daniel', 'Lim', 'daniel.lim@university.edu', 'Software Engineering'),
('L24AC001', 'Harith', 'Samsul', 'harith.samsul@university.edu', 'Applied Computing'),
('L24CS001', 'Melissa', 'Teh', 'melissa.teh@university.edu', 'Computer Science'),
('L24CS002', 'Arif', 'Kamal', 'arif.kamal@university.edu', 'Computer Science'),
('L24EC001', 'Jasmin', 'Ong', 'jasmin.ong@university.edu', 'Emergent Computing');


-- Populate courses table
INSERT INTO courses (
    course_id, course_code, course_title, credit_hours,
    capacity, lecturer_id, prerequisite_id, course_desc
) VALUES
('C0000001', 'CS1013', 'Introduction to Computer Science', 3, 40, 'L23CS001', NULL,
 'Fundamental concepts of computing, algorithms, and programming.'),
('C0000002', 'CS1023', 'Programming Fundamentals', 3, 30, 'L23CS002', 'C0000001',
 'Basic programming principles using Python, focusing on problem solving.'),
('C0000003', 'CS2013', 'Object-Oriented Programming', 3, 40, 'L24CS001', 'C0000002',
 'OOP concepts including classes, inheritance, polymorphism, and interfaces.'),
('C0000004', 'CS2023', 'Data Structures and Algorithms', 3, 30, 'L24CS002', 'C0000003',
 'Analysis and implementation of key data structures and algorithmic patterns.'),
('C0000005', 'AC1013', 'Discrete Mathematics', 3, 40, 'L23AC001', NULL,
 'Mathematical foundations including logic, sets, proofs, and combinatorics.'),
('C0000006', 'AC2023', 'Computational Mathematics', 3, 30, 'L23AC002', 'C0000005',
 'Applied mathematics for algorithm design, modeling, and problem solving.'),
('C0000007', 'EC3013', 'Machine Learning Fundamentals', 3, 40, 'L23EC001', 'C0000004',
 'Core ML algorithms including classification, regression, and clustering.'),
('C0000008', 'SE1013', 'Introduction to Software Engineering', 3, 20, 'L23SE001', NULL,
 'Principles of software engineering including SDLC, requirements, and design.'),
('C0000009', 'SE2023', 'Software Design and Architecture', 3, 50, 'L24AC001', 'C0000008',
 'Software architecture patterns, UML modeling, and design principles.'),
('C0000010', 'CS1033', 'Database Systems', 3, 40, 'L24EC001', 'C0000001',
 'Database design, SQL, normalization, and relational database concepts.');
 
-- Populate registrations table
INSERT INTO registrations (student_id, course_id, reg_date, semester) VALUES
('A23CS0001', 'C0000001', '2023-09-10', '23/24-1'),
('A23CS0001', 'C0000005', '2023-09-12', '23/24-1'),
('A23CS0001', 'C0000002', '2024-02-15', '23/24-2'), 
('A23CS0001', 'C0000003', '2025-02-17', '24/25-1'),  
('A23CS0002', 'C0000001', '2023-01-11', '23/24-1'),
('A23CS0002', 'C0000008', '2024-08-16', '23/24-2'), 
('A23CS0003', 'C0000001', '2023-09-12', '23/24-1'),
('A23CS0003', 'C0000002', '2024-03-15', '23/24-2'),
('A23CS0003', 'C0000004', '2024-07-17', '24/25-2'), 
('A23CS0004', 'C0000001', '2023-09-10', '23/24-1'),
('A23CS0004', 'C0000010', '2024-02-18', '23/24-2'), 
('A23CS0005', 'C0000005', '2023-10-10', '23/24-1'),  
('A23CS0005', 'C0000006', '2024-02-15', '24/25-1'),  
('A24CS0009', 'C0000001', '2024-07-11', '24/25-1'),
('A24CS0009', 'C0000002', '2025-01-15', '24/25-2'),
('A24CS0010', 'C0000008', '2025-01-10', '24/25-1'),
('A24CS0010', 'C0000009', '2025-07-16', '24/25-2'),  
('A25CS0016', 'C0000001', '2025-09-10', '25/26-1'),
('A25CS0019', 'C0000005', '2025-09-10', '25/26-1');

-- Update lecturers table where the lecturer_id is L24CS002
UPDATE lecturers
SET department = 'Emergent Computing'
WHERE lecturer_id = 'L24CS002';

-- Delete students from students table where student_id is A25CS0020
DELETE FROM students
WHERE student_id = 'A25CS0020';












