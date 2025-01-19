from flask import Flask, request

import pymongo
from dotenv import load_dotenv
import os

app = Flask(__name__)

my_client = pymongo.MongoClient(os.getenv("MONGO_URI", "mongodb://localhost:27017/"))
mydb = my_client[os.getenv("DB_NAME", "contacts_app")]
alerts_collection = mydb["alerts"]

# adding an alert to the database
def add_alert(data):
    alerts_collection.insert_one({"data": data})
    return "Alert deleted successfully"



@app.route('/alert', methods=['POST'])
def alert():
    data = request.json
    print("Received Alert: ", data)  # Print the alert data to the console
    add_alert(data)  # Add the alert data to the database
    return "OK", 200


if __name__ == '__main__':
    app.run(port=5000, host='0.0.0.0')


