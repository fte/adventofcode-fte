package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"strconv"
	"strings"
)

func getPower(str string) int {
	// var out bool

	fmt.Println(str)
	re := regexp.MustCompile(`(\d+): (.+)`)
	matches := re.FindStringSubmatch(str)
	numByColor := make(map[string]int)
	for _, partie := range strings.Split(matches[2], ";") {
		partie = strings.TrimSpace(partie)
		for _, hand := range strings.Split(partie, ",") {
			hand = strings.TrimSpace(hand)
			re := regexp.MustCompile(`(\d+) (\w+)`)
			m := re.FindStringSubmatch(hand)
			num, err := strconv.Atoi(m[1])
			if err != nil {
				fmt.Println("Erreur de conversion en entier :", err)
			}
			if num > numByColor[m[2]] {
				numByColor[m[2]] = num
			}
		}
	}

	var pow int
	pow = 1
	for _, minnumber := range numByColor {
		pow *= minnumber
	}

	return pow
}

func main() {
	file, err := os.Open("input2a.txt")
	if err != nil {
		fmt.Println("Erreur lors de l'ouverture du fichier :", err)
		return
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)

	var somme int
	for scanner.Scan() {
		line := scanner.Text()
		res := getPower(line)
		fmt.Println("id?", res)
		somme = somme + res
	}
	fmt.Println("resultat", somme)

	if err := scanner.Err(); err != nil {
		fmt.Println("Erreur lors de la lecture du fichier :", err)
	}
}
