# Trees

def tree(label, branches=[]):
    for branch in branches:
        assert is_tree(branch), 'branches must be trees'
    return [label] + list(branches)

def label(tree):
    return tree[0]

def branches(tree):
    return tree[1:]

def is_tree(tree):
    if type(tree) != list or len(tree) < 1:
        return False
    for branch in branches(tree):
        if not is_tree(branch):
            return False
    return True

def is_leaf(tree):
    return not branches(tree)

### +++ === ABSTRACTION BARRIER === +++ ###

def exponential_tree(n):
    """
    >>> exponential_tree(2)
    [2, [1, [0], [0]], [1, [0], [0]]]
    >>> exponential_tree(3)
    [3, [2, [1, [0], [0]], [1, [0], [0]]], [2, [1, [0], [0]], [1, [0], [0]]]]
    """
    if n == 0:
        return tree(0)
    left, right = exponential_tree(n-1), exponential_tree(n-1)
    return tree(n, [left,right])


def count_leaves(t):
    """The number of leaves in tree.

    >>> count_leaves(fib_tree(5))
    8
    """
    if is_leaf(t):
        return 1
    else:
        return sum([count_leaves(b) for b in branches(t)])

def leaves(tree):
    """Return a list containing the leaf labels of tree.

    >>> leaves(fib_tree(5))
    [1, 0, 1, 0, 1, 1, 0, 1]
    """
    if is_leaf(tree):
        return [label(tree)]
    else:
        return sum([leaves(b) for b in branches(tree)], [])

def print_tree(t, indent=0):
    """Print a representation of this tree in which each label is
    indented by two spaces times its depth from the root.

    >>> print_tree(tree(1))
    1
    >>> print_tree(tree(1, [tree(2)]))
    1
      2
    >>> print_tree(fib_tree(4))
    3
      1
        0
        1
      2
        1
        1
          0
          1
    """
    print('  ' * indent + str(label(t)))
    for b in branches(t):
        print_tree(b, indent + 1)

def tree_to_string(t):
    """
    >>> tree_to_string(tree(1, [tree(2), tree(3), tree(4)]))
    'tree(1, [tree(2)])'
    >>> tree_to_string(tree(1, [tree(2), tree(3), tree(4)]))
    'tree(1, [tree(2), tree(3), tree(4)])'
    """
    if is_leaf(t):
        return 'tree(' + str(label(t)) + ')'
    bs = ''
    for b in branches(t)[:-1]:
        bs += tree_to_string(b) + ', '
    bs += tree_to_string(branches(t)[-1])
    return 'tree(' + str(label(t)) + ', ' + '[' + bs + '])'


def increment_leaves(t):
    """Return a tree like t but with leaf labels incremented.
    
    
    >>> print_tree(increment_leaves(fib_tree(4)))
    3
      1
        1
        2
      2
        2
        1
          1
          2
    """
    if is_leaf(t):
        return tree(label(t) + 1)
    else:
        bs = [increment_leaves(b) for b in branches(t)]
        return tree(label(t), bs)

def increment(t):
    """Return a tree like t but with all labels incremented.
    
    >>> print_tree(increment(fib_tree(4)))
    4
      2
        1
        2
      3
        2
        2
          1
          2
    """
    return tree(label(t) + 1, [increment(b) for b in branches(t)])

# double
def double(t):
    """Returns a tree identical to T, but with all
    labels doubled
    >>> t = tree(1, [tree(2), tree(3)])
    >>> double(t)
    [2, [4], [6]]
    """
    return tree(label(t) * 2,
        [double(b) for b in branches(t)])

# Order

def fact(n):
    """Return n * n-1 * ... * 1.

    >>> fact(4)
    24
    """
    if n == 0:
        return 1
    else:
        return n * fact(n - 1)

def fact_tail(n):
    """Return n * n-1 * ... * 1.

    >>> fact_tail(4)
    24
    """
    return fact_times(n, 1)

def fact_times(n, k):
    """Return k * n * n-1 * ... * 1.

    >>> fact_times(4, 3)
    72
    """
    if n == 0:
        return k
    else:
        return fact_times(n - 1, k * n)

haste = tree('h', [tree('a', [tree('s'), tree('t')]), tree('e')])

def print_sums(t, path_sum):
    """Print the sum of labels along the path from the root to each leaf.

    >>> print_sums(tree(3, [tree(4), tree(5, [tree(6)])]), 0)
    7
    14
    >>> print_sums(haste, '')
    has
    hat
    he
    """
    path_sum = path_sum + label(t)
    if is_leaf(t):
        print(path_sum)
    else:
        for branch in branches(t):
            print_sums(branch, path_sum)

def count_paths(t, total):
    """Return the number of paths from the root to any node in t 
    for which the labels along the path sum to total.

    >>> t = tree(3, [tree(-1), tree(1, [tree(2, [tree(1)]), tree(3)]), tree(1, [tree(-1)])])
    >>> print_tree(t) 
    3
      -1
      1
        2
          1
        3
      1
        -1
    >>> count_paths(t, 3)
    2
    >>> count_paths(t, 4)
    2
    >>> count_paths(t, 5)
    0
    >>> count_paths(t, 6)
    1
    >>> count_paths(t, 7)
    2
    """
    if label(t) == total:
        found = 1
    else:
        found = 0
    return found + sum([count_paths(b, total - label(t)) for b in branches(t)])

def fib_tree(n):
    """Construct a Fibonacci tree.

    >>> fib_tree(1)
    [1]
    >>> fib_tree(3)
    [2, [1], [1, [0], [1]]]
    >>> fib_tree(5)
    [5, [2, [1], [1, [0], [1]]], [3, [1, [0], [1]], [2, [1], [1, [0], [1]]]]]
    """
    if n == 0 or n == 1:
        return tree(n)
    else:
        left = fib_tree(n-2)
        right = fib_tree(n-1)
        fib_n = label(left) + label(right)
        return tree(fib_n, [left, right])

# Memoization

def memo(f):
    """Memoize f.

    >>> def fib(n):
    ...     if n == 0 or n == 1:
    ...         return n
    ...     else:
    ...         return fib(n-2) + fib(n-1)
    >>> fib = count(fib)
    >>> fib(20)
    6765
    >>> fib.call_count
    21891
    >>> counted_fib = count(fib)
    >>> fib  = memo(counted_fib)
    >>> fib(20)
    6765
    >>> counted_fib.call_count
    21
    >>> fib(35)
    9227465
    >>> counted_fib.call_count
    36
    """
    cache = {}
    def memoized(n):
        if n not in cache:
            cache[n] = f(n)
        return cache[n]
    return memoized


# MEMOIZED FIB
cache = {}
def memoized_fib(n):
    if n in cache:
        return cache[n]
    if n <= 1:
        return n
    result = memoized_fib(n-1) + memoized_fib(n-2)
    cache[n] = result
    return result

# MEMOIZED FIB WITH DECORATOR

@memo
def fib(n):
    if n <= 1:
        return n
    return fib(n-1) + fib(n-2)
memo_fib = memo(fib)

