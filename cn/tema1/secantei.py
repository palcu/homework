from common import f, INTERVALS, MAX_ITERATIONS, EPSILON, same_sign
from decimal import *

getcontext().prec = 40000

def get_root(interval):
    x_n_minus_1, x_n = interval
    x_n = x_n_minus_1 + 0.2 # fixes decimal stuff

    step = 0
    while step < MAX_ITERATIONS:
        step += 1

        x_n_plus_1 = ((x_n_minus_1) * f(x_n) - x_n * f(x_n_minus_1)) / (f(x_n) - f(x_n_minus_1))

        if x_n_plus_1 < interval[0] or interval[1]  < x_n_plus_1:
            print("wtf", x_n_plus_1, interval)

        if abs(f(x_n_plus_1)) < EPSILON:
            return x_n_plus_1

        x_n_minus_1 = x_n
        x_n = x_n_plus_1

def correct_interval(interval):
    return not same_sign(f(interval[0]), f(interval[1]))

for interval in INTERVALS:
    if correct_interval(interval):
        print(interval, Decimal(get_root(interval)))
