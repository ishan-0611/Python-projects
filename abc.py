import re

l1 = [1, 4, 3, 2, 5, 6, 8, 0]
n = len(l1)

for i in range(n):
    for j in range(i+1, n):
        if l1[i] >= l1[j]:
            t = l1[i]
            l1[i] = l1[j]
            l1[j] = t

print(l1)

s = "This is a string with multiple words"
s = s.lower()
lis = s.split(' ')
lis.sort()
print(lis)


# Define the variable states
states = "Mississippi Alabama Texas Massachusetts Kansas"

# Initialize an empty list to store the results
statesList = []

# a) Search for a word in variable states that ends in xas
match_xas = re.search(r'\bxas\b', states)
if match_xas:
    statesList.append(match_xas.group())

# b) Search for a word in states that begins with k and ends in s
match_k_s = re.search(r'\b[kK][a-zA-Z]*s\b', states)
if match_k_s:
    statesList.append(match_k_s.group())

# c) Search for a word in states that begins with M and ends in s
match_M_s = re.search(r'\bM[a-zA-Z]*s\b', states)
if match_M_s:
    statesList.append(match_M_s.group())

# d) Search for a word in states that ends in a
match_a = re.search(r'\b[a-zA-Z]*a\b', states)
if match_a:
    statesList.append(match_a.group())

# e) Search for a word that begins with M in states at the beginning of the string
match_M_beginning = re.search(r'\bM[a-zA-Z]*', states)
if match_M_beginning:
    statesList.append(match_M_beginning.group())

# f) Output the array statesList to the screen
print(statesList)


def isprime(k):
    c = 0
    for i in range(1, k+1):
        if k % i == 0:
            c += 1

    if c == 2:
        return True
    else:
        return False


a = 10
b = 50
cnt = 0
for i in range(a, b+1):
    if isprime(i):
        print(i, end = " ")
        cnt += 1

print("\n")
print("count :", cnt)


