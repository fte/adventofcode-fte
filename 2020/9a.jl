#!/usr/bin/env julia

cryptogramme = parse.(Int, eachline(ARGS[1]))

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

iPreamble = 25
# iPreamble = 5
for i in iPreamble + 1:length(cryptogramme)
    preamble_to_search = cryptogramme[i - iPreamble:i - 1]
    if ! sommes(preamble_to_search, cryptogramme[i]) 
        println(cryptogramme[i])
        break
    end
end