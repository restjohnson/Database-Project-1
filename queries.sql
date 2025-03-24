-- Simple Queries
-- Retrive the patients names & their corresponding appointments
SELECT 
    CONCAT(d.first_name, ' ', d.last_name) AS Patient_Name,
    COUNT(a.appointment_id) AS Total_Appointments
FROM demographics d
LEFT JOIN appointment a ON d.patient_id = a.patient_id
GROUP BY d.patient_id;

-- the average of patients
SELECT 
    AVG(YEAR(CURDATE()) - YEAR(DOB)) AS Average_Age
FROM demographics;

-- total appointments per dentists
SELECT 
    CONCAT(d.first_name, ' ', d.last_name) AS Dentist_Name,
    COUNT(a.appointment_id) AS Total_Appointments
FROM dentist d
LEFT JOIN appointment a ON d.dentist_id = a.dentist_id
GROUP BY d.dentist_id;

-- appointment details with patients name
SELECT 
    a.appointment_id,
    a.appointmentDate,
    CONCAT(d.first_name, ' ', d.last_name) AS Patient_Name
FROM appointment a
JOIN demographics d ON a.patient_id = d.patient_id;

-- appointment details with patient email
SELECT 
    a.appointment_id,
    a.appointmentDate,
    d.email AS Patient_Email
FROM appointment a
JOIN demographics d ON a.patient_id = d.patient_id;

-- patients without any appointments 
SELECT 
    d.patient_id,
    CONCAT(d.first_name, ' ', d.last_name) AS Patient_Name
FROM demographics d
LEFT JOIN appointment a ON d.patient_id = a.patient_id
WHERE a.appointment_id IS NULL;

-- scheduled appointments
SELECT 
    CONCAT(d.first_name, ' ', d.last_name) AS Patient_Name,
    a.appointmentDate,
    a.location,
    a.appointment_status
FROM appointment a
JOIN demographics d ON a.patient_id = d.patient_id
WHERE a.appointment_status = 'Scheduled'
ORDER BY a.appointmentDate;

-- dentists and their corresponding appointments
SELECT 
    CONCAT(d.first_name, ' ', d.last_name) AS Dentist_Name,
    COUNT(a.appointment_id) AS Total_Appointments
FROM dentist d
LEFT JOIN appointment a ON d.dentist_id = a.dentist_id
GROUP BY d.dentist_id;

-- popular appointment locations
SELECT 
    a.location,
    COUNT(*) AS Appointment_Count
FROM appointment a
GROUP BY a.location
ORDER BY Appointment_Count DESC;

-- appointment frequency
SELECT 
    CONCAT(d.first_name, ' ', d.last_name) AS Patient_Name,
    COUNT(a.appointment_id) AS Total_Appointments
FROM demographics d
LEFT JOIN appointment a ON d.patient_id = a.patient_id
GROUP BY d.patient_id;

-- More COmplex Queries
-- billing amount per appointment based on dentists
SELECT 
    CONCAT(d.first_name, ' ', d.last_name) AS Dentist_Name,
    AVG(b.amount) AS Average_Billing_Amount
FROM billingInfo b
JOIN appointment a ON b.appointment_ID = a.appointment_id
JOIN dentist d ON a.dentist_id = d.dentist_id
GROUP BY d.dentist_id
ORDER BY Average_Billing_Amount DESC;

-- patient's billing summary 
SELECT 
    CONCAT(p.first_name, ' ', p.last_name) AS Patient_Name,
    COUNT(DISTINCT b.appointment_ID) AS Total_Appointments_Billed,
    SUM(b.amount) AS Total_Billed_Amount,
    AVG(b.amount) AS Average_Bill_Amount,
    MAX(b.amount) AS Max_Bill_Amount
FROM billingInfo b
JOIN demographics p ON b.patient_id = p.patient_id
GROUP BY p.patient_id
ORDER BY Total_Billed_Amount DESC;

-- monthly appointment information
SELECT 
    MONTH(appointmentDate) AS Month,
    COUNT(*) AS Total_Appointments,
    ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM appointment WHERE YEAR(appointmentDate) = YEAR(CURDATE())), 2) AS Percentage_of_Year
FROM appointment
WHERE YEAR(appointmentDate) = YEAR(CURDATE())
GROUP BY MONTH(appointmentDate)
ORDER BY Month;

-- upcoming appointments
SELECT 
    CONCAT(d.first_name, ' ', d.last_name) AS Patient_Name,
    a.appointmentDate,
    a.location
FROM appointment a
JOIN demographics d ON a.patient_id = d.patient_id
WHERE a.appointment_status = 'Completed'
  AND a.appointmentDate >= CURDATE()
ORDER BY a.appointmentDate ASC;

-- patients with unpaid bills
SELECT 
    CONCAT(p.first_name, ' ', p.last_name) AS Patient_Name,
    SUM(b.amount) AS Total_Unpaid
FROM billingInfo b
JOIN demographics p ON b.patient_id = p.patient_id
WHERE b.paymentStatus = 'unpaid'
GROUP BY p.patient_id
ORDER BY Total_Unpaid DESC;

-- total revenue generated by each dentist
SELECT 
    CONCAT(d.first_name, ' ', d.last_name) AS Dentist_Name,
    SUM(b.amount) AS Total_Revenue
FROM billingInfo b
JOIN appointment a ON b.appointment_ID = a.appointment_id
JOIN dentist d ON a.dentist_id = d.dentist_id
GROUP BY d.dentist_id
ORDER BY Total_Revenue DESC;


