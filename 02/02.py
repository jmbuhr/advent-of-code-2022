#%%
from functools import total_ordering
from itertools import product

@total_ordering
class Shape():
    def __init__(self, s: str):
        match s:
            case 'X': s = 'A'
            case 'Y': s = 'B'
            case 'Z': s = 'C'
        self.shape = s

    def __eq__(self, other):
        return self.shape == other.shape

    def __lt__(self, other):
        match (self.shape, other.shape):
            case ('A', 'A'): return False
            case ('A', 'B'): return True
            case ('A', 'C'): return False
            case ('B', 'A'): return False
            case ('B', 'B'): return False
            case ('B', 'C'): return True
            case ('C', 'A'): return True
            case ('C', 'B'): return False
            case ('C', 'C'): return False

#%%
def shapes_to_score(one, two):
    one = Shape(one)
    two = Shape(two)
    match two.shape:
        case 'A':
            offset = 1
        case 'B':
            offset = 2
        case 'C':
            offset = 3
        case _:
            raise ValueError('This should not happen')
    if one == two:
        outcome = 3
    elif one > two:
        outcome = 0
    elif one < two:
        outcome = 6
    else:
        raise ValueError('Impossible comparison result')
    return offset + outcome


score_table  = {
        (one, two): shapes_to_score(one, two)
        for (one, two) in product(['A', 'B', 'C'], ['X', 'Y', 'Z'])
}

#%%

#%%
def main():
    score = 0
    # scores = []
    with open('./input.dat', 'r') as f:
        for l in f:
            key = tuple(l.split())
            score += score_table[key]
            # scores.append(score_table[key])
    print(score)


#%%
@total_ordering
class Shape():
    def __init__(self, s: str):
        match s:
            case 'X': s = 'A'
            case 'Y': s = 'B'
            case 'Z': s = 'C'
        self.shape = s

    def find_shape(self, outcome) -> Shape:
        match (self.shape, outcome):
            # x = loose
            # y = draw
            # z = win
            case ('A', 'X'): return Shape('C')
            case ('A', 'Y'): return Shape('A')
            case ('A', 'Z'): return Shape('B')
            case ('B', 'X'): return Shape('A')
            case ('B', 'Y'): return Shape('B')
            case ('B', 'Z'): return Shape('C')
            case ('C', 'X'): return Shape('B')
            case ('C', 'Y'): return Shape('C')
            case ('C', 'Z'): return Shape('A')

    def __eq__(self, other):
        return self.shape == other.shape

    def __lt__(self, other):
        match (self.shape, other.shape):
            case ('A', 'A'): return False
            case ('A', 'B'): return True
            case ('A', 'C'): return False
            case ('B', 'A'): return False
            case ('B', 'B'): return False
            case ('B', 'C'): return True
            case ('C', 'A'): return True
            case ('C', 'B'): return False
            case ('C', 'C'): return False

def line_to_score(one, outcome):
    one = Shape(one)
    two = one.find_shape(outcome)
    offset = 0
    match two.shape:
        case 'A':
            offset = 1
        case 'B':
            offset = 2
        case 'C':
            offset = 3
        case _:
            raise ValueError('This should not happen')
    match outcome:
        case 'X':
            return offset + 0
        case 'Y':
            return offset + 3
        case 'Z':
            return offset + 6
    raise AssertionError('We should not get here')

score_table2 = {
        (one, two): line_to_score(one, two)
        for (one, two) in product(['A', 'B', 'C'], ['X', 'Y', 'Z'])
}

def main2():
    score = 0
    with open('./input.dat', 'r') as f:
        for l in f:
            key = tuple(l.split())
            score += score_table2[key]
    print(score)

main2()

#%%
if __name__ == "__main__":
    main()

