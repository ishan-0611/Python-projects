import sqlite3

conn = sqlite3.connect('Customer.db')
print('Database Connected..')

names = []
phones = []
emails = []
data = conn.execute('Select * from Customer')
for row in data:
    names.append(row[0])
    phones.append(row[1])
    emails.append(row[2])


while True:
    ch = input('Enter y to continue or q to quit : ')
    if ch == 'q':
        break
    else:
        a = 1
        name = ""
        while a == 1:
            name = input('Enter name of the customer : ')
            if name not in names:
                print('Enter valid name..')
            else:
                break

        phone = input('Enter phone number : ')
        email = input('Enter email id : ')

        idx = names.index(name)
        if phone == phones[idx] and email == emails[idx]:
            print('Customer Details VERIFIED...')
        else:
            print('Customer Details NOT VERIFIED...')

conn.close()
print('Database Closed..')
