#!/usr/bin/env julia

cryptogramme = parse.(Int, eachline(ARGS[1]))
iPreamble = parse(Int, ARGS[2])

function sommes(numeros, diminuende)
    all_sommes = Set{Int}()
    for diminuteur in numeros
        difference = diminuende - diminuteur
        if difference in all_sommes
            return true
        end
        push!(all_sommes, diminuteur)
    end
    return false
end

function find_contiguous_set(cryptogramme, invalid_number)
    global i = 0
    while true
    # while i < 1
        i += 1
        for set_size in 2:length(cryptogramme)
            # println(cryptogramme[i:set_size])
            # cryptogramme[i:set_size] |> sum |> println
            if invalid_number == cryptogramme[i:set_size] |> sum
                return cryptogramme[i:set_size]
            end
        end
    end
end

for i in iPreamble + 1:length(cryptogramme)
    preamble_to_search = cryptogramme[i - iPreamble:i - 1]
    if ! sommes(preamble_to_search, cryptogramme[i]) 
        global invalid_number = cryptogramme[i]
        break
    end
end

# println(invalid_number)
s = find_contiguous_set(cryptogramme, invalid_number)
println(sum(extrema(s)))
