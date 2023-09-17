# Counting Calls
def count_calls(f):
    counter = [0]
    def counted(*args):
        counter[0] += 1
        return f(*args)
    def get_count():
        cc = counter[0]
        counter[0] = 0
        return cc
    return counted, get_count

def exp(b, n):
    if n == 0:
        return 1
    else:
        return b * exp(b, n-1)

exp, counter = count(exp)

# Memoization Revisited
cache = {}
def memo_fib(n):
    if n <= 1:
        return n
    if n not in cache:
        cache[n] = memo_fib(n-1) + memo_fib(n-2)
    return cache[n]

# Efficiency Practice
def never(n):
    """Logarithmic Growth."""
    if n == 0:
        return 0
    return 1 + never(n // 3)

def gonna(n):
    """Quadratic Growth."""
    total = 0
    for i in range(n):
        for j in range(i, n):
            total += 1
    return total

def let(n):
    """Exponential Growth."""
    for i in range(2 ** n):
        j = i
    for k in range(2 * n):
        j = k

def you(n):
    """Constant Growth."""
    for i in range(1975):
        n //= 2
    return n

def down(n):
    """Linear Growth."""
    lst = list(range(n))
    for i in range(n * 2002):
        print(i)
    for j in range(n // 81105):
        print(j)

# Space
def count_frames(f):
    def counted(n):
        counted.open_count += 1
        if counted.open_count > counted.max_count:
            counted.max_count = counted.open_count
        ret = f(n)
        counted.open_count -= 1
        return ret
    counted.open_count = counted.max_count = 0
    return counted

def vir_fib(n):
    if n == 0 or n == 1:
        return n
    return vir_fib(n - 2) + vir_fib(n - 1)
