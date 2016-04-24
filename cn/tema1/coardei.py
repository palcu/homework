from common import f, INTERVALS, MAX_ITERATIONS, EPSILON, same_sign
from decimal import *

getcontext().prec = 340

def get_root(interval):
    c, x = interval
    old_x = x
    step = 0
    while step < MAX_ITERATIONS:
        step += 1
        x = (c * f(x) - x * f(c)) / (f(x) - f(c))
        if abs(f(x)) < EPSILON or abs(x - old_x) < EPSILON:
            return x
        old_x = x

def correct_interval(interval):
    return not same_sign(f(interval[0]), f(interval[1]))

for interval in INTERVALS:
    if correct_interval(interval):
        root = get_root(interval)
        print(Decimal(root))
