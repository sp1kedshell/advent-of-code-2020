import strutils
let data = readFile("data.txt").split("\n")

var count_valid = 0

for i in data:
    var z = i.split(" ")
    ##extract minimum and maximum character numbers
    let min = parseInt(z[0].split("-")[0])
    let max = parseInt(z[0].split("-")[1])

    let character = z[1].split(":")[0]

    var count: int
    count = 0

    for value in z[2]:
        if(value == character[0]):
            count = count+1
    if(count >= min and count <= max):
        count_valid = count_valid+1
echo count_valid


##part2
count_valid = 0
for i in data:
    var z = i.split(" ")
    var password = z[2]
    ##extract minimum and maximum character numbers
    let min = parseInt(z[0].split("-")[0])
    let max = parseInt(z[0].split("-")[1])

    let character = z[1].split(":")[0][0]
    
    if(len(password) >= max):
        if(password[min-1] == character xor password[max-1] == character):
            count_valid = count_valid+1

echo count_valid

