package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	file, err := os.Open("data.txt")
	if err != nil {
		fmt.Printf("Something went wrong: %s", err)
	}
	scanner := bufio.NewScanner(file)
	scanner.Split(bufio.ScanLines)
	var data []string

	for scanner.Scan() {
		data = append(data, scanner.Text())
	}

	count_valid := 0
	count_part2 := 0

	for x := range data {
		var splitdata = strings.Split(data[x], " ")
		password := splitdata[2]
		min, err := strconv.Atoi(strings.Split(splitdata[0], "-")[0])
		if err != nil {
			fmt.Printf("Error here %s", err)
		}
		max, err := strconv.Atoi(strings.Split(splitdata[0], "-")[1])
		if err != nil {
			fmt.Printf("error here: %s", err)
		}

		character := strings.Split(splitdata[1], ":")[0][0]

		//Part1
		count := 0

		for index := range password {
			if password[index] == character {
				count++
			}
		}
		if count >= min && count <= max {
			count_valid++
		}

		//Part2
		if len(password) >= max {
			//get around the lack of a boolean xor
			conditional1 := password[min-1] == character
			conditional2 := password[max-1] == character
			if (conditional1 && !conditional2) || (conditional2 && !conditional1) {
				count_part2++
			}
		}

	}
	fmt.Printf("Part1 Valid: %d, Part2 Valid: %d\n", count_valid, count_part2)

}