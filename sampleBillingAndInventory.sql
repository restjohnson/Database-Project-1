USE EMR_DB;

DELIMITER // 
CREATE TRIGGER generate_billing_info 
AFTER INSERT ON appointment 
FOR EACH ROW 
BEGIN 
	DECLARE treatment_type VARCHAR(255); 
	DECLARE treatment_cost DECIMAL(10,2); 
	-- Get the treatment from patientRecord 
	SELECT treatment_proposed INTO treatment_type FROM patientRecord WHERE record_id = NEW.record_id LIMIT 1; 
	-- Get the cost from treatmentCost table 
	SELECT cost INTO treatment_cost FROM treatmentCost WHERE treatment = treatment_type LIMIT 1;
	-- If no cost found, default to 100.00 
	IF treatment_cost IS NULL THEN SET treatment_cost = 100.00; 
	END IF; 
	-- Insert the billing record  
	INSERT INTO billingInfo (first_name, last_name, appointment_id, patient_id, amount, paymentStatus) VALUES 
	((SELECT first_name FROM demographics WHERE demographics.patient_id = NEW.patient_id LIMIT 1),
	(SELECT last_name FROM demographics WHERE demographics.patient_id = NEW.patient_id LIMIT 1),
	NEW.appointment_id, NEW.patient_id, treatment_cost, 'unpaid');  
END; 
// DELIMITER ;

INSERT INTO inventory (itemName, quantityAvailable) VALUES
('Toothbrushes', 26),
('Floss', 400),
('Scrapers', 15),
('X-ray cameras', 5),
('Toothpaste', 10),
('Pliers', 20)
;

INSERT INTO treatmentCost VALUES('Fillings and Crowns', 200.00),
('Antibiotics', 50.00),
('Surgical removal of wisdom tooth', 500.00),
('Teeth Alignment', 300.00),
('Teeth Whitening', 150.00),
('Braces Adjustment', 100.00),
('Dental filling only', 180.00);