from common import f, INTERVALS, MAX_ITERATIONS, EPSILON, same_sign
from math import e, sqrt, sin, cos

getcontext().prec = 40000

def fderiv(x):
    return 36 * e**(-x) * sqrt(x) * cos(6 * x**(3/2))- 4 * e**(-x) * sin(6 * x**(3/2))

def get_root(interval):
    x_n = (interval[0] + interval[1]) / 2

    step = 0
    while step < MAX_ITERATIONS:
        step += 1

        x_n_plus_1 = x_n - f(x_n) / fderiv(x_n)

        if x_n_plus_1 < interval[0] or interval[1]  < x_n_plus_1:
            print("wtf", x_n_plus_1, interval)

        if abs(f(x_n_plus_1)) < EPSILON:
            return x_n_plus_1

        x_n = x_n_plus_1

def correct_interval(interval):
    return not same_sign(f(interval[0]), f(interval[1]))

for interval in INTERVALS:
    if correct_interval(interval):
        print(interval, get_root(interval))
