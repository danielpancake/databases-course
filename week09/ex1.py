import os

from dotenv import load_dotenv
from geopy.geocoders import Nominatim
import psycopg2

load_dotenv()

con = psycopg2.connect(
    database=os.getenv("DB_NAME"),
    user=os.getenv("DB_USER"),
    password=os.getenv("DB_PASS"),
    host=os.getenv("DB_HOST"),
    port=os.getenv("DB_PORT")
)
print("Database opened successfully")

cur = con.cursor()
# Loading a function that retrieves all addresses containing the number "11" and with a city_id between 400 and 600
fd = open("get_addresses_special.sql", "r")
get_addresses_special = fd.read()
fd.close()

cur.execute(get_addresses_special)
print("Function created successfully")

cur.execute('''SELECT * FROM get_addresses_special();''')
query_result = cur.fetchall()
print("Function executed successfully")

# Add two columns (longitude and latitude) to the table
cur.execute('''
    ALTER TABLE address
    ADD IF NOT EXISTS longitude float DEFAULT(0);
    
    ALTER TABLE address
    ADD IF NOT EXISTS latitude float DEFAULT(0);
    ''')

geolocator = Nominatim(user_agent="InnopolisUniversityPractice")
for row in query_result:
    addr_id, addr1, addr2, postcode = [str(x) if row is not None else "" for x in row]
    location = geolocator.geocode({"address": addr1, "postalcode": postcode}, timeout=20)

    if location:
        print(f"Found place: {location}")
        cur.execute(f'''
            UPDATE address
            SET longitude = {location.longitude},
                latitude  = {location.latitude}
            WHERE address_id={addr_id};
        ''')
    else:
        print(f"Failed to find: (id:{addr_id}) {addr1}")

con.commit()
con.close()

#%%
