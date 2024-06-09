import mysql.connector
from dotenv import load_dotenv
import faker
import os

load_dotenv()

# create a connection to the database
db = mysql.connector.connect(
    host=os.getenv("DB_HOST"),
    user=os.getenv("DB_USER"),
    passwd=os.getenv("DB_PASSWORD"),
)

cursor = db.cursor(dictionary=True)


def create_db():
    cursor.execute(f"CREATE DATABASE IF NOT EXISTS {os.getenv('DB_NAME')}")
    cursor.execute(f"USE {os.getenv('DB_NAME')}")
    db.commit()


def create_contacts_table():
    cursor.execute("CREATE TABLE IF NOT EXISTS contacts ("
                   "number INT AUTO_INCREMENT PRIMARY KEY,"
                   "name VARCHAR(255) NOT NULL,"
                   "phone VARCHAR(20),"
                   "email VARCHAR(255) NOT NULL,"
                   "gender VARCHAR(10),"
                   "photo  VARCHAR(255))")
    db.commit()


def create_fake_data():
    fake = faker.Faker()
    for _ in range(10):
        name = fake.name()
        phone = fake.phone_number()
        email = fake.email()
        gender = fake.random_element(elements=('Male','Female'))
        photo = f"{name}.jpg"
        cursor.execute("INSERT INTO contacts (name, phone, email, gender, photo) "
                       "VALUES (%s, %s, %s, %s, %s)",
                       (name, phone, email, gender, photo))
        db.commit()

def main():
    create_db()
    create_contacts_table()
    create_fake_data()


if __name__ == '__main__':
    main()
