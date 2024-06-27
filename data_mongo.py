import pymongo
from dotenv import load_dotenv
import os
from bson import ObjectId
load_dotenv()

my_client = pymongo.MongoClient(os.getenv("MONGO_URI", "mongodb://localhost:27017/"))
mydb = my_client[os.getenv("DB_NAME", "contacts_app")]
my_collection = mydb["contacts"]

# implementation of the functions
# get_contacts, findByNumber, check_contact_exist,
# search_contacts, create_contact,
# delete_contact, update_contact_in_db in data_mongo.py
def get_contacts():
    return list(my_collection.find())


def findByNumber(number):
    return my_collection.find_one({"_id": ObjectId(number)})


def check_contact_exist(name, email):
    result = my_collection.find(
        {"$or": [{"name": name}, {"email": email}]})
    # convert the result to a list
    list_result = list(result)
    print(list_result)
    return bool(len(list_result))


def search_contacts(search_name):
    # the regex will find all names that contain the search_name
    # option i meaning case-insensitive
    return list(my_collection.find(
        {"name": {"$regex": search_name, "$options": "i"}}))


def create_contact(name, phone, email, gender, photo):
    my_collection.insert_one(
        {"name": name, "phone": phone, "email": email,
         "gender": gender, "photo": photo})
    return "Contact added successfully"


def delete_contact(number):
    my_collection.delete_one({"_id": ObjectId(number)})
    return "Contact deleted successfully"


def update_contact_in_db(number, name, phone, email, gender):
    my_collection.update_one(
        {"_id": ObjectId(number)},
        {"$set": {"name": name, "phone": phone,
                  "email": email, "gender": gender}})
    return "Contact updated successfully"


