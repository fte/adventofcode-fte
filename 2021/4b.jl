#!/usr/bin/env julia

puzzle = split(strip(read(ARGS[1], String), '\n'), "\n\n")
tirages = parse.(Int, split(puzzle[1], ","))

grilles = Matrix[]
for (x, i) in enumerate(puzzle[2:end])
    g = fill(0, (5, 5))
    for (n, k) in enumerate(split(i, "\n"))
        g[n, :] = parse.(Int, split(k))
    end
    push!(grilles, g)
end

# coché est -1, si somme = -5 , c'est B I N G O
function isBingo(grille)
    for r in eachrow(grille)
        if sum(r) == -5
            return true
        end
    end
    for r in eachcol(grille)
        if sum(r) == -5
            return true
        end
    end

    return false
end

function sommeNombresNonCochés(grille, tirage)
    somme = 0
    for i = 1:5
        for j = 1:5
            if -1 != grille[i, j]
                somme = somme + grille[i, j]
            end
        end
    end

    return somme
end

aGrillesAvecBingo = Int[]
aGrillesGagnantes = Int[]
for tirage in tirages, (i, grille) in enumerate(grilles)
    grille[grille.==tirage] .= -1
    if isBingo(grille) && i ∉ aGrillesAvecBingo
        push!(aGrillesAvecBingo, i)
        push!(aGrillesGagnantes, tirage * sommeNombresNonCochés(grille, tirage))
    end
end
@show aGrillesGagnantes[end]