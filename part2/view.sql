-- Patient_Details_View
CREATE VIEW Patient_Details_View AS
SELECT
    d.patient_id,
    CONCAT(d.first_name, ' ', d.last_name) AS Patient_Name,
    d.DOB AS Date_of_Birth,
    d.gender AS Gender,
    d.address AS Address,
    d.phone AS Phone_Number,
    d.email AS Email,
    d.insurance_number AS Insurance_ID
FROM
    demographics d;

-- Visit_Details_View
CREATE VIEW Appointment_Details_View AS
SELECT
    a.appointment_id AS Visit_ID,
    a.patient_id,
    CONCAT(d.first_name, ' ', d.last_name) AS Patient_Name,
    a.dentist_id AS Provider_ID,
    CONCAT(dentist.first_name, ' ', dentist.last_name) AS Provider_Name,
    a.appointmentDate AS Visit_Date,
    a.appointmentDate AS Appointment_Time,
    a.appointment_status AS Appointment_Type,
    pr.diagnosis AS Reason_for_Visit,
    pr.treatment AS Notes,
    a.location AS ExamRoom_ID
FROM
    appointment a
JOIN
    demographics d ON a.patient_id = d.patient_id
JOIN
    dentist ON a.dentist_id = dentist.dentist_id
LEFT JOIN
    patientRecord pr ON a.record_id = pr.record_ID;

-- Billing_Details_View
CREATE VIEW Billing_Details_View AS
SELECT
    b.bill_ID AS Billing_ID,
    b.patient_id,
    CONCAT(d.first_name, ' ', d.last_name) AS Patient_Name,
    b.appointment_ID AS Visit_ID,
    NULL AS Billing_Date,
    b.amount AS Total_Cost,
    b.paymentStatus
FROM
    billingInfo b
JOIN
    demographics d ON b.patient_id = d.patient_id;

-- Provider_Schedule_View
CREATE VIEW Provider_Schedule_View AS
SELECT
    a.dentist_id AS Provider_ID,
    CONCAT(dentist.first_name, ' ', dentist.last_name) AS Provider_Name,
    a.appointmentDate AS Visit_Date,
    a.appointmentDate AS Appointment_Time,
    a.appointment_status AS Appointment_Type,
    pr.diagnosis AS Reason_for_Visit,
    a.patient_id,
    CONCAT(d.first_name, ' ', d.last_name) AS Patient_Name
FROM
    appointment a
JOIN
    demographics d ON a.patient_id = d.patient_id
JOIN
    dentist ON a.dentist_id = dentist.dentist_id
LEFT JOIN
    patientRecord pr ON a.record_id = pr.record_ID;

-- Patient_Billing_View
CREATE VIEW Patient_Billing_View AS
SELECT
    d.patient_id,
    CONCAT(d.first_name, ' ', d.last_name) AS Patient_Name,
    b.bill_ID AS Billing_ID,
    NULL AS Billing_Date,
    b.amount AS Total_Cost,
    b.paymentStatus
FROM
    demographics d
JOIN
    billingInfo b ON d.patient_id = b.patient_id;

-- Appointment_Calendar_View
CREATE VIEW Appointment_Calendar_View AS
SELECT
    a.appointment_id,
    a.patient_id,
    CONCAT(d.first_name, ' ', d.last_name) AS Patient_Name,
    a.appointmentDate AS Appointment_Date,
    a.appointmentDate AS Appointment_Time,
    CONCAT(dentist.first_name, ' ', dentist.last_name) AS Provider_Name
FROM
    appointment a
JOIN
    demographics d ON a.patient_id = d.patient_id
JOIN
    dentist ON a.dentist_id = dentist.dentist_id;
