import sqlite3

conn = sqlite3.connect('Student_marks.db')
print('Database Connected..')

cursor = conn.execute('Select * from STUDENT_MARKS;')

for row in cursor:
    print(row)

print('Records printed.')
