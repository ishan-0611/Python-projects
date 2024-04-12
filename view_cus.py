import sqlite3

conn = sqlite3.connect('Customer.db')
print('Database Connected..')

cursor = conn.execute('Select * from Customer;')

for row in cursor:
    print(row)

print('Records printed.')
