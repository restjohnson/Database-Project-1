import mysql.connector
from dotenv import load_dotenv
import os
from getpass import getpass

load_dotenv()

def create_database_connection():
    try:
        cnx = mysql.connector.connect(
            host=os.getenv("DB_HOST"),
            user=os.getenv("DB_USER"),
            password=os.getenv("DB_PASSWORD"),
            database=os.getenv("DB_NAME"),
            port=int(os.getenv("DB_PORT", 3306))
        )
        if cnx.is_connected():
            return cnx
    except mysql.connector.Error as e:
        print("Error while connecting to MySQL:", e)
    return None

def login(cnx):
    username = input("Username: ")
    password = getpass("Password: ")
    cursor = cnx.cursor(dictionary=True)
    try:
        cursor.callproc('LoginUser', [username, password])
        for result in cursor.stored_results():
            user = result.fetchone()
            if user:
                print(f"\n Login successful. Welcome, {user['Username']} ({user['RoleName']})\n")
                return user
    except mysql.connector.Error as err:
        print(f"Login failed: {err}")
    finally:
        cursor.close()
    print(" Invalid username or password.")
    return None

def perform_operation(cnx, proc_name, *args):
    cursor = cnx.cursor(dictionary=True)
    try:
        cursor.callproc(proc_name, args)
        cnx.commit()
        for result in cursor.stored_results():
            rows = result.fetchall()
            if rows:
                for row in rows:
                    print("\n--- Record ---")
                    for key, value in row.items():
                        print(f"{key.replace('_', ' ').title()}: {value}")
                    print("----------------------")
            else:
                print("No results.")
    except mysql.connector.Error as err:
        print(f"Error during operation: {err}")
    finally:
        cursor.close()

def execute_log_view(cnx, table_name):
    cursor = cnx.cursor(dictionary=True)
    try:
        cursor.execute(f"SELECT * FROM {table_name} ORDER BY change_date DESC LIMIT 10")
        rows = cursor.fetchall()
        if rows:
            for row in rows:
                print("\n--- Log Entry ---")
                for key, value in row.items():
                    print(f"{key.replace('_', ' ').title()}: {value}")
                print("----------------------")
        else:
            print("No log entries found.")
    except mysql.connector.Error as err:
        print(f"Error retrieving logs: {err}")
    finally:
        cursor.close()

def audit_logs_menu(cnx):
    while True:
        print("\n Audit Logs Menu:")
        print("1. View Inventory Changes")
        print("2. View Dentist Changes")
        print("3. View Patient Record Changes")
        print("4. View Appointment Changes")
        print("5. View Billing Changes")
        print("6. View Demographics Changes")
        print("0. Back")
        choice = input("Select option: ")

        if choice == '1':
            execute_log_view(cnx, "inventoryLog")
        elif choice == '2':
            execute_log_view(cnx, "dentistLog")
        elif choice == '3':
            execute_log_view(cnx, "recordLog")
        elif choice == '4':
            execute_log_view(cnx, "appointmentLog")
        elif choice == '5':
            execute_log_view(cnx, "billingLog")
        elif choice == '6':
            execute_log_view(cnx, "demographicsLog")
        elif choice == '0':
            break
        else:
            print("Invalid choice.")

def practitioner_menu(cnx):
    while True:
        print("\n Practitioner Menu:")
        print("1. Create Patient Record")
        print("2. View Patient Record")
        print("3. View Reports")
        print("4. View Audit Logs")
        print("0. Logout")
        choice = input("Select option: ")

        if choice == '1':
            patient_id = int(input("Patient ID: "))
            dentist_id = int(input("Practitioner ID: "))
            diagnosis = input("Diagnosis: ")
            treatment = input("Treatment: ")
            perform_operation(cnx, 'CreatePatientRecord', patient_id, dentist_id, diagnosis, treatment)

        elif choice == '2':
            patient_id = int(input("Patient ID: "))
            perform_operation(cnx, 'ViewPatientRecord', patient_id)

        elif choice == '3':
            reporting_menu(cnx)

        elif choice == '4':
            audit_logs_menu(cnx)

        elif choice == '0':
            break
        else:
            print("Invalid option.")

def query_view_by_patient_id(cnx, view_name):
    patient_id = input("Enter your Patient ID: ")
    cursor = cnx.cursor(dictionary=True)
    try:
        query = f"SELECT * FROM {view_name} WHERE patient_id = %s"
        cursor.execute(query, (patient_id,))
        rows = cursor.fetchall()
        if rows:
            for row in rows:
                print("\n--- Record ---")
                for key, value in row.items():
                    print(f"{key.replace('_', ' ').title()}: {value}")
                print("----------------------")
        else:
            print("No records found.")
    except mysql.connector.Error as err:
        print(f"Error: {err}")
    finally:
        cursor.close()

def query_by_column(cnx, view_name, column_name, value):
    cursor = cnx.cursor(dictionary=True)
    try:
        query = f"SELECT * FROM {view_name} WHERE {column_name} = %s"
        cursor.execute(query, (value,))
        rows = cursor.fetchall()
        if rows:
            for row in rows:
                print("\n--- Record ---")
                for key, value in row.items():
                    print(f"{key.replace('_', ' ').title()}: {value}")
                print("----------------------")
        else:
            print("No matching records.")
    except mysql.connector.Error as err:
        print(f"Error: {err}")
    finally:
        cursor.close()

def execute_simple_view(cnx, view_name):
    cursor = cnx.cursor(dictionary=True)
    try:
        cursor.execute(f"SELECT * FROM {view_name}")
        rows = cursor.fetchall()
        if rows:
            for row in rows:
                print("\n--- Record ---")
                for key, value in row.items():
                    print(f"{key.replace('_', ' ').title()}: {value}")
                print("----------------------")
        else:
            print("No records found.")
    except mysql.connector.Error as err:
        print(f"Error: {err}")
    finally:
        cursor.close()

def patient_menu(cnx):
    while True:
        print("\n Patient Menu:")
        print("1. View My Billing")
        print("2. View My Appointments")
        print("0. Logout")
        choice = input("Select option: ")

        if choice == '1':
            query_view_by_patient_id(cnx, 'Patient_Billing_View')
        elif choice == '2':
            query_view_by_patient_id(cnx, 'Appointment_Details_View')
        elif choice == '0':
            break
        else:
            print("Invalid option.")

def reporting_menu(cnx):
    while True:
        print("\n Reporting Menu:")
        print("1. Patient Details")
        print("2. Visit Details")
        print("3. Billing Overview")
        print("4. Patient Billing Summary")
        print("5. Provider Schedule")
        print("6. Appointment Calendar")
        print("0. Back")
        choice = input("Choose: ")

        if choice == '1':
            query_view_by_patient_id(cnx, 'Patient_Details_View')
        elif choice == '2':
            query_view_by_patient_id(cnx, 'Appointment_Details_View')
        elif choice == '3':
            execute_simple_view(cnx, 'Billing_Details_View')
        elif choice == '4':
            query_view_by_patient_id(cnx, 'Patient_Billing_View')
        elif choice == '5':
            provider_id = input("Enter Provider ID: ")
            query_by_column(cnx, 'Provider_Schedule_View', 'Provider_ID', provider_id)
        elif choice == '6':
            execute_simple_view(cnx, 'Appointment_Calendar_View')
        elif choice == '0':
            break
        else:
            print("Invalid option.")

def main():
    cnx = create_database_connection()
    if not cnx:
        print("Could not connect to the database.")
        return

    try:
        user = login(cnx)
        if not user:
            return

        role = user['RoleName'].lower()

        if role == 'practitioner':
            practitioner_menu(cnx)
        elif role == 'patient':
            patient_menu(cnx)
        else:
            print("Access denied: unknown role.")
    finally:
        cnx.close()

if __name__ == "__main__":
    main()
