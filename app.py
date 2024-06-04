from flask import Flask, render_template, request, redirect


app = Flask(__name__)

# list, set , dictionary, tuple similar to database
contacts_list = [
                    {
                        'number': 1,
                        'name': 'Arja Stark',
                        'phone': '044545',
                        'email': 'Valan.Margulis@Winterfel.com',
                        'photo': 'arya-stark.jpg',
                        'gender': 'Female'
                    },
                    {
                        'number': 2,
                        'name': 'Jon Snow',
                        'phone': '045456465',
                        'email': 'Night.Watch@Wall.com',
                        'photo': 'jon-snow.jpg',
                        'gender': 'Male'
                    },
                    {
                        'number': 3,
                        'name': 'Ned Stark',
                        'phone': '04545',
                        'email': 'Ned@WF.com',
                        'photo': 'ned-stark.jpg',
                        'gender': 'Male'
                    },
                    {
                        'number': 4,
                        'name': 'Hodor',
                        'phone': 'hodor',
                        'email': 'hodor@hodor.com',
                        'photo': 'hodor.jpg',
                        'gender': 'Male'
                    }
                ]


# function to find contact by number
def findByNumber(number):
    for contact in contacts_list:
        if contact['number'] == number:
            return contact
    return None


        

@app.route('/')
def hello():
    return 'Hello, World!'


@app.route('/addContact', methods=['GET', 'POST'])
def addContact():
    return render_template('addContactForm.html')


# route to view the contact list
@app.route('/viewContacts')
def viewContacts():
    return render_template('index.html', contacts=contacts_list)



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
        new_contact =  {
                    'number': len(contacts_list) + 1,
                    'name': fullname,
                    'phone': phone,
                    'email': email,
                    'gender': gender,
                    'photo': fullname + '.jpg'
                }
        # add new contact to the list (database)
        contacts_list.append(new_contact)
    else:
        return render_template('addContactForm.html', message='Contact already exists')
    return redirect('/viewContacts')

@app.route('/deleteContact/<int:number>')
def deleteContact(number):
    contact_to_delete = findByNumber(number)
    if contact_to_delete:
        contacts_list.remove(contact_to_delete)
    return redirect('/viewContacts')


def search_contacts(search_name):
    search_results = []
    for contact in contacts_list:
        if search_name.lower() in contact['name'].lower():
            search_results.append(contact)
    return search_results


def check_contact_exist(name, email):
    for contact in contacts_list:
        if (name):
            if name.lower() == contact['name'].lower():
                return True
        if (email):
            if email.lower() == contact['email'].lower():
                return True
    return False


# search route to filter the contact list according to the search criteria:
@app.route('/search', methods=['POST'])
def search():
    search_name = request.form['search_name']
    search_results = search_contacts(search_name)
    return render_template('index.html', contacts=search_results)



if __name__ == '__main__':
    app.run(debug=True ,port=5051)