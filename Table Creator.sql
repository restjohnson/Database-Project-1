USE EMR_DB;

CREATE TABLE IF NOT EXISTS demographics (
	patientname varchar(255),
    dob varchar(255),
    gender varchar(255),
    address varchar(255),
    phone varchar(255),
    email varchar(255),
    insurance varchar(255)
);