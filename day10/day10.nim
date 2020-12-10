import strutils, algorithm
var f = open("data_test.txt")

var line: string
var done = false

var adapters: seq[int]

##add wall
adapters.add(0)

while done == false:
    if(readLine(f, line)):
        adapters.add(parseInt(line))
    else:
        done = true

sort(adapters)
#add phone
adapters.add(adapters[len(adapters) - 1] + 3)

var one_count = 0
var three_count = 0

for i in 1..len(adapters)-1:
    if(adapters[i] - adapters[i-1] == 1):
        one_count = one_count + 1
    else:
        three_count = three_count + 1
echo "Part1: 1: ", one_count, " 3: ", three_count, " Mult: ", one_count * three_count

echo adapters

proc recurse(position: int): int = 
    var stop = false
    var combinations = 0
    var count = 1
    while stop == false:
        if(position + count >= len(adapters)-1):
            stop = true
            #found one combination
            combinations = combinations + 1
            break
        elif adapters[count + position] - adapters[position] > 3:
            stop = true
            break
        else:
            combinations = combinations + recurse(position + count)
            count = count + 1
    return combinations
echo "Part2 ", recurse(0)/2