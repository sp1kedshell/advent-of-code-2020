import strutils, re
var f = open("data.txt")

let expectedFields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid", "cid"]
type individual_passport = array[len(expectedFields), string]
var passports: seq[individual_passport]

var temporary_passport: individual_passport

var done = false
var data = ""
while(done != true):
    if readLine(f, data):
        if(data == ""):
            passports.add(temporary_passport)
            for i in 0..len(expectedFields)-1:
                temporary_passport[i] = ""
        else:
            for i in data.split(" "):
                var entry = i.split(":")
                for i in 0..len(expectedFields)-1:
                    if(cmpIgnoreCase(expectedFields[i], entry[0]) == 0):
                        temporary_passport[i] = entry[1]
    else:
        passports.add(temporary_passport)
        done = true
var required_fields = [1, 1, 1, 1, 1, 1, 1, 0]

var valid_passports = 0

for passport in passports:
    var valid = true
    for i in 0..len(required_fields)-1:
        if(passport[i] == "" and required_fields[i] == 1):
            valid = false
    if(valid == true):
        valid_passports = valid_passports + 1
echo "Part 1: ",  valid_passports


## Part2
## Defining regexes
var regular_expression_dictionary = [
    #byr
    re"^19[2-9][0-9]|200[0-2]$", 
    #iyr
    re"^20[1][0-9]|2020$", 
    #eyr
    re"^20([2][0-9])|2030$", 
    #hgt
    re"^(1([5-8][0-9]|[9][0-3])cm)|((59|6[0-9]|7[0-6])in)$", 
    #hcl
    re"^#([\d(a-f)]){6}$", 
    #ecl
    re"^amb|blu|brn|gry|grn|hzl|oth$", 
    #pid
    re"^\d{9}$", 
    #cid
    re"^\S$"]

valid_passports = 0
for passport in passports:
    var valid_bool = true
    for i in 0..len(required_fields)-1:
        if(required_fields[i] == 1 and matchLen(passport[i], regular_expression_dictionary[i]) == -1):
            valid_bool = false
    if(valid_bool == true):
        valid_passports = valid_passports + 1
echo "Part 2: ", valid_passports