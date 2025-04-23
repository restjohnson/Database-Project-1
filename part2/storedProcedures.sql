-- create patient
DELIMITER $$

CREATE PROCEDURE CreatePatient(
    IN p_first_name VARCHAR(50),
    IN p_last_name VARCHAR(50),
    IN p_DOB DATE,
    IN p_gender VARCHAR(10),
    IN p_address VARCHAR(100),
    IN p_phone VARCHAR(15),
    IN p_email VARCHAR(100),
    IN p_insurance_number VARCHAR(100)
)
BEGIN
    INSERT INTO demographics (first_name, last_name, DOB, gender, address, phone, email, insurance_number)
    VALUES (p_first_name, p_last_name, p_DOB, p_gender, p_address, p_phone, p_email, p_insurance_number);
END$$

DELIMITER ;


-- create patient record
DELIMITER $$
CREATE PROCEDURE CreatePatientRecord(
    IN p_patientID INT,
    IN p_dentistID INT,
    IN p_diagnosis VARCHAR(255),
    IN p_treatment VARCHAR(255)
)
BEGIN
    INSERT INTO patientRecord (patient_id, dentist_id, diagnosis, treatment)
    VALUES (p_patientID, p_dentistID, p_diagnosis, p_treatment);
END$$

-- update a patient record
DELIMITER $$

CREATE PROCEDURE UpdatePatientRecord(
    IN p_recordID INT,
    IN p_diagnosis VARCHAR(255),
    IN p_treatment VARCHAR(255)
)
BEGIN
    UPDATE patientRecord
    SET diagnosis = p_diagnosis,
        treatment = p_treatment
    WHERE record_id = p_recordID;
END$$

DELIMITER ;

-- delete patient records
DELIMITER $$

CREATE PROCEDURE DeletePatientRecord(
    IN p_recordID INT
)
BEGIN
    DELETE FROM patientRecord
    WHERE record_id = p_recordID;
END$$

DELIMITER ;

-- view a patient's record
DELIMITER $$

CREATE PROCEDURE ViewPatientRecord(
    IN p_patientID INT
)
BEGIN
    SELECT * FROM patientRecord
    WHERE patient_id = p_patientID;
END$$

DELIMITER ;

-- create an appointment
DELIMITER $$
CREATE PROCEDURE CreateAppointment(
    IN p_appointmentDate DATETIME,
    IN p_location VARCHAR(255),
    IN p_patient_id INT,
    IN p_dentist_id INT,
    IN p_record_id INT
)
BEGIN
    INSERT INTO appointment (appointmentDate, location, appointment_status, patient_id, dentist_id, record_id
    )
    VALUES (p_appointmentDate, p_location, 'Scheduled', p_patient_id, p_dentist_id, p_record_id);
END$$

DELIMITER ;


-- update an appointment details
DELIMITER $$

CREATE PROCEDURE UpdateAppointmentStatus(
    IN p_appointment_id INT,
    IN p_new_status ENUM('Scheduled', 'Completed', 'Cancelled'),
    IN p_new_datetime DATETIME,
    IN p_new_location VARCHAR(255)
)
BEGIN
    UPDATE appointment
    SET 
        appointment_status = p_new_status,
        appointmentDate = IFNULL(p_new_datetime, appointmentDate),
        location = IFNULL(p_new_location, location)
    WHERE appointment_id = p_appointment_id;
END$$

DELIMITER ;

-- billing information is being contreolled by the trigger we previously created

-- add an inventory item
DELIMITER $$

CREATE PROCEDURE AddInventoryItem(
    IN p_itemName VARCHAR(255),
    IN p_quantity INT
)
BEGIN
    INSERT INTO inventory (itemName, quantityAvailable)
    VALUES (p_itemName, p_quantity);
END$$

DELIMITER ;

 