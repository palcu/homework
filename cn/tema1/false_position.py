from common import f, INTERVALS, MAX_ITERATIONS, EPSILON, same_sign
from decimal import *

def get_root(interval):
    a, b = interval
    old_c = 2**1000
    step = 0
    while step < MAX_ITERATIONS:
        step += 1
        c = (a*f(b)-b*f(a)) / (f(b) - f(a))
        if abs(f(c)) < EPSILON or abs(c-old_c) < EPSILON:
            return c
        if same_sign(f(c), f(a)):
            a = c
        else:
            b = c
        old_c = c

def correct_interval(interval):
    return not same_sign(f(interval[0]), f(interval[1]))

for interval in INTERVALS:
    if correct_interval(interval):
        print(Decimal(get_root(interval)))
