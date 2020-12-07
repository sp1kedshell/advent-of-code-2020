import strutils
var f = open("data.txt")

var done = false
type indv_team = array[27, uint8]
var teams: seq[indvteam]
var data = ""
var team: indv_team
team[26] = 254
while(done != true):
    if readLine(f, data):
        if(data == ""):
            teams.add(team)
            for i in 0..len(team)-1:
                team[i] = uint8(0)
                team[26] = 254
        else:
            team[26] = team[26] - 1
            for i in data:
                team[int(i)-97] = team[int(i)-97] + uint8(1)
    else:
        teams.add(team)
        done = true
var count = 0
for team in teams:
    echo team
    for i in team:
        if(int(i) == 1):
            count = count + 1
echo "Part1: ", count

count = 0
for team in teams:
    for i in 0..26:
        var team_num = 254-team[26]
        if(team[i] == team_num):
            count = count + 1
echo "Part2: ", count