package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"strconv"
	"strings"
)

func isHandOK(hand map[string]int) bool {
	maxByColor := map[string]int{
		"red":   12,
		"green": 13,
		"blue":  14,
	}
	for maxcolor, maxnumber := range maxByColor {
		if hand[maxcolor] > maxnumber {
			return false
		}
	}
	// fmt.Println("\t\t", hand)
	return true
}

func getIdOk(str string) int {
	// var out bool

	fmt.Println(str)
	re := regexp.MustCompile(`(\d+): (.+)`)
	matches := re.FindStringSubmatch(str)
	// fmt.Printf("%+v\n", matches)
	// fmt.Println("\tmatches", matches)
	id, err := strconv.Atoi(matches[1])
	if err != nil {
		panic("Could not convert id to int")
	}
	// fmt.Println("\t", id)
	for _, partie := range strings.Split(matches[2], ";") {
		partie = strings.TrimSpace(partie)
		// fmt.Println("\tpartie", partie)
		numByColor := make(map[string]int)
		for _, hand := range strings.Split(partie, ",") {
			hand = strings.TrimSpace(hand)
			re := regexp.MustCompile(`(\d+) (\w+)`)
			m := re.FindStringSubmatch(hand)
			// numByColor[m[2]] = int(m[1])
			num, err := strconv.Atoi(m[1])
			if err != nil {
				fmt.Println("Erreur de conversion en entier :", err)
				// return
			}
			numByColor[m[2]] = num
		}
		// fmt.Println("\tnumByColor", numByColor)
		if !isHandOK(numByColor) {
			return 0
		}
	}

	return id
}

func main() {
	// file, err := os.Open("input1a.test.txt")
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
		res := getIdOk(line)
		fmt.Println("id?", res)
		somme = somme + res
	}
	fmt.Println("resultat", somme)

	if err := scanner.Err(); err != nil {
		fmt.Println("Erreur lors de la lecture du fichier :", err)
	}
}
