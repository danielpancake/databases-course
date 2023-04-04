from pymongo import MongoClient
from datetime import datetime

client = MongoClient("mongodb://localhost")
db = client['test']


def query1():
    query_results = db.restaurants.find({
        "address.street": "Prospect Park West"
    })

    for restaurant in query_results:
        grades_a = list(filter(lambda grade: grade["grade"] == "A", restaurant["grades"]))

        if len(grades_a) > 1:
            # Delete the restaurant
            db.restaurants.delete_one({"_id": restaurant["_id"]})
            print(f'Deleted restaurant {restaurant["name"]} with ID {restaurant["_id"]}')
        else:
            # Add a new grade
            restaurant["grades"].append({
                "date": datetime(2023, 4, 11, 0, 0),
                "score": 11,
                "grade": "A",
            })

            # Update the restaurant
            db.restaurants.update_one({"_id": restaurant["_id"]}, {"$set": restaurant})
            print(f'Updated restaurant {restaurant["name"]} with ID {restaurant["_id"]}')


query1()
print()
