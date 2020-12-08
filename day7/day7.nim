import tables, strutils
var f = open("data.txt")

type Bag* = object 
    name: string
    containsStr: seq[string]
    containsNum: seq[int]
    hasChildren: bool

##initialize table
var hashtable: Table[string, Bag]

#proc garbagio_recursion(bag: string, count: int): int =
proc determineIfContainsShinyGold(bag: string): int = 
    var target =  "shiny gold bag"
    var count = 0
    var linecount = len(hashtable[bag].Bag.containsNum) - 1
    for i in 0..len((hashtable[bag].containsStr))-1:
        if(cmpIgnoreCase(hashtable[bag].Bag.containsStr[i], target) == 0):
            count = count + hashtable[bag].Bag.containsNum[i]
        else:
            count = count + determineIfContainsShinyGold(hashtable[bag].Bag.containsStr[i])
            continue
    return count
        
## get in all this horrid data
var done = false
var line: string
while done != true:
    if readLine(f, line):
        #initalize variable
        var current_bag: Bag
        ##get name
        var name = line.split("contain")[0].replace("bags", "bag")
        name = name[0..len(name)-2]
        var contained_bags = line.replace("bags", "bag").split("contain")[1]
        contained_bags = contained_bags[0..len(contained_bags)-2]
        current_bag.name = name
        ##no other bags
        if(cmpIgnoreCase(contained_bags, " no other bag") == 0):
            current_bag.hasChildren = false
        else:
            current_bag.hasChildren = true
            ##get contained bags
            var bags_string = contained_bags.split(",")
            for i in 0..len(bags_string)-1:
                bags_string[i] = bags_string[i][1..len(bags_string[i]) - 1].replace("bags", "bag")
            #add bag name
            for i in bags_string:
                current_bag.containsStr.add(i[2..len(i)-1].replace("bags", "bag"))
            for i in contained_bags.split(","):
                current_bag.containsNum.add(int(i[1]) - 48)
        hashtable.add(current_bag.name, current_bag)
    else:
        done = true

#for i in hashtable.keys():
#    echo "Name:", i, ":"
#    for z in 0..len(hashtable[i].Bag.containsStr)-1:
#        echo hashtable[i].Bag.containsStr[z], ": ",  hashtable[i].Bag.containsNum[z]

var part1_count = 0
for i in hashtable.keys():
    if hashtable[i].Bag.hasChildren == true and determineIfContainsShinyGold(i) != 0:
        part1_count = part1_count + 1

echo "Part1 Count: " , part1_count


##Part2: Find shiny gold boogaloo
proc findBagCountKillMeNow(bag: string): int = 
    var linecount = len(hashtable[bag].Bag.containsNum) - 1
    var count = 0
    for i in 0..len((hashtable[bag].containsStr))-1:
        count = count + (findBagCountKillMeNow(hashtable[bag].Bag.containsStr[i]) * hashtable[bag].Bag.containsNum[i]) + hashtable[bag].Bag.containsNum[i]
    return count

var target =  "shiny gold bag"
echo "Part2: ", findBagCountKillMeNow(target)