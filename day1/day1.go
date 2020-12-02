package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func main() {
	file, err := os.Open("data.txt")
	if err != nil {
		fmt.Printf("Something went wrong: ", err)
	}
	scanner := bufio.NewScanner(file)
	scanner.Split(bufio.ScanLines)
	var numbers []int

	for scanner.Scan() {
		data, err := strconv.Atoi(scanner.Text())
		if err != nil {
			fmt.Printf("Something went wrong")
		}
		numbers = append(numbers, data)
	}

	for x := range numbers {
		for y := range numbers {
			if numbers[x]+numbers[y] == 2020 {
				fmt.Printf("x: %d, y: %d\n", numbers[x], numbers[y])
			}
		}
	}
	for x := range numbers {
		for y := range numbers {
			for z := range numbers {
				if numbers[x]+numbers[y]+numbers[z] == 2020 {
					fmt.Printf("x: %d, y: %d, z: %d\n", numbers[x], numbers[y], numbers[z])
				}
			}
		}
	}
}
