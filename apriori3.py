data = [
    ['T100', ['M', 'O', 'N', 'K', 'E', 'Y']],
    ['T200', ['D', 'O', 'N', 'K', 'E', 'Y']],
    ['T300', ['M', 'A', 'K', 'E']],
    ['T400', ['M', 'U', 'C', 'K', 'Y']],
    ['T500', ['C', 'O', 'K', 'I', 'E']]
]

min_sup = 2


def frequent_1_itemsets(dataset, mini_sup):
    item_counts = {}
    frequent_1 = []

    for transaction in dataset:
        for item in transaction[1]:
            if item in item_counts:
                item_counts[item] += 1
            else:
                item_counts[item] = 1

    for item, counts in item_counts.items():
        if counts >= mini_sup:
            frequent_1.append(item)

    return frequent_1


frequent_itemsets = frequent_1_itemsets(data, min_sup)
print("Frequent - 1 - itemsets : ", frequent_itemsets)
