x = 2
var = 5

def square(x):
    return x * x

square(var)


#check your understanding
from operator import pow

def pow(x, y):
    return x ** y
#overidden
def pow(x, z):
    return x ** z

def power_of_pow(x, y):
    return pow(pow(y, x), pow(x, y))

power_of_pow(2, 3)



#lambda expressions

def apply_func(f, x):
    return f(x)

apply_func(lambda x: x + 1, 5)


#check: lambda expressions

y = 6

def apply_func(f, x):
    return f(x + 2)(y)


apply_func(lambda x: lambda y: x + y + 1, 5)


#HOFs: lambda expressions vs. def statements

def square(x):
    return x * x

def apply_x_times(f, x, num):
    while x > 0:
        num = f(num)
        x = x - 1
    return num

apply_x_times(lambda y: y * y, 2, 5)

apply_x_times(square, 2, 5)

#currying

from operator import mul, add, pow, sub

def curry2(f):
    def h(x):
        def g(y):
            return f(x, y)
        return g
    return h


curry2(mul)(5)(3)
