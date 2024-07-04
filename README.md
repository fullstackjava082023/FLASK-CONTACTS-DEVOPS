# Project Name

A brief description of the project, what it does, and its main features.

## Table of Contents

- [Use](#use)
- [Installation](#installation)
- [Screenshots](#Screenshots)
- [License](#license)
- [Contact](#contact)


# Flask contacts

![alls](https://github.com/tanrax/flask-contacts/raw/master/screenshots/alls.jpg)

## Use

* Flask (Obvious!)
* Flask-SQLAlchemy (ORM for database)
* Flask-WTF (Generation of forms and validations)
* Faker (Generates fake data)

## installation
#### Python installation(Debian/Ubuntu)
```bash
sudo apt update
sudo apt install python3
sudo apt install python3-pip
sudo apt install python3-venv

```
#### .venv creation (Optional)
```bash
python -m venv .venv
source .venv/bin/activate
```

#### Install dependencies
```bash
pip install -r requirements.txt
```


## Run

#### environment variables
This project requires the following environment variables to be set:
Create a .env file in the root of your project and add the following lines:
#### Required Variables:

 - DB_HOST: The hostname of your MySQL database. default localhost
 - DB_USER: The username for your MySQL database. default root
 - DB_PASSWORD: The password for your MySQL database. default admin
 - DB_NAME: The name of your MySQL database. default contacts_app
 - DATABASE_TYPE: MYSQL or MONGO. default MYSQL

#### Optional Variables
 - OPENAI_API_KEY: Your OpenAI API key. Obtain this from the OpenAI API settings page.
 - MONGO_URI: in case you are using mongodb default - mongodb://localhost:27017/

#### Set environment variables by script (Linux optional)
```bash
export OPENAI_API_KEY=your_openai_api_key
export DB_HOST=your_database_host
export DB_USER=your_database_user
export DB_PASSWORD=your_database_password
export DB_NAME=your_database_name
export DEBUG=false
```


#### For MYSQL RUN Migration
```bash
python migrate.py
```


```bash
python app.py
```

## Access the application :
application should be available at port 5052
Route examples:
- http://localhost:5052/
- http://127.0.0.1:5052/viewContacts
- http://127.0.0.1:5052/editContact/{id}
- http://127.0.0.1:5052/addContact/

## Screenshots

![delete](https://github.com/tanrax/flask-contacts/raw/master/screenshots/delete.jpg)
![edit](https://github.com/tanrax/flask-contacts/raw/master/screenshots/edit.jpg)
![message](https://github.com/tanrax/flask-contacts/raw/master/screenshots/message.jpg)
![new](https://github.com/tanrax/flask-contacts/raw/master/screenshots/new.jpg)
![search](https://github.com/tanrax/flask-contacts/raw/master/screenshots/search.jpg)

## License
some license example

## Contact
contact Arja Stark from Winterfell
```
