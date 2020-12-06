import strutils, algorithm
var data = readFile("data.txt").split("\n")

var seats: seq[int]
for pass in data:
    var pass_parsed = pass.replace("F", "0").replace("B","1").replace("L","0").replace("R","1")
    seats.add((fromBin[int](pass_parsed[0 .. 6]) * 8) + fromBin[int](pass_parsed[7 .. 9]))
echo "Part1: ", max(seats)
seats.sort()
for i in 0..len(seats)-2:
    if(seats[i+1] == seats[i]+2):
        echo "Part2: ", seats[i] + 1