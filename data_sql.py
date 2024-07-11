import mysql.connector
from dotenv import load_dotenv
import os
load_dotenv()

# Connect to MySQL database
db = mysql.connector.connect(
    host=os.getenv("DB_HOST", "localhost"),
    user=os.getenv("DB_USER", "root"),
    password=os.getenv("DB_PASSWORD", "admin"),
    database=os.getenv("DB_NAME", "contacts_app"),
    port=os.getenv("DB_PORT", 3306)
)


# function to find all contacts by query in the mysql database
cursor = db.cursor(dictionary=True)
def get_contacts():
    cursor.execute("SELECT * FROM contacts")
    result = cursor.fetchall()
    return result


# contacts_list = get_contacts()

def update_contact_in_db(number, name, phone, email, gender):
    cursor.execute("UPDATE contacts SET name = %s, phone = %s, email = %s, gender = %s WHERE number = %s",
                   (name, phone, email, gender, number))
    db.commit()


# function to find contact by number
def findByNumber(number):
    cursor.execute("SELECT * FROM contacts WHERE number = %s", (number,))
    result = cursor.fetchone()
    return result


def check_contact_exist(name, email):
    cursor.execute("SELECT * FROM contacts WHERE name = %s OR email = %s", (name, email))
    result = cursor.fetchone()
    return bool(result)


def search_contacts(search_name):
    cursor.execute("SELECT * FROM contacts WHERE name LIKE %s", ('%' + search_name + '%',))
    result = cursor.fetchall()
    return result


def create_contact(name, phone, email, gender, photo):
    cursor.execute("INSERT INTO contacts (name, phone, email, gender, photo) VALUES (%s, %s, %s, %s, %s)", (name, phone, email, gender, photo))
    db.commit()
    return "Contact added successfully"


def delete_contact(number):
    cursor.execute("DELETE FROM contacts WHERE number = %s", (number,))
    db.commit()
    return "Contact deleted successfully"
