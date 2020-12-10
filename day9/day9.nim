import strutils
var f = open("data.txt")

var numbers: seq[int]

var line: string
var done = false
while done == false:
    if(readLine(f, line)):
        numbers.add(parseInt(line))
    else:
        done = true

var part1_num: int
var part1_linenum: int
for number in 25..len(numbers)-1:
    var found = -9999
    for i in number-25..number:
        if(numbers[number-25..number].contains(numbers[number] - numbers[i])):
            found = i
    if(found == -9999):
        echo "Part1:", numbers[number], " line num: ", number
        part1_num = numbers[number]
        part1_linenum = number

var counter = 0
var part2_min = 0
var part2_max = 0
var found = false
for i in 0..part1_linenum:
    var total = 0
    done = false
    var count = -1
    while done == false:
        count = count + 1
        total = total + numbers[i+count]
        if(total > part1_num):
            done = true
            found = false
        elif(total == part1_num):
            echo total, " i: ", i, " max: ", count+i
            done = true
            found = true
            part2_min = i
            part2_max = count + i
            break
    if(found):
        break
echo "Part2: Min: ", part2_min, " Max: ", part2_max
echo "numbers min: ", numbers[part2_min], " max: ", numbers[part2_max]
var total = 0
var smallest = numbers[part2_min]
var largest = -2
for i in part2_min..part2_max:
    if(numbers[i]<smallest):
        smallest = numbers[i]
    if(numbers[i]>largest):
        largest = numbers[i]
    total = total + numbers[i]
echo "Numbers ", smallest, " + ", largest, " = ", largest + smallest