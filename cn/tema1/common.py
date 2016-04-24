from math import sin, sqrt, e

def f(x):
    return 4 * (e ** (-x)) * sin(6 * x * sqrt(x)) - 1/5

def same_sign(a, b):
    return a * b > 0

INTERVALS = [[x*(1/4), (x+1)*(1/4)] for x in range(12)]
MAX_ITERATIONS = 10**5
EPSILON = 10 ** (-13)
