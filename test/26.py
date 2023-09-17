import ast
import inspect
def two_of_three(i, j, k):
    """docstring
    """
    return "answer"

def two_of_three_syntax_check():
    """Check that your two_of_three code consists of nothing but a return statement.

    >>> # You aren't expected to understand the code of this test.
    >>> import inspect, ast
    >>> [type(x).__name__ for x in ast.parse(inspect.getsource(two_of_three)).body[0].body]
    ['Expr', 'Return']
    """
    # You don't need to edit this function. It's just here to check your work.
    return ast.parse(inspect.getsource(two_of_three)).body[0].body

# ========
# BNF
# ========
"""
?start : TERMINAL | ternary

?ternary : ternary " if " ternary " else " ternary | TERMINAL

TERMINAL : /(\d+)|True|False/
"""

# ========
# DISASSEMBLED INSTRUCTIONS
# ========
"""
0 LOAD_CONST               0 (2)
2 STORE_NAME               0 (x)
4 LOAD_NAME                0 (x)
6 LOAD_CONST               1 (4)
8 BINARY_ADD
10 POP_TOP
12 LOAD_CONST               2 (None)
"""


# ======
# STACK MACHINES
# ======
class Inst():
    def __init__(self, args, location):
        self.args = args
        self.location = location

    def dispatch(self, machine):
        pass

class LOAD_CONST_Inst(Inst):
    nargs = 2
    def dispatch(self, machine):
        machine.push(self.args[0])

class LOAD_NAME_Inst(Inst):
    nargs = 2
    # LOTS OF EXTRA DETAILS ABSTRACTED HERE
    def dispatch(self, machine):
        frame = machine.get_curr_frame()
        machine.push(frame.lookup(self.args[0]))

class STORE_NAME_Inst(Inst):
    nargs = 2
    # LOTS OF EXTRA DETAILS ABSTRACTED HERE
    def dispatch(self, machine):
        frame = machine.get_curr_frame()
        symbol = self.args[0]
        value = machine.pop()
        frame.bind(symbol, value)

class BINARY_ADD_Inst(Inst):
    nargs = 0
    def dispatch(self, machine):
        a = int(machine.pop())
        b = int(machine.pop())
        machine.push(a + b)

class POP_TOP_INST(Inst):
    nargs = 0
    def dispatch(self, machine):
        machine.pop()

class StackMachine():
    def __init__(self):
        self.stack = []
        self.curr_frame = Frame()

    def get_curr_frame(self):
        return self.curr_frame

    def push(self, item):
        self.stack.append(item)

    def pop(self):
        return self.stack.pop()

class Frame():
    def __init__(self):
        self.bindings = {}

    def bind(self, symbol, value):
        self.bindings[symbol] = value

    def lookup(self, symbol):
        return self.bindings[symbol]

inst_mappings = {
    "LOAD_CONST":LOAD_CONST_Inst,
    "LOAD_NAME":LOAD_NAME_Inst,
    "STORE_NAME":STORE_NAME_Inst,
    "BINARY_ADD":BINARY_ADD_Inst,
    "POP_TOP":POP_TOP_INST,
}


# IGNORE THIS. Reads instructions from instruction file
machine = StackMachine()
with open("instr.txt") as f:
    for line in f:
        components = line.split()
        inst_cls = inst_mappings[components[1]]
        location = components[0]
        arg1 = components[1 + inst_cls.nargs][1:-1]
        inst_cls([arg1], location).dispatch(machine)
        print(line)
        print(machine.stack)
