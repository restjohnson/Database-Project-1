CREATE TABLE IF NOT EXISTS patientRecord(
	record_ID	INT		PRIMARY KEY		auto_increment,
    diagnosis	VARCHAR(255)	NOT NULL,
    treatment	TEXT,
    patient_ID	INT NOT NULL,
    dentist_ID	INT	NOT NULL,
FOREIGN KEY (patient_id) REFERENCES demographics(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (dentist_id) REFERENCES dentist(dentist_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS appointment (
    appointment_id INT 	PRIMARY KEY 	AUTO_INCREMENT,
    appointmentDate DATETIME NOT NULL,
    location VARCHAR(255),
    appointment_status ENUM('Scheduled', 'Completed', 'Cancelled') NOT NULL,
    patient_id INT NOT NULL,
    dentist_id INT NOT NULL,
    record_id INT, 
    FOREIGN KEY (patient_id) REFERENCES demographics(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (dentist_id) REFERENCES dentist(dentist_id) ON DELETE CASCADE,
    FOREIGN KEY (record_id) REFERENCES patientRecord(record_id) ON DELETE SET NULL
);