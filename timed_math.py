import random
import time

OPERATORS = ["+", "-", "*"]
MIN_OPERAND = int(input("Enter minimum operand  :"))
MAX_OPERAND = int(input("Enter maximum operand  :"))
TOTAL_PROBLEMS = 5


def generate_problem():
    left = random.randint(MIN_OPERAND, MAX_OPERAND)
    right = random.randint(MIN_OPERAND, MAX_OPERAND)
    operator = random.choice(OPERATORS)

    exp = str(left) + operator + str(right)
    ans = eval(exp)
    return exp, ans


wrong = 0

input("Press Enter to start !!!")
print("------------------------")

start_time = time.time()

for i in range(TOTAL_PROBLEMS):
    expr, answer = generate_problem()

    guess = input("Problem #" + str(i + 1) + ": " + expr + "=")
    if guess == str(answer):
        continue
    else:
        wrong += 1

end_time = time.time()
total_time = round(end_time - start_time)

print("------------------------")
print("Nice Work !!! You finished in :", total_time, " seconds !!!")
print(f"You got {5 - wrong} correct questions !!!")
