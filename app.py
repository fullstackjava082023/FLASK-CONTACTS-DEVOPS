from flask import Flask, render_template, request, redirect
from dotenv import load_dotenv
import os
load_dotenv()


# Retrieve the DATABASE_TYPE environment variable, defaulting to 'MYSQL' if not set
db_to_use = os.getenv("DATABASE_TYPE", "MYSQL")

if db_to_use == "MYSQL":
    from data_sql import (get_contacts, findByNumber,
                          check_contact_exist, search_contacts,
                          create_contact,
                          delete_contact, update_contact_in_db)
elif db_to_use == "MONGO":
    from data_mongo import (get_contacts, findByNumber,
                            check_contact_exist, search_contacts,
                            create_contact,
                            delete_contact, update_contact_in_db)

app = Flask(__name__)




@app.route('/')
def hello():
    return redirect('/viewContacts')


@app.route('/addContact', methods=['GET', 'POST'])
def addContact():
    return render_template('addContactForm.html')


# route to view the contact list
@app.route('/viewContacts')
def viewContacts():
    print(get_contacts())
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

@app.route('/deleteContact/<number>')
def deleteContact(number):
    delete_contact(number)
    return redirect('/viewContacts')


@app.route('/editContact/<number>')
def editContact(number):
    contact = findByNumber(number)
    return render_template('editContactForm.html', contact=contact)

@app.route('/saveUpdatedContact/<number>', methods=['POST'])
def saveUpdatedContact(number):
    name = request.form['fullname']
    phone = request.form['phone']
    email = request.form['email']
    gender = request.form['gender']
    update_contact_in_db(number, name, phone, email, gender)
    return redirect('/viewContacts')


# search route to filter the contact list according to the search criteria:
@app.route('/search', methods=['POST'])
def search():
    search_name = request.form['search_name']
    search_results = search_contacts(search_name)
    return render_template('index.html', contacts=search_results)



if __name__ == '__main__':
    app.run(debug=True ,port=5052,  host='0.0.0.0')
