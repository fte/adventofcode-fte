package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"unicode"
)

// func convChiffresToInt()

func main() {
	// file, err := os.Open("input1a.test.txt")
	file, err := os.Open("input1a.txt")
	if err != nil {
		fmt.Println("Erreur lors de l'ouverture du fichier :", err)
		return
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)

	var somme int
	for scanner.Scan() {
		line := scanner.Text()
		// fmt.Println(line)
		var premierChiffre, dernierChiffre rune
		for _, char := range line {
			if unicode.IsDigit(char) {
				if premierChiffre == 0 {
					premierChiffre = char
				}
				dernierChiffre = char //remplacé jusqu'au dernier
			}
		}

		// fmt.Println(string(premierChiffre)+string(dernierChiffre))
		resultat, err := strconv.Atoi(string(premierChiffre) + string(dernierChiffre))
		if err != nil {
			fmt.Println("Erreur de conversion en entier :", err)
			return
		}
		somme = somme + resultat
		// fmt.Println("resultat",resultat)
		fmt.Println("resultat", somme)

	}

	if err := scanner.Err(); err != nil {
		fmt.Println("Erreur lors de la lecture du fichier :", err)
	}
}
