CREATE TABLE IF NOT EXISTS demographicsLog
(log_id int AUTO_INCREMENT PRIMARY KEY,
patient_id int,
first_name varchar(50),
last_name varchar(50),
DOB date,
gender varchar(10),
address varchar(100),
phone varchar(15),
email varchar(100),
change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (patient_id) REFERENCES demographics(patient_id));
DELIMITER $$

CREATE TRIGGER demographicsInsert
BEFORE INSERT
ON demographics
FOR EACH ROW
BEGIN
	INSERT INTO demographicsLog (patient_id, first_name, last_name, DOB, gender, address, phone, email) 
    VALUES (patient_id, first_name, last_name, DOB, gender, address, phone, email);
END;$$

CREATE TRIGGER demographicsLogUpdate
BEFORE UPDATE
ON demographics
FOR EACH ROW
BEGIN
	INSERT INTO demographicsLog (patient_id, first_name, last_name, DOB, gender, address, phone, email) 
    VALUES (OLD.patient_id, OLD.first_name, OLD.last_name, OLD.DOB, OLD.gender, OLD.address, OLD.phone, OLD.email);
END;$$