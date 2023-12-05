package main

// Matrix
// "Let off some steam, Bennett."
// "Any carry-on luggage?" "Just him." "Open your mouth again and I'll nail it shut."
// "Don't break radio silence until they see me." "How will I know?" "Because all fucking hell is going to break loose."
// "Why don't they just call him Girl George? It would cut down on the confusion." "Oh, Dad, that is so old." "Ha Ha. You know when I was a boy and rock and roll came to East Germany, the communists said it was subversive. Maybe they were right."
// "This was the last time." "Until a next time." "No chance."
// "You steal my car, you rip the seat out, you kidnap me, you ask me to help you find your daughter which I very kindly do, and then you get me involved in a shoot out where people are dying and there's blood spurting all over the place, and then I watch you rip a phone booth out of a wall, swing from the ceiling like Tarzan, and then there's a cop that's going to shoot you and I save you and they start chasing me. Are you going to tell me what's going on or what?" "No." "No? NO!?"
// "Don't disturb my friend, he's dead tired."
// "We'll take Cooke's car. He won't be needing it."

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"strconv"
)

func main() {
	file, _ := os.Open("input3a.test.txt")
	defer file.Close()
	scanner := bufio.NewScanner(file)
	var somme int
	var y int
	dxmax := 10
	dymax := 10
	matrix := make([][]string, dymax)
	for i := range matrix {
		matrix[i] = make([]string, dxmax)
	}
	for scanner.Scan() {
		line := scanner.Text()
		for x := range matrix[y] {
			matrix[x][y] = string(line[x])
			// fmt.Print(string(line[x]))
		}
		// fmt.Println("")
		y += 1
	}
	dirs := [][]int{{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}}
	// fmt.Println(dirs)

	for y := range matrix {
		var sNombre string
		var iKeepNombre bool
		iKeepNombre = false
		for x := range matrix[y] {
			// fmt.Print(matrix[x][y])
			if "." == matrix[x][y] {
				if iKeepNombre {
					nombre, _ := strconv.Atoi(sNombre)
					// fmt.Println(nombre)
					somme += nombre
					fmt.Println("somme", somme, "num", nombre)
				}
				sNombre = ""
				iKeepNombre = false
				continue
			}
			isChiffre, _ := regexp.Match(`\d`, []byte(matrix[x][y]))
			if isChiffre {
				sNombre += matrix[x][y]
				for _, dxdy := range dirs {
					// fmt.Println("dx", dxdy[0], "dy", dxdy[1])
					nx := x + dxdy[0]
					ny := y + dxdy[1]
					if nx >= 0 && ny >= 0 && nx < dxmax && ny < dymax {
						isChiffreOrDot, _ := regexp.Match(`[\d\.]`, []byte(matrix[nx][ny]))
						// fmt.Println(isChiffreOrDot, matrix[nx][ny])
						if !isChiffreOrDot {
							iKeepNombre = true
							// fmt.Println("spe=", matrix[nx][ny], "keep=", iKeepNombre, "snb=", sNombre, "somme", somme)
							continue
						}

					}
				}
			}

		}
	}
	fmt.Println(somme)
}
