# Database-Project-1





# An Electronic Medical Record System



Applied Database Project 1



Rest Johnson (801379538) 


Matthew Wallace (801237297)


Nick Kanampiu (80119381)
 
Akash Anandakumaran (801430015)



3/23/2025


# Introduction

The Electronic Medical Record System (EMR) is designed to enhance the management of medical-related operations by digitizing and streamlining various administrative and clinical processes. A dental clinic provides a wide range of services aimed at maintaining oral health for patients. These services can include routine check-ups, teeth cleaning, cavity fillings, root canals, tooth extractions, treatments with braces or Invisalign, and cosmetic dentistry procedures. They might also handle emergency treatments for issues like toothaches, broken teeth, and even infections. 
Dental clinic operates with a combination of general dentists and specialized providers, such as orthodontists, and oral surgeons. Proper record-keeping is critical to track a patient’s dental history, previous treatments, prescribed medications, and upcoming schedules. Managing appointments, tracing dental supplies, maintaining accurate billing information, and ensuring compliance with medical regulations are important and essential for efficient operations. 

# Motivation
The primary motivation behind developing this EMR system is to improve operational efficiency in dental clinics. Traditional paper-based dental records are prone to data loss, mismanagement, and inefficiencies in retrieving patient information. By transitioning to a structured database system, dental clinics can enhance data accuracy, streamline administrative workflows, reduce redundancy, and ensure better patient care. Furthermore, digitization reduces paperwork, minimizes human errors, and facilitates better reporting and analytics. This system allows dentists to track patient treatments, manage recurring appointments, monitor inventory of dental supplies, and streamline billing for procedures such as cleanings, extractions, and orthodontic treatments. By automating scheduling, the system reduces appointment conflicts and enhances patient communication. Insurance handling is also improved, ensuring that billing information is accurately matched with treatments covered under specific plans. The end goal is to create a seamless, efficient, and user-friendly system that benefits both patients and dental practitioners, ultimately leading to improved patient experiences and operational effectiveness.

# Scope
The scope of this project includes designing and implementing a comprehensive database system tailored for a dental clinic setting. The database will encompass entities necessary for patient registration, appointment scheduling, provider details, and clinical record management. The system ensures seamless integration between these entities which allows the clinic to efficiently retrieve, modify, and report data. Additionally, it is designed with scalability in mind to accommodate any form of future enhancements and increased data volume, supporting the needs of both general and specialized dental services. A key aspect of this system is its ability to handle recurring dental procedures such as biannual checkups and cleanings, while also supporting treatment plans that require multiple visits such as orthodontic adjustments or implants. The system will also track dental-specific inventory items such as crowns, anesthetics, and surgical tools which ensures that supplies are well-maintained for smooth clinical operations. 

# Database Design
The EMR database is designed using relational database principles to ensure efficiency and maintainability. It consists of multiple interconnected tables representing key entities, such as Patients, Dentists, Appointments, Clinical Records, Billing, Treatment Cost, and Inventory. The database follows the Boyce-Codd Normal Form (BCNF) to eliminate redundancy and ensure data integrity. The structure allows for robust query execution, efficient record retrieval, and secure storage of sensitive medical data.


Functional Requirements:
1. Patient (Demographics): This stores personal and contact details about patients such as name, date of birth, gender, address, phone number, and email addresses. Each record is uniquely identifiable by a patient ID.

2. Provider (Dentist Information): This maintains details of dental professionals such as their names, specialties, and addresses of practices. Each record is also uniquely identifiable by a dentist ID.

3. Patient Record (Clinical Care): This tracks patient diagnoses, prescribed dental treatments, and medical history.

4. Appointment: This contains records of patient scheduling, linking patients with dentists, along with the appointment status indicating the state of an appointment (Completed, Cancelled, or Scheduled)

5. Billing Information: This maintains financial records including treatment costs and payment statuses. 


6. Treatment Cost: This stores information about the cost associated with a particular treatment and can be referenced if assigned to multiple patients. 


7. Inventory: Holds information about available dental supplies.

8. Entity Relationship
  
9. ER Diagram


# UML Diagram


The UML diagram provides a structured representation of the database schema, demonstrating the interconnections between entities. Key relationships include:
1. One-to-Many: A Patient can have multiple Appointments.
2. One-to-One: Each Appointment is associated with a specific Patient Record.
3. Many-to-One: Multiple Appointments can be scheduled with a single Dentist.
4. One-to-Many: A Dentist can manage several Patients.
5. Many-to-One: Billing entries reference Appointments and Patients.

# Proof of BCNF
To validate BCNF compliance, we ensure that for each functional dependency (X → Y), X is a superkey
1. Patient Table: Patient_ID uniquely identifies each patient, making all other attributes functionally dependent on it.
2. Dentist Table: Provider_ID serves as the primary key, ensuring BCNF adherence.
3. Patient Record Table: Record_ID uniquely determines the diagnosis, treatment, and patient details.
4. Appointment Table: Appointment_ID enforces functional dependency constraints.
5. Billing Table: Bill_ID uniquely determines payment-related attributes.
6. Inventory: Primary keys ensure all dependencies adhere to BCNF rules.


# Table Information
NOTE: For testing purposes, database scripts should be run in this order

1. Demographics: This table stores patient details. Below are the columns and other information in this table.

   i. patient_id (INT, AUTO_INCREMENT, PRIMARY KEY): The unique identifier for each patient.

   ii. first_name (VARCHAR(50), NOT NULL): The first name of the patient.

   iii. last_name (VARCHAR(50), NOT NULL): The last name of the patient.

   iv. DOB (DATE, NOT NULL): The patient's date of birth.

   v. gender (VARCHAR(10), NOT NULL): The gender of the patient.

   vi. address (VARCHAR(100), NOT NULL): The address of the patient.

   vii. phone (VARCHAR(15), NOT NULL): The patient's phone number.

   viii. email (VARCHAR(100)): The email address of the patient.

   ix. insurance_number (VARCHAR(100), NOT NULL): The patient's insurance policy number.

2. Dentist: This table stores information about various healthcare providers and their respective specialties.

   i. dentist_id: (INT, AUTO_INCREMENT, PRIMARY KEY): The unique identifier for each dentist.

   ii. First_name:  (VARCHAR(50), NOT NULL): The first name of the patient. It cannot be NULL: dentist must have a first name

   iii. Last_name:  (VARCHAR(50), NOT NULL): The last name of the patient. It cannot be NULL: dentist must have a last name

   iv. addressOfPractice: VARCHAR(50) NOT NULL, contains the address where a particular dentist practices.

   v. Specialty: VARCHAR(50) NOT NULL, contains the specialty of practice for each dentist.

   vi. phone: (VARCHAR(15), NOT NULL), The dentist's phone number.

   vii. email: (VARCHAR(100)), The email address of the dentist.


3. PatientRecord: This table stores medical records of patients, including their diagnosis and proposed treatment.

   i. record_ID (INT, AUTO_INCREMENT, PRIMARY KEY): The unique identifier for each patient record.

   ii. diagnosis (VARCHAR(255), NOT NULL): The diagnosis is given to the patient.

   iii. treatment_proposed (TEXT): The treatment plan for the patient.

   iv. patient_ID (INT, NOT NULL): The unique identifier of the patient (Foreign Key from demographics).

   v. dentist_ID (INT, NOT NULL): The unique identifier of the dentist responsible for the treatment (Foreign Key from the dentist). 

4. Appointment: This table records patient appointments with dentists.

   i. appointment_id (INT, AUTO_INCREMENT, PRIMARY KEY): The unique identifier for each appointment.

   ii. appointmentDate (DATETIME, NOT NULL): The scheduled date and time of the appointment.

   iii. location (VARCHAR(255)): The location of the dental appointment.

   iv. appointment_status (ENUM: 'Scheduled', 'Completed', 'Cancelled', NOT NULL): The status of the appointment.

   v. patient_id (INT, NOT NULL): The unique identifier of the patient attending the appointment (Foreign Key from demographics).

   vi. dentist_id (INT, NOT NULL): The unique identifier of the dentist assigned to the appointment (Foreign Key from the dentist).

   vii. record_id (INT, Nullable): The associated patient record for the appointment (Foreign Key from patientRecord).

5. BillingInfo: This table stores billing details related to patients and their appointments.

   i. bill_ID (INT, AUTO_INCREMENT, PRIMARY KEY): The unique identifier for each bill.

   ii. amount (INT): The total amount for the bill.

   iii. paymentStatus (ENUM('paid', 'unpaid')): The status of the payment.

   iv. patient_id (INT): The ID of the patient associated with the bill.

   v. appointment_ID (INT): The ID of the appointment related to the bill.

   vi. Foreign Keys:
   
           patient_id → References demographics(patient_id).
   
           appointment_ID → References appointment(appointment_ID).

   vii. Trigger: generate_billing_info: This trigger automatically generates billing information when an appointment is marked as "Completed."

           Trigger Type: AFTER INSERT
           Trigger Condition: When a new appointment is added and its status is changed to 'Completed.'
           Process:
           1. Retrieves the treatment proposed from the patientRecord table based on the record_id of the appointment.
           2. Fetches the cost of the treatment from the treatmentCost table.
           3. If no cost is found, a default value of 100.00 is assigned.
           4. Inserts a new billing record into the billingInfo table, capturing:
                   The first name and last name of the patient (from demographics).
                   The appointment ID and patient ID.
                   The treatment cost.
           5. The payment status is set as 'unpaid'.

6. Treatment Cost Table: This table maintains the cost of various treatments.

   i. treatment (VARCHAR(255)): The name of the treatment.

   ii. cost (INT): The cost of the treatment.


7. Inventory Table: This table stores information about medical inventory items.

   i. item_id (INT, AUTO_INCREMENT, PRIMARY KEY): The unique identifier for each inventory item.

   ii. itemName (VARCHAR(255)): The name of the inventory item.

   iii. quantityAvailable (INT): The number of available items in stock.

8. Tools Used

   i. AWS (Amazon Web Services): The database was hosted on AWS to facilitate cloud collaboration, ensuring accessibility and scalability.

   ii. GitHub: Used for team collaboration, version control, and tracking project progress.

   iii. MySQL Server: For database management and execution of SQL queries.

   iv. MySQL Workbench: For database modeling, design, and visualization. Also for ER diagram creation through reverse engineering.

   v. Draw.io: For UML diagram creation.

