CREATE TABLE IF NOT EXISTS billingLog
(log_id int AUTO_INCREMENT PRIMARY KEY,
amount int,
paymentStatus enum('paid', 'unpaid'),
patient_id int,
appointment_id int,
change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (patient_id) REFERENCES demographics(patient_id),
FOREIGN KEY (appointment_id) REFERENCES appointment(appointment_id));
DELIMITER $$

CREATE TRIGGER logBillInsert
BEFORE INSERT
ON billingInfo
FOR EACH ROW
BEGIN
	INSERT INTO billingLog (amount, paymentStatus, patient_id, appointment_id) 
    VALUES (amount, paymentStatus, patient_id, appointment_id);
END;$$

CREATE TRIGGER logBillUpdate
BEFORE UPDATE
ON billingInfo
FOR EACH ROW
BEGIN
	INSERT INTO billingLog (amount, newAmount, paymentStatus, newStatus, patient_id, appointment_id) 
    VALUES (OLD.amount, NEW.amount, OLD.paymentStatus, NEW.paymentStatus, OLD.patient_id, appointment_id);
END;$$