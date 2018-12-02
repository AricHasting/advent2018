package main

import (
	"bufio"
	"fmt"
	"os"
)

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	twoCount := 0
	threeCount := 0

	for scanner.Scan() {
		used := make(map[rune]int)

		two := false
		three := false

		for _, c := range scanner.Text() {
			if val, ok := used[c]; ok {
				used[c] = val + 1
			} else {
				used[c] = 1
			}
		}

		for _, v := range used {
			if v == 2 {
				two = true
			}
			if v == 3 {
				three = true
			}
		}

		if two {
			twoCount++
		}

		if three {
			threeCount++
		}
	}

	fmt.Println(twoCount * threeCount)
}
