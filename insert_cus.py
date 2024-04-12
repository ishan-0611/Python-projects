import sqlite3

conn = sqlite3.connect('Customer.db')

while True:
    ch = input('Enter y to continue, q to quit : ')
    if ch == 'q':
        break
    else:
        a = 1
        while a == 1:
            name = input('Enter name of customer : ')
            if name.isalpha():
                break
            else:
                print('Enter valid name.')

        while a == 1:
            phone = input('Enter phone number of customer : ')
            if phone.isdigit():
                break
            else:
                print('Enter valid phone number.')

        while a == 1:
            email = input('Enter email of the customer : ')
            break

        # noinspection PyUnboundLocalVariable
        conn.execute(f"Insert into Customer values('{name}', '{phone}', '{email}');")
        conn.commit()
