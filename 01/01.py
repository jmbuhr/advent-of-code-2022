#%%

def main():
    max = 0
    with open('input/01', 'r') as f:
        running = 0
        for l in f:
            if l != '\n':
                running += int(l)
            else:
                if running > max:
                    max = running
                running = 0
    print(max)

def mainb():
    elves = []
    with open('input/01', 'r') as f:
        running = 0
        for l in f:
            if l != '\n':
                running += int(l)
            else:
                elves.append(running)
                running = 0

    elves.sort(reverse=True)
    print(sum(elves[:3]))

def mainb2():
    top_elves = [0] * 3
    with open('input/01', 'r') as f:
        running = 0
        for l in f:
            if l != '\n':
                running += int(l)
            else:
                if running > top_elves[0]:
                    top_elves[0] = running
                    top_elves.sort()
                running = 0

    print(sum(top_elves))

#%%
if __name__ == "__main__":
    mainb2()

