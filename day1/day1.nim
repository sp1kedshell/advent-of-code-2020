import strutils
# This is a comment

let dataFile = readFile("data.txt")
let data =  dataFile.split({'\n', ','})
for i in data:
    for y in data:
        if(parseInt(i) + parseInt(y) == 2020):
            echo i , " " , y
            echo "answer:", parseInt(i) * parseInt(y)