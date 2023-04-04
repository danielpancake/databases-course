from pymongo import MongoClient

client = MongoClient("mongodb://localhost")
db = client['test']


def query1():
    """
        Delete from the database a single Brooklyn located restaurant
    """
    result = db.restaurants.delete_one({
        "borough": "Brooklyn"
    })

    print("Query 1: Delete from the database a single Brooklyn located restaurant")
    print(f'Deleted {result.deleted_count} document(s)')


def query2():
    """
        Delete from the database all Thai cuisine restaurants
    """
    result = db.restaurants.delete_many({
        "cuisine": "Thai"
    })

    print("Query 2: Delete from the database all Thai cuisine restaurants")
    print(f'Deleted {result.deleted_count} document(s)')


query1()
print()

query2()
print()
