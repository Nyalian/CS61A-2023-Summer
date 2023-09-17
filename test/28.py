import pickle

class Link:
    empty = ()

    def __init__(self, first, rest=empty):
        self.first = first
        self.rest = rest

    def __repr__(self):
        if self.rest:
            rest = ', ' + repr(self.rest)
        else:
            rest = ''
        return 'Link('+repr(self.first)+rest+')'

    def __str__(self):
        string = '<'
        while self.rest is not Link.empty:
            string += str(self.first) + ' '
            self = self.rest
        return string + str(self.first) + '>'

class Test(object):
    def __init__(self, file_path="test1234567890.txt"):
        
        self._file_name_we_opened = file_path

        # An open file in write mode
        self.some_file_i_have_opened = open(file_path, 'wb')

    def __reduce__(self):
        # we return a tuple of class_name to call,
        # and optional parameters to pass when re-creating
        return (self.__class__, (self._file_name_we_opened, ))


my_test = Test()


