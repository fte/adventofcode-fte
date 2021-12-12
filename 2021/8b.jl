#!/usr/bin/env julia

puzzle = readlines(ARGS[1])

sum = 0
for line in puzzle
    w, d = split.(split(line, "| "))
    digits = Set.(d) # l'ordre dans un ensemble est sans importance
    wirings = Set.(w)

    lengths = length.(wirings)

    intToSegments = Dict{Int,Set{Char}}()
    # 1 4 7 8    
    intToSegments[1] = only(wirings[lengths.==2])
    intToSegments[4] = only(wirings[lengths.==4])
    intToSegments[7] = only(wirings[lengths.==3])
    intToSegments[8] = only(wirings[lengths.==7])

    # @show intToSegments
    # 0 6 9
    sixSegments = wirings[lengths.==6]
    intToSegments[9] = only(filter(x -> intToSegments[4] ⊆ x, sixSegments)) # 4 n'est que dans 9
    filter!(x -> x != intToSegments[9], sixSegments)
    intToSegments[0] = only(filter(x -> intToSegments[7] ⊆ x, sixSegments)) # 7 est dans 0 et 9 mais on l'a enlevé
    intToSegments[6] = first(filter(x -> x != intToSegments[0], sixSegments))

    # @show intToSegments

    # 2 3 5
    fiveSegments = wirings[lengths.==5]
    intToSegments[3] = only(filter(x -> intToSegments[1] ⊆ x, fiveSegments)) # 1 est dans 3
    intToSegments[5] = only(filter(x -> x ⊆ intToSegments[6], fiveSegments)) # 5 est dans 6
    intToSegments[2] = only(filter(x -> x != intToSegments[3] && x != intToSegments[5], fiveSegments))

    # @show intToSegments
    segmentsToint = Dict(b => a for (a, b) in intToSegments)
    
    global sum+= 1000*segmentsToint[digits[1]] + 100*segmentsToint[digits[2]] + 10*segmentsToint[digits[3]] + segmentsToint[digits[4]]
end
@info sum
