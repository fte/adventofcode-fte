package main

// Matrix
// "Let off some steam, Bennett."

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"strconv"
)

func main() {
	file, _ := os.Open("input3a.txt")
	defer file.Close()
	scanner := bufio.NewScanner(file)
	var somme int
	var y int
	dxmax := 140
	dymax := 140
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
	sNombre := ""
	iKeepNombre := false
	for y := range matrix {
		if len(sNombre) > 0 && iKeepNombre {
			nombre, _ := strconv.Atoi(sNombre)
			somme += nombre
			fmt.Println("sommexxxy", somme, "num", nombre)
			sNombre = ""
			iKeepNombre = false
		}
		for x := range matrix[y] {
			isChiffre, _ := regexp.Match(`\d`, []byte(matrix[x][y]))
			// fmt.Println(x, y, matrix[x][y], "isChiffre=", isChiffre)
			if !isChiffre {
				if iKeepNombre {
					nombre, _ := strconv.Atoi(sNombre)
					// fmt.Println(nombre)
					somme += nombre
					fmt.Println("sommexxx", somme, "num", nombre)
				}
				sNombre = ""
				iKeepNombre = false
				continue
			}
			// fmt.Println("x", x, "y", y, "char", matrix[x][y], "isChiffre", isChiffre)
			if isChiffre {
				sNombre += matrix[x][y]
				// fmt.Println("x", x, "y", y, "char", matrix[x][y], "isChiffre", isChiffre, "sNombre", sNombre)
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
