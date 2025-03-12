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

-- made an altercation to the treatement column
/*ALTER TABLE patientRecord
RENAME COLUMN treatment TO treatment_proposed; 
*/

-- records for the patientRecord and appointment tables
INSERT INTO patientRecord (diagnosis, treatment_proposed, patient_ID, dentist_ID) VALUES 
('Tooth Cavity', 'Fillings and Crowns', 1, 1),
('Gum Infection', 'Antibiotics', 2, 3),
('Tooth Extraction', 'Surgical removal of wisdom tooth', 3, 4),
('Dental Misalignment', 'Teeth Alignement Performed', 5, 2),
('Dental Discoloration', 'Teeth Whitening', 4, 1),
('Braces Adjustment', 'Tightened braces', 5, 2),
('Cavity', 'Dental filling only', 4, 5);

INSERT INTO appointment(appointmentDate, location, appointment_status, patient_id, dentist_id, record_id)
VALUES 
('2025-03-09 10:00:00', '123 Dental Ave, Charlotte, NC', 'Completed', 1, 1, 1),
('2025-03-09 14:00:00', '789 Tooth Rd, Charlotte, NC', 'Completed', 2, 3, 2),
('2025-03-12 09:30:00', '321 Gum Ln, Charlotte, NC', 'Completed', 3, 4, 3),
('2025-03-18 11:15:00', '456 Smile St, Charlotte, NC', 'Scheduled', 5, 2, 4),
('2025-03-19 13:00:00', '123 Dental Ave, Charlotte, NC', 'Scheduled', 4, 1, 5),
('2025-03-19 13:00:00', '456 Smile St, Charlotte, NC', 'Scheduled', 5, 2, 6),
('2025-03-21 13:00:00', '654 Cavity Blvd, Charlotte, NC', 'Cancelled', 4, 5, 7);


SELECT * FROM patientRecord;
SELECT * from appointment;
