data = {
    'outlook': ['sunny', 'sunny', 'overcast', 'rain'],
    'temperature': ['hot', 'hot', 'cool', 'mild'],
    'humidity': ['high', 'high', 'normal', 'high'],
    'wind': ['weak', 'strong', 'strong', 'weak'],
    'answer': ['no', 'no', 'yes', 'yes']
}


def classify(transaction):
    if transaction['outlook'] == 'overcast':
        return 'yes'
    elif transaction['outlook'] == 'sunny':
        if transaction['humidity'] == 'high':
            return 'no'
        else:
            return 'yes'
    elif transaction['outlook'] == 'rain':
        if transaction['wind'] == 'strong':
            return 'no'
        else:
            return 'yes'


def print_decision_tree():
    print("Decision Tree:")
    print("Root: Outlook")
    print("|__ Outlook = Overcast : Answer = Yes")
    print("|__ Outlook = Sunny")
    print("|   |__ Humidity = High : Answer = No")
    print("|   |__ Humidity = Normal : Answer = Yes")
    print("|__ Outlook = Rain")
    print("    |__ Wind = Strong : Answer = No")
    print("    |__ Wind = Weak : Answer = Yes")


user_input = {'outlook': input("Enter outlook (sunny, overcast, rain): ").strip().lower(),
              'temperature': input("Enter temperature (hot, mild, cool): ").strip().lower(),
              'humidity': input("Enter humidity (high, normal): ").strip().lower(),
              'wind': input("Enter wind (weak, strong): ").strip().lower()}

prediction = classify(user_input)
print("Prediction:", prediction)
print("-----------")
print_decision_tree()
