package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func main() {
	start := 0
	reader := bufio.NewScanner(os.Stdin)
	for reader.Scan() {
		change := reader.Text()

		c, err := strconv.Atoi(change)

		if err != nil {
			fmt.Println(start)
			return
		}

		start = start + c
	}

	fmt.Println(start)
}
