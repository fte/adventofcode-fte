package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
	"unicode"
)

func main() {
	// file, err := os.Open("input1a.test.txt")
	file, err := os.Open("input1a.txt")
	if err != nil {
		fmt.Println("Erreur lors de l'ouverture du fichier :", err)
		return
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)

	mapIntByStr := map[string]int{
		"zero":  0,
		"one":   1,
		"two":   2,
		"three": 3,
		"four":  4,
		"five":  5,
		"six":   6,
		"seven": 7,
		"eight": 8,
		"nine":  9,
	}
	var somme int
	for scanner.Scan() {
		line := scanner.Text()
		fmt.Println(line)
		var premierChiffre, dernierChiffre rune
		var sChiffre string
		premierChiffre = 0
		for _, char := range line {

			if unicode.IsDigit(char) {

				if premierChiffre == 0 {
					premierChiffre = char
				}
				dernierChiffre = char //remplacé jusqu'au dernier
				// fmt.Println("\tdigit=", string(char), "sChiffre=", sChiffre, "premierChiffre=", string(premierChiffre), "dernierChiffre=", string(dernierChiffre))
			} else {
				sChiffre += string(char)
				for sDigit, iDigit := range mapIntByStr {
					// fmt.Println("\tdigit=", sDigit, iDigit)
					if strings.Contains(sChiffre, sDigit) {
						if premierChiffre == 0 {
							premierChiffre = rune(iDigit + '0') // rune(res) doesn't work
						} else {
							dernierChiffre = rune(iDigit + '0')
						}
						// fmt.Println("\tMATCH char=", string(char), "sChiffre=", sChiffre, "premierChiffre=", string(premierChiffre), "dernierChiffre=", string(dernierChiffre))
						sChiffre = ""
					} else {
						// fmt.Println("\tNOMATCH char=", string(char), "sChiffre=", sChiffre, "premierChiffre=", string(premierChiffre), "dernierChiffre=", string(dernierChiffre))
					}
				}

			}
		}
		fmt.Println("\tpremierdernier=", string(premierChiffre), string(dernierChiffre))
		resultat, err := strconv.Atoi(string(premierChiffre) + string(dernierChiffre))
		if err != nil {
			fmt.Println("Erreur de conversion en entier :", err)
			return
		}
		somme = somme + resultat
		fmt.Println("resultat", resultat)
		fmt.Println("resultat", somme)
	}

	if err := scanner.Err(); err != nil {
		fmt.Println("Erreur lors de la lecture du fichier :", err)
	}
}
