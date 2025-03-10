CREATE TABLE demographics (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,  -- Primary key for patient
    first_name VARCHAR(50) NOT NULL,            -- Patient's first name
    last_name VARCHAR(50) NOT NULL,             -- Patient's last name
    DOB DATE NOT NULL,                          -- Date of Birth
    gender VARCHAR(10) NOT NULL,                -- Gender
    address VARCHAR(100) NOT NULL,              -- Address
    phone VARCHAR(15) NOT NULL,                 -- Phone number
    email VARCHAR(100)                          -- Email
);

CREATE TABLE dentist (
    dentist_id INT AUTO_INCREMENT PRIMARY KEY,  -- Primary key for dentist
    first_name VARCHAR(50) NOT NULL,            -- Dentist's first name
    last_name VARCHAR(50) NOT NULL,             -- Dentist's last name
    addressOfPractice VARCHAR(100) NOT NULL,    -- Address of practice
    specialty VARCHAR(50) NOT NULL,             -- Specialty 
    phone VARCHAR(15) NOT NULL,                 -- Phone number
    email VARCHAR(100)                          -- Email 
);