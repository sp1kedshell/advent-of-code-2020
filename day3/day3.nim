import strutils
let dataFile = readFile("data.txt")
let data = dataFile.split({'\n', ','})

var landscape: array[323, array[32,uint8]]
var slopeinstructions: array[5, array[2, int]]
var results: array[5, int]

var linecount = 0
for line in data:
    var horizontal_layer: array[32, uint8]
    var position = 0
    for item in line:
        if(item == '.'):
            horizontal_layer[position] = uint8(0)
        else:
            horizontal_layer[position] = uint8(1)
        position = position + 1
    landscape[linecount] = horizontal_layer
    linecount = linecount + 1


var current_x = -3
var tree_count = 0
for y in landscape:
    current_x = (current_x + 3) mod 31
    if y[current_x] == uint8(1):
        tree_count = tree_count+1
echo "Tree count:", tree_count

slopeinstructions[0] = [1, 1]
slopeinstructions[1] = [3,1]
slopeinstructions[2] = [5,1]
slopeinstructions[3] = [7,1]
slopeinstructions[4] = [1,2]

#part2
for i in 0..len(slopeinstructions)-1:
    var current_x = 0
    var current_y = 0
    var done = false
    tree_count = 0
    while done != true:
        current_x = (current_x + slopeinstructions[i][0]) mod 31
        current_y = (current_y) + slopeinstructions[i][1]
        if(current_y >= len(landscape)):
            done = true
            break
        elif(landscape[current_y][current_x] == uint8(1)):
            tree_count = tree_count + 1
    results[i] = tree_count

var part2_tree_count = results[0] * results[1] * results[2] * results[3] * results[4]
echo "Part2 Multiplicated Result: ", part2_tree_count