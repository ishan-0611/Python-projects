import random
import string


def generate_password(min_length, numbers=True, special_chars=True):
    letters = string.ascii_letters
    digits = string.digits
    special = string.punctuation

    characters = letters
    if numbers:
        characters += digits
    if special_chars:
        characters += special

    pwd = ""
    meets_criteria = False
    has_number = False
    has_special = False

    while not meets_criteria or len(pwd) < min_length:
        new_char = random.choice(characters)
        pwd += new_char

        if new_char in digits:
            has_number = True
        elif new_char in special:
            has_special = True

        meets_criteria = True
        if numbers:
            meets_criteria = has_number
        if special_chars:
            meets_criteria = meets_criteria and has_special

    return pwd


length = int(input("Enter the minimum length : "))
numbers = int(input("Do you want to include numbers ? (0,1) :"))
specials = int(input("Do you want to include special characters ? (0,1) :"))

n = True if numbers == 1 else False
s = True if specials == 1 else False

password = generate_password(length, n, s)
print(password)
