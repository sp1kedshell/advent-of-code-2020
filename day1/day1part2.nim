import strutils
# This is a comment

let dataFile = readFile("data.txt")
let data =  dataFile.split({'\n', ','})
for i in data:
    for y in data:
        for z in data:
            if(parseInt(i) + parseInt(y) + parseInt(z) == 2020):
                echo i , " " , y, " " , z
                echo "answer:", parseInt(i) * parseInt(y) * parseInt(z)