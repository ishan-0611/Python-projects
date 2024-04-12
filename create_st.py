import sqlite3

conn = sqlite3.connect('Student_marks.db')
print('Database opened..')

conn.execute("""
CREATE TABLE STUDENT_MARKS(
NAME PRIMARY KEY NOT NULL,
M1 INT NOT NULL,
M2 INT NOT NULL,
M3 INT NOT NULL);
""")

print('Table created..')
conn.close()
