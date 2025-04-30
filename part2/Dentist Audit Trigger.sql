CREATE TABLE IF NOT EXISTS dentistLog
(log_id int AUTO_INCREMENT PRIMARY KEY,
dentist_id int,
first_name varchar(50),
last_name varchar(50),
address varchar(100),
specialty varchar(50),
phone varchar(15),
email varchar(100),
change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (dentist_id) REFERENCES dentist(dentist_id));
DELIMITER $$

CREATE TRIGGER dentistInsert
BEFORE INSERT
ON dentist
FOR EACH ROW
BEGIN
	INSERT INTO dentistLog (dentist_id, first_name, last_name, address, specialty, phone, email) 
    VALUES (dentist_id, first_name, last_name, address, specialty, phone, email);
END;$$

CREATE TRIGGER dentistUpdate
BEFORE UPDATE
ON dentist
FOR EACH ROW
BEGIN
	INSERT INTO dentistLog (dentist_id, first_name, last_name, address, specialty, phone, email) 
    VALUES (OLD.dentist_id, OLD.first_name, OLD.last_name, OLD.addressOfPractice, OLD.specialty, OLD.phone, OLD.email);
END;$$