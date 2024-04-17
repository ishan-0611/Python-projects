# Defining the initial dataset
data = [
    ['T100', ['I1', 'I2', 'I5']],
    ['T200', ['I2', 'I4']],
    ['T300', ['I2', 'I3']],
    ['T400', ['I1', 'I2', 'I4']],
    ['T500', ['I1', 'I3']],
    ['T600', ['I2', 'I3']],
    ['T700', ['I1', 'I3']],
    ['T800', ['I1', 'I2', 'I3', 'I5']],
    ['T900', ['I1', 'I2', 'I3']]
]

# Defining the additional dataset
data2 = [
    ['T100', ['M', 'O', 'N', 'K', 'E', 'Y']],
    ['T200', ['D', 'O', 'N', 'K', 'E', 'Y']],
    ['T300', ['M', 'A', 'K', 'E']],
    ['T400', ['M', 'U', 'C', 'K', 'Y']],
    ['T500', ['C', 'O', 'K', 'I', 'E']]
]

# Minimum support threshold
min_sup = 2


# Function to count occurrences of candidate itemsets in transactions
def getCount(c, dataset):
    mp = {}
    for i in c:   # For each candidate itemset
        for j in dataset:     # For each transaction
            if set(i).issubset(j[1]):   # Check if the itemset is present in the transaction
                k = tuple(i)
                if k in mp.keys():    # If item already in map, increment count
                    mp[k] += 1
                else:
                    mp[k] = 1

    print(mp)   # Just for debugging
    return mp


# Function to generate frequent itemsets from candidate itemsets based on minimum support
def getL(c, mini_sup, dataset):
    l = []
    mp = getCount(c, dataset)   # Get counts of candidate itemsets
    for i in mp.keys():
        if mp[i] >= mini_sup:   # If count meets minimum support, add to frequent itemsets
            l.append(i)
    return l


# Function to generate candidate itemsets from frequent itemsets
def genC(l):
    c = []
    for i in range(len(l) - 1):
        for j in range(i+1, len(l)):
            if l[i][:-1] == l[j][:-1]:  # If all elements except last are same, combine last
                temp = list(l[i])
                temp.append(l[j][-1])
                c.append(tuple(temp))
    return c


# Function for apriori
def apriori(dataset, mini_sup):
    c = []
    l = []

    # Initialise candidate itemset with single items
    for i in dataset:
        for j in i[1]:
            if j not in c:
                c.append(j)

    c.sort()
    temp = []
    for i in c:
        temp.append([i])
    c = temp

    # Iteratively generate frequent itemsets and candidate itemsets until no more can be generated
    while c:
        l.append(getL(c, mini_sup, dataset))   # Generate frequent from candidates
        c = genC(l[-1])   # Generate new candidates from frequent

    # Print the frequent itemsets
    print('Frequent itemsets : ')
    for i in l[:-1]:
        print(i)


# Calling the function for apriori algorithm
apriori(data, min_sup)
