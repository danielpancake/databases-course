import os

from dotenv import load_dotenv
from faker import Faker
from tqdm import tqdm

import psycopg2

load_dotenv()

# https://stackabuse.com/working-with-postgresql-in-python/
con = psycopg2.connect(
    database=os.getenv("DB_NAME"),
    user=os.getenv("DB_USER"),
    password=os.getenv("DB_PASS"),
    host=os.getenv("DB_HOST"),
    port=os.getenv("DB_PORT")
)

print("Database opened successfully")
cur = con.cursor()
cur.execute('''DROP TABLE IF EXISTS CUSTOMER''')
cur.execute('''
    CREATE TABLE customer
      (
         id      INT PRIMARY KEY NOT NULL,
         NAME    TEXT NOT NULL,
         address TEXT NOT NULL,
         review  TEXT
      ) 
    ''')
print("Table created successfully")

# Populating table with fake info
faker = Faker()

for i in tqdm(range(1_000_000)):
    cur.execute(f"INSERT INTO CUSTOMER (ID, Name, Address, review) VALUES"
                f"('{i}', '{faker.name()}', '{faker.address()}', '{faker.text()}')")
    con.commit()
