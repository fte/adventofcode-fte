#!/usr/bin/env julia

puzzle = readlines(ARGS[1])

oxygen = deepcopy(puzzle)
co2 = deepcopy(puzzle)
iMot = length(puzzle[1])

oxygen_rating = co2_rating = 0

# oxy
for col = 1:iMot
    nU = nZ = 0
    for line in oxygen
        if line[col] == '1'
            nU += 1
        else
            nZ += 1
        end
    end
    # println("col=", col, " nU=", nU, " nZ=", nZ)
    if nU >= nZ
        filter!(p -> p[col] == '1', oxygen)
    else
        filter!(p -> p[col] == '0', oxygen)
    end
    # println(col, " oxy=", oxygen)
    # println(col, " co2=", co2)
    if length(oxygen) == 1
        # println("oxygen: ", oxygen)
        global oxygen_rating = oxygen[1]
        # println("oxygen_rating: ", oxygen_rating)
        break
    end
end

# co2
for col = 1:iMot
    nU = nZ = 0
    for line in co2
        if line[col] == '1'
            nU += 1
        else
            nZ += 1
        end
    end
    if nU >= nZ
        filter!(p -> p[col] == '0', co2)
    else
        filter!(p -> p[col] == '1', co2)
    end
    if length(co2) == 1
        # println("co2: ", co2)
        global co2_rating = co2[1]
        # println("co2_rating: ", co2_rating)
        break
    end
end

println(parse(Int, join(oxygen_rating); base = 2) * parse(Int, join(co2_rating); base = 2))

