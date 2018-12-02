package main

import (
	"bufio"
	"fmt"
	"os"
)

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	ids := make([]string, 0)

	for scanner.Scan() {
		ids = append(ids, scanner.Text())
	}

	for i := 0; i < len(ids); i++ {
		for j := i + 1; j < len(ids); j++ {

			a := ids[i]
			b := ids[j]

			if oneDifferent(a, b) {
				key := removeDifferent(a, b)
				fmt.Println(key)
			}
		}
	}
}

func oneDifferent(a, b string) bool {
	count := 0
	for i := range a {
		if a[i] != b[i] {
			count++
		}
		if count > 1 {
			return false
		}
	}
	if count == 1 {
		return true
	}

	return false
}

func removeDifferent(a, b string) string {
	copy := ""
	for i := range a {
		if a[i] == b[i] {
			copy = copy + string(a[i])
		}
	}
	return copy
}
