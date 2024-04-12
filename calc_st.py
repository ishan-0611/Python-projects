import sqlite3

conn = sqlite3.connect('Student_marks.db')
cursor = conn.execute('Select * from STUDENT_MARKS;')

names = []
marks1 = []
marks2 = []
marks3 = []
for row in cursor:
    names.append(row[0])
    marks1.append(row[1])
    marks2.append(row[2])
    marks3.append(row[3])


total = []
grades = []

for name in names:
    idx = names.index(name)
    total.append(marks1[idx] + marks2[idx] + marks3[idx])

for num in total:
    if num >= 270:
        grades.append('A')
    elif num >= 240 and num < 270:
        grades.append('B')
    else:
        grades.append('C')

for i in range(len(names)):
    print(names[i], " : ", grades[i])
