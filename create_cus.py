import sqlite3

conn = sqlite3.connect('Customer.db')
print('Database opened..')

conn.execute("""
CREATE TABLE CUSTOMER(
NAME PRIMARY KEY NOT NULL,
PHONE TEXT NOT NULL,
EMAIL TEXT NOT NULL);
""")

print('Table created..')
conn.close()
