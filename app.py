from flask import Flask, render_template, request, redirect
import mysql.connector

app = Flask(__name__)

# Connect to MySQL database
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="admin",
    database="contacts_app"
)


# list, set , dictionary, tuple similar to database
# contacts_list = [
#                     {
#                         'number': 1,
#                         'name': 'Arja Stark',
#                         'phone': '044545',
#                         'email': 'Valan.Margulis@Winterfel.com',
#                         'photo': 'arya-stark.jpg',
#                         'gender': 'Female'
#                     },
#                     {
#                         'number': 2,
#                         'name': 'Jon Snow',
#                         'phone': '045456465',
#                         'email': 'Night.Watch@Wall.com',
#                         'photo': 'jon-snow.jpg',
#                         'gender': 'Male'
#                     },
#                     {
#                         'number': 3,
#                         'name': 'Ned Stark',
#                         'phone': '04545',
#                         'email': 'Ned@WF.com',
#                         'photo': 'ned-stark.jpg',
#                         'gender': 'Male'
#                     },
#                     {
#                         'number': 4,
#                         'name': 'Hodor',
#                         'phone': 'hodor',
#                         'email': 'hodor@hodor.com',
#                         'photo': 'hodor.jpg',
#                         'gender': 'Male'
#                     }
#                 ]

# function to find all contacts by query in the mysql database
cursor = db.cursor(dictionary=True)
def get_contacts():
    cursor.execute("SELECT * FROM contacts")
    result = cursor.fetchall()
    return result


# contacts_list = get_contacts()


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


@app.route('/')
def hello():
    return 'Hello, World!'


@app.route('/addContact', methods=['GET', 'POST'])
def addContact():
    return render_template('addContactForm.html')


# route to view the contact list
@app.route('/viewContacts')
def viewContacts():
    return render_template('index.html', contacts=get_contacts())



@app.route('/createContact', methods=['POST'])
def createContact():
    # adding additional contact to the database (contacts_list)
    fullname = request.form['fullname']
    email = request.form['email']
    phone = request.form['phone']   
    gender = request.form['gender']
    photo = request.files['photo']
    if not check_contact_exist(fullname, email):
        if photo:
            # create a name for the file to be saved
            file_path = 'static/images/' + fullname + '.jpg'
            # save the file in the server
            photo.save(file_path)
        # create a new contact
        create_contact(fullname, phone, email, gender, f'{fullname}.jpg')
    else:
        return render_template('addContactForm.html', message='Contact already exists')
    return redirect('/viewContacts')

@app.route('/deleteContact/<int:number>')
def deleteContact(number):
    delete_contact(number)
    return redirect('/viewContacts')

# search route to filter the contact list according to the search criteria:
@app.route('/search', methods=['POST'])
def search():
    search_name = request.form['search_name']
    search_results = search_contacts(search_name)
    return render_template('index.html', contacts=search_results)



if __name__ == '__main__':
    app.run(debug=True ,port=5051)