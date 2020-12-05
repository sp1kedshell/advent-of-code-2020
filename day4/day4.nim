var f = open("data.txt")

var expectedFields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid", "cid"]
var passports: seq[array[len(expectedFields)], string]

passports = expectedFields
var done = false
var data = f.readLine()
while(done != true):
    if readLine(f, data):
        if(data == ""):
            echo "Thing happened"
    else:
        done = true