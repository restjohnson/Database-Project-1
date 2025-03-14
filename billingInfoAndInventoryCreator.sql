USE EMR_DB;

CREATE TABLE IF NOT EXISTS billingInfo (
	bill_ID int AUTO_INCREMENT PRIMARY KEY,
    first_name varchar(255),
    last_name varchar(255),
    amount int,
    paymentStatus ENUM('paid', 'unpaid'),
    patient_id int,
    appointment_ID int,
    FOREIGN KEY (patient_id) REFERENCES demographics(patient_id),
    FOREIGN KEY (appointment_ID) REFERENCES appointment(appointment_ID)
);

CREATE TABLE IF NOT EXISTS inventory (
	item_id int AUTO_INCREMENT PRIMARY KEY,
    itemName varchar(255),
    quantityAvailable int
);

CREATE TABLE IF NOT EXISTS treatmentCost (
	treatment varchar(255),
    cost int
);