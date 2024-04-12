import sqlite3

conn = sqlite3.connect('Student_marks.db')

while True:
    ch = input('Enter y to continue, q to quit : ')
    if ch == 'q':
        break
    else:
        a = 1
        while a == 1:
            name = input('Enter name of student : ')
            if name.isalpha():
                break
            else:
                print('Enter valid name.')

        while a == 1:
            m1 = input('Enter marks (1) : ')
            if m1.isdigit():
                break
            else:
                print('Enter valid marks.')

        while a == 1:
            m2 = input('Enter marks (2) : ')
            if m2.isdigit():
                break
            else:
                print('Enter valid marks.')

        while a == 1:
            m3 = input('Enter marks (3) : ')
            if m3.isdigit():
                break
            else:
                print('Enter valid marks.')

        # noinspection PyUnboundLocalVariable
        conn.execute(f"Insert into STUDENT_MARKS values('{name}', {m1}, {m2}, {m3});")
        conn.commit()
