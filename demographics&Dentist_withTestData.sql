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


-- Insert 5 test records into the demographics table
INSERT INTO demographics (first_name, last_name, DOB, gender, address, phone, email)
VALUES
    ('John', 'Doe', '1990-05-15', 'Male', '123 Main St, Charlotte, NC', '704-555-1234', 'john.doe@example.com'),
    ('Jane', 'Smith', '1985-08-22', 'Female', '456 Elm St, Charlotte, NC', '704-555-5678', 'jane.smith@example.com'),
    ('Alice', 'Johnson', '1978-03-10', 'Female', '789 Oak St, Charlotte, NC', '704-555-9101', 'alice.johnson@example.com'),
    ('Bob', 'Brown', '1995-11-30', 'Male', '321 Pine St, Charlotte, NC', '704-555-1122', 'bob.brown@example.com'),
    ('Charlie', 'Davis', '1982-07-19', 'Male', '654 Maple St, Charlotte, NC', '704-555-3344', 'charlie.davis@example.com');
    
    
    -- Insert 5 test records into the dentist table
INSERT INTO dentist (first_name, last_name, addressOfPractice, specialty, phone, email)
VALUES
    ('Michael', 'Green', '123 Dental Ave, Charlotte, NC', 'General Dentist', '704-555-4455', 'michael.green@example.com'),
    ('Sarah', 'White', '456 Smile St, Charlotte, NC', 'Orthodontist', '704-555-6677', 'sarah.white@example.com'),
    ('David', 'Black', '789 Tooth Rd, Charlotte, NC', 'Endodontist', '704-555-8899', 'david.black@example.com'),
    ('Emily', 'Taylor', '321 Gum Ln, Charlotte, NC', 'Pediatric Dentist', '704-555-9900', 'emily.taylor@example.com'),
    ('James', 'Clark', '654 Cavity Blvd, Charlotte, NC', 'Oral Surgeon', '704-555-1010', 'james.clark@example.com');
  
  
SHOW TABLES; 
SELECT * FROM demographics;
SELECT * FROM dentist;    

