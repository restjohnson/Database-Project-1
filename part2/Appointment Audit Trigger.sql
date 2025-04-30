CREATE TABLE IF NOT EXISTS appointmentLog
(log_id int AUTO_INCREMENT PRIMARY KEY,
appointmentDate datetime,
location varchar(255),
appointmentStatus enum('Scheduled', 'Completed', 'Cancelled'),
patient_id int,
dentist_id int,
record_id int,
change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (patient_id) REFERENCES demographics(patient_id),
FOREIGN KEY (dentist_id) REFERENCES dentist(dentist_id),
FOREIGN KEY (record_id) REFERENCES patientRecord(record_ID));
DELIMITER $$

CREATE TRIGGER logAppointment
BEFORE INSERT
ON appointment
FOR EACH ROW
BEGIN
	INSERT INTO appointmentLog (appointmentDate, location, appointmentStatus, patient_id, dentist_id, record_id) 
    VALUES (appointmentDate, location, appointmentStatus, patient_id, dentist_id, record_id);
END;$$

CREATE TRIGGER logAppointmentUpdate
BEFORE UPDATE
ON appointment
FOR EACH ROW
BEGIN
	INSERT INTO appointmentLog (appointmentDate, location, appointmentStatus, patient_id, dentist_id, record_id) 
    VALUES (OLD.appointmentDate, OLD.location, OLD.appointment_status, OLD.patient_id, OLD.dentist_id, OLD.record_id);
END;$$