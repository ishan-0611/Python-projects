import numpy as np

data = {
    'outlook': ['sunny', 'sunny', 'overcast', 'rain', 'rain', 'rain', 'overcast', 'sunny', 'sunny', 'rain', 'sunny', 'overcast', 'overcast', 'rain'],
    'temperature': ['hot', 'hot', 'hot', 'mild', 'cool', 'cool', 'cool', 'mild', 'cool', 'mild', 'mild', 'hot', 'hot', 'mild'],
    'humidity': ['high', 'high', 'high', 'high', 'normal', 'normal', 'normal', 'high', 'normal', 'normal', 'normal', 'high', 'normal', 'high'],
    'wind': ['weak', 'strong', 'weak', 'weak', 'weak', 'strong', 'strong', 'weak', 'weak', 'weak', 'strong', 'strong', 'weak', 'strong'],
    'answer': ['no', 'no', 'yes', 'yes', 'yes', 'no', 'yes', 'no', 'yes', 'yes', 'yes', 'yes', 'yes', 'no']
}


# Function to calculate entropy
def getEntropy(dataset):
    unique_values = set(dataset)
    ans = 0
    for i in unique_values:
        ans -= dataset.count(i) / len(dataset) * np.log2(dataset.count(i) / len(dataset))
    return ans


# Function to calculate information gain for a given attribute
def getInfoForAttribute(dataset, attr, target):
    unique_values = set(dataset[attr])
    unique_targets = set(dataset[target])

    info = 0
    mp = {}
    for i in unique_values:
        mp[i] = {}
        for j in unique_targets:
            mp[i][j] = 0

    for i in range(len(dataset[attr])):
        mp[dataset[attr][i]][dataset[target][i]] += 1

    for i in mp.keys():
        target_total = 0

        for j in mp[i].keys():
            target_total += mp[i][j]

        for j in mp[i].keys():
            if mp[i][j] != 0:
                info -= target_total / len(dataset[attr]) * mp[i][j] * np.log2(mp[i][j] / target_total) / target_total

    return info


# Function to calculate information gain for a given attribute
def getGain(dataset, attr, target):
    return getEntropy(dataset[target]) - getInfoForAttribute(dataset, attr, target)


# Function to find the best attribute with the highest information gain
def getBestAttr(dataset, target):
    gainArr = {attr: getGain(dataset, attr, target) for attr in dataset.keys() if attr != target}
    return max(gainArr, key=gainArr.get)


# ID3 Algorithm implementation
def ID3(dataset, attrs, target):
    # If all instances have same label
    if len(set(dataset[target])) == 1:
        return dataset[target][0]

    # Find the best attribute to split on
    best_attr = getBestAttr(dataset, target)

    # Create a new tree with the best attribute as the root
    tree = {best_attr: {}}

    # Remove the best attribute from the list of attributes
    rem_attr = [x for x in attrs if x != best_attr]

    # For each unique value of the best attribute, recursively call ID3
    for value in set(dataset[best_attr]):
        subset = {}
        for row in range(len(dataset[best_attr])):
            if dataset[best_attr][row] == value:
                for attr in rem_attr:
                    if attr in subset.keys():
                        subset[attr].append(dataset[attr][row])
                    else:
                        subset[attr] = [dataset[attr][row]]

        tree[best_attr][value] = ID3(subset, rem_attr, target)
    return tree


attributes = ['outlook', 'temperature', 'humidity', 'wind','answer']
label = 'answer'
print(ID3(data, attributes, label))
