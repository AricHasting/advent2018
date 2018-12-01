package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func main() {
	start := 0

	var sequence []int
	visited := make(map[int]bool)

	reader := bufio.NewScanner(os.Stdin)

	for reader.Scan() {
		change := reader.Text()
		c, err := strconv.Atoi(change)

		if err != nil {
			break
		}

		sequence = append(sequence, c)
	}

	for {
		for _, e := range sequence {
			start = start + e

			_, ok := visited[start]

			if ok {
				fmt.Println(start)
				return
			}

			visited[start] = true
		}
	}
}
