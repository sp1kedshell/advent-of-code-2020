import strutils
var f = open("data.txt")

var done = false
var line: string
var initial_table: seq[seq[int]]
while done == false:
    var parsed: seq[int]
    if(readLine(f, line)):
        for i in line:
            #empty
            if(i == 'L'):
                parsed.add(0)
            #floor
            elif(i=='.'):
                parsed.add(1)
            #occupied
            elif(i=='#'):
                parsed.add(2)
        initial_table.add(parsed)
    else:
        done = true

proc get_neighbors(table: seq[seq[int]], inputx: int, inputy: int): int =
    const x = [-1, 0, 1]
    const y = [-1, 0, 1]
    var neighbors = 0
    for x_point in x:
        if inputx + x_point >= len(table[0]) or inputx + x_point < 0:
            continue
        for y_point in y:
            if(x_point == 0 and y_point == 0):
                continue
            if(inputy + y_point >= len(table) or inputy+y_point < 0):
                continue
            if table[y_point + inputy][x_point + inputx] == 2:
                neighbors = neighbors + 1
    return neighbors

proc compareTable(table: seq[seq[int]], table2: seq[seq[int]]): bool =
    return table == table2

proc gameoflife(table: seq[seq[int]]): seq[seq[int]] = 
    var new_table = table
    for y in 0..len(table)-1:
        for x in 0..len(table[0])-1:
            var neighbors = get_neighbors(table, x, y)
            #if no neighbors and not floor, seat becomes occupied.
            if(table[y][x] == 0):
                if(neighbors == 0):
                    new_table[y][x] = 2
            elif(table[y][x] == 2):
                if(neighbors >= 4):
                    new_table[y][x] = 0
    return new_table
proc getOccupied(table: seq[seq[int]]): int = 
    var data = 0
    for y in table:
        for x in y:
            if x == 2:
                data = data + 1
    return data

#var table = gameoflife(initial_table)

done = false
var table = initial_table
while done == false:
    var table_new = gameoflife(table)
    if(compareTable(table, table_new)):
        done = true
    table = table_new

echo "Part1: Occupied: ", getOccupied(table)


proc check_occupied_count(table: seq[seq[int]], inputx: int, inputy: int): int =
    const x_coords = [-1, 0, 1]
    const y_coords = [-1, 0, 1]
    var neighbors = 0
    for y_offset in y_coords:
        for x_offset in x_coords:
            var done = false 
            if(x_offset == 0 and y_offset == 0):
                done = true
                continue
            var x = inputx
            var y = inputy
            while done == false:
                x = x + x_offset
                y = y + y_offset
                if(x >= len(table[0]) or y >= len(table) or y < 0 or x < 0):
                    done = true
                elif(table[y][x] == 0):
                    done = true
                    break
                else:
                    if(table[y][x] == 2):
                        neighbors = neighbors + 1
                        done = true
                        break
    return neighbors

proc gameoflifepart2electricboogaloo(table: seq[seq[int]]): seq[seq[int]] = 
    var new_table = table
    for y in 0..len(table)-1:
        for x in 0..len(table[0])-1:
            var neighbors = check_occupied_count(table, x, y)
            #if no neighbors and not floor, seat becomes occupied.
            if(table[y][x] == 0):
                if(neighbors == 0):
                    new_table[y][x] = 2
            elif(table[y][x] == 2):
                if(neighbors >= 5):
                    new_table[y][x] = 0
    return new_table

done = false
table = initial_table
while done == false:
    var table_new = gameoflifepart2electricboogaloo(table)
    if(compareTable(table, table_new)):
        done = true
        echo "Found duplicate table"
    table = table_new
    echo "Table: Occupancy:"
    for i in 0..len(table)-1:
        var occupied_points: seq[char]
        for point in 0..len(table[i]) - 1:
            if(table[i][point] == 2):
                occupied_points.add(char(check_occupied_count(table, i, point)+48))
            elif(table[i][point] == 1):
                occupied_points.add('.')
            else:
                occupied_points.add('L')
        echo occupied_points

echo "Part2: Occupied: ", getOccupied(table)
