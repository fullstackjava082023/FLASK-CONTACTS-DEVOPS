import mysql.connector
from openai import OpenAI
import requests
from dotenv import load_dotenv
import faker
import os

load_dotenv()

# Get the OpenAI API key from environment variables
client = OpenAI(
  api_key=os.getenv('OPENAI_API_KEY'),  # this is also the default, it can be omitted
)

def generate_image(prompt, filename):
    response = client.images.generate(
        prompt=prompt,
        size="256x256",
    )
    image_url = response.data[0].url
    # get the file from the url
    stream = requests.get(image_url)
    with open(filename, "wb") as f:
        f.write(stream.content)
    print(f"Image saved as {filename}")


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
    print(f"Database {os.getenv('DB_NAME')} created successfully")


def create_contacts_table():
    cursor.execute("CREATE TABLE IF NOT EXISTS contacts ("
                   "number INT AUTO_INCREMENT PRIMARY KEY,"
                   "name VARCHAR(255) NOT NULL,"
                   "phone VARCHAR(50),"
                   "email VARCHAR(255) NOT NULL,"
                   "gender VARCHAR(10),"
                   "photo  VARCHAR(255))")
    db.commit()
    print("Table created successfully")


def create_fake_data():
    fake = faker.Faker()
    for _ in range(5):
        name = fake.name()
        phone = fake.phone_number()
        email = fake.email()
        gender = fake.random_element(elements=('Male','Female'))
        photo = f"{name}.jpg"
        image = generate_image(name,f'static/images/{photo}')
        cursor.execute("INSERT INTO contacts (name, phone, email, gender, photo) "
                       "VALUES (%s, %s, %s, %s, %s)",
                       (name, phone, email, gender, photo))
        db.commit()
        print(f"Contact {name} added successfully")


def main():
    create_db()
    create_contacts_table()
    create_fake_data()



if __name__ == '__main__':
    main()
