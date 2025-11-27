USE course_registration;

SET profiling = 1;

-- Before index
SELECT * 
FROM registrations
WHERE reg_date BETWEEN '2023-01-01' AND '2023-12-31';

SHOW PROFILES;

CREATE INDEX idx_reg_date
ON registrations (reg_date);

-- After index
SELECT * 
FROM registrations
WHERE reg_date BETWEEN '2023-01-01' AND '2023-12-31';

SHOW PROFILES;
