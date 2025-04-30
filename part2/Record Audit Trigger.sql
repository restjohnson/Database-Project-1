CREATE TABLE IF NOT EXISTS recordLog
(log_id int AUTO_INCREMENT PRIMARY KEY,
record_id int,
new_diagnosis varchar(255),
old_diagnosis varchar(255),
old_treatment_proposed text,
new_treatment_proposed text,
patient_id int,
dentist_id int,
change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (patient_id) REFERENCES demographics(patient_id),
FOREIGN KEY (dentist_id) REFERENCES dentist(dentist_id));
DELIMITER $$

CREATE TRIGGER recordInsert
BEFORE INSERT
ON patientRecord
FOR EACH ROW
BEGIN
	INSERT INTO recordLog (record_id, new_diagnosis, new_treatment_proposed, patient_id, dentist_id) 
    VALUES (record_id, diagnosis, treatment_proposed, patient_id, dentist_id);
END;$$

CREATE TRIGGER recordUpdate
BEFORE UPDATE
ON patientRecord
FOR EACH ROW
BEGIN
	INSERT INTO recordLog (record_id, new_diagnosis, old_diagnosis, old_treatment_proposed, new_treatment_proposed, patient_id, dentist_id) 
    VALUES (record_id, NEW.diagnosis, OLD.diagnosis, OLD.treatment_proposed, NEW.treatment_proposed, patient_id, dentist_id);
END;$$