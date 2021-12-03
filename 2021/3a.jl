#!/usr/bin/env julia

puzzle = readlines(ARGS[1])

epsilon_rate = String[]
gamma_rate = String[]
iMot = length(puzzle[1])

for col = 1:iMot
    nU = nZ = 0
    for line in puzzle
        # println(line[col])
        if line[col] == '1'
            nU += 1
        else
            nZ += 1
        end
    end
    # println(nU,' ', nZ)
    if nU >= nZ
        push!(epsilon_rate, "1")
        push!(gamma_rate, "0")
    else
        push!(epsilon_rate, "0")
        push!(gamma_rate, "1")
    end
end
println(parse(Int, join(epsilon_rate); base = 2) * parse(Int, join(gamma_rate); base = 2))