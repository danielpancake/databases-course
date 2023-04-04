from pymongo import MongoClient

client = MongoClient("mongodb://localhost")
db = client['test']


def query1():
    """
        Querying all Irish cuisines
    """
    print("Query 1: Irish cuisine")
    for restaurant in db.restaurants.find({"cuisine": "Irish"}):
        print(f'\t{restaurant["name"]}')


def query2():
    """
        Querying all Irish and Russian cuisines
    """
    print("Query 2: Irish and Russian cuisine")

    query_results = db.restaurants.find({
        "$or": [
            {"cuisine": "Irish"},
            {"cuisine": "Russian"}
        ]
    })

    for restaurant in query_results:
        print(f'\t{restaurant["name"]}')


def query3():
    """
        Finding a restaurant with a specific address:
        "Prospect Park West 284, 11215"
    """
    print("Query 3: Restaurant with address 'Prospect Park West 284, 11215'")

    query_results = db.restaurants.find({
        "address.street": "Prospect Park West",
        "address.building": "284",
        "address.zipcode": "11215"
    })

    for restaurant in query_results:
        print(f'\t{restaurant["name"]}')


query1()
print()

query2()
print()

query3()
print()
#%%
