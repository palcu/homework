from mpmath import *

def f(x):
    return mpf(mpf(4) * (e ** (-x)) * sin(mpf(6) * x * sqrt(x)) - mpf(1/5))

def same_sign(a, b):
    return a * b > 0

INTERVALS = [[mpf(x*(1/4)), mpf((x+1)*(1/4))] for x in range(12)]
MAX_ITERATIONS = 10**5
EPSILON = mpf(10 ** (-13))
