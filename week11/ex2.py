from pymongo import MongoClient
import datetime

client = MongoClient("mongodb://localhost")
db = client['test']


def query1():
    """
        Insert into the database
    """
    print("Query 1: Insert into the database")
    result = db.restaurants.insert_one({
        "address": {
            "building": "126",
            "coord": [-73.9557413, 40.7720266],
            "street": "Sportivnaya",
            "zipcode": "420500"
        },
        "borough": "Innopolis",
        "cuisine": "Serbian",
        "id": 41712354,
        "grades": [{
            "date": datetime.datetime(2023, 4, 11, 0, 0),
            "score": 11,
            "grade": "A",
        }]
    })
    print(f'Inserted with ID: {result.inserted_id}')


query1()
print()
