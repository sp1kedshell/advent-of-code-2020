package main

import (
	"bufio"
	"fmt"
	"log"
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

	countpart1 := 0
	countpart2 := 0

	for x := range data {
		var splitdata = strings.Split(data[x], " ")
		password := splitdata[2]
		min, err := strconv.Atoi(strings.Split(splitdata[0], "-")[0])
		if err != nil {
			log.Fatalf("Error here %s", err)
		}
		max, err := strconv.Atoi(strings.Split(splitdata[0], "-")[1])
		if err != nil {
			log.Fatalf("error here: %s", err)
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
			countpart1++
		}

		//Part2
		if len(password) >= max {
			//get around the lack of a boolean xor
			conditional1 := password[min-1] == character
			conditional2 := password[max-1] == character
			if (conditional1 && !conditional2) || (conditional2 && !conditional1) {
				countpart2++
			}
		}

	}
	fmt.Printf("Part1 Valid: %d, Part2 Valid: %d\n", countpart1, countpart2)

}
