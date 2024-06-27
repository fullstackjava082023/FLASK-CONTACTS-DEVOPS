import mysql.connector
from openai import OpenAI
import requests
from dotenv import load_dotenv
import faker
import os

load_dotenv()

# Get the OpenAI API key from environment variables
api_key=os.getenv('OPENAI_API_KEY')
client = OpenAI(api_key=api_key) if api_key else None

def generate_image(prompt, filename):
    if client:
        try:
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
            return filename
        except requests.RequestException as e:
            print(f"Failed to generate image: {e}")
    return None


# create a connection to the database
db = mysql.connector.connect(
    host=os.getenv("DB_HOST", "localhost"),
    user=os.getenv("DB_USER", "root"),
    passwd=os.getenv("DB_PASSWORD", "admin"),
)

cursor = db.cursor(dictionary=True)


def create_db():
    db_name = os.getenv('DB_NAME', 'contacts_app')
    cursor.execute(f"CREATE DATABASE IF NOT EXISTS {db_name}")
    cursor.execute(f"USE {db_name}")
    db.commit()
    print(f"Database {db_name} created successfully")


def create_contacts_table():
    cursor.execute("CREATE TABLE IF NOT EXISTS contacts ("
                   "number INT AUTO_INCREMENT PRIMARY KEY,"
                   "name VARCHAR(255) NOT NULL,"
                   "phone VARCHAR(255),"
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
        gender = fake.random_element(elements=('Male','Female', 'Other'))
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
