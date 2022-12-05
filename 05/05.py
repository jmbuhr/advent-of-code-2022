import re

#%%
def parse_header(ls: list[str]) -> list[list[str]]:
    last = ls.pop()
    n = len(last.split())
    chunksize = len(last) // n
    pattern = re.compile(r"\[(\w)\]")
    stacks = [[] for _ in range(n)]
    for l in ls:
        res = pattern.finditer(l)
        for match in res:
            c = match.group(1)
            i = match.start() // chunksize
            stacks[i].append(c)

    for s in stacks:
        s.reverse()

    return stacks 

def execute_line(stacks, l: str):
    [n, f, t] = [int(x) for x in l.split()[1::2]]
    for _ in range(n):
        stacks[t-1].append(stacks[f-1].pop())

def execute_line2(stacks, l: str):
    [n, f, t] = [int(x) for x in l.split()[1::2]]
    v = stacks[f-1][-n:]
    stacks[t-1].extend(v)
    del stacks[f-1][-n:]

#%%

#%%
def main():
    with open("./input.dat") as f:
        header = []
        l = f.readline()
        while l != "\n":
            header.append(l)
            l = f.readline()
        stacks = parse_header(header)
        for l in f:
            execute_line(stacks, l)

        print("".join([x.pop() for x in stacks]))


def main2():
    with open("./input.dat") as f:
        header = []
        l = f.readline()
        while l != "\n":
            header.append(l)
            l = f.readline()
        stacks = parse_header(header)
        for l in f:
            execute_line2(stacks, l)

        print("".join([x.pop() for x in stacks]))


if __name__ == "__main__":
    main2()
