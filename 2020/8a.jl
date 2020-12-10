#!/usr/bin/env julia

bootcode = split.(readlines(ARGS[1]))

function execute(bootcode)
    accumulator = 0
    pointeur_instruction = 1 
    pile = Set() # pile des adresses des instructions deja executeesI
    while pointeur_instruction ∉ pile
        pi = pointeur_instruction
        push!(pile, pointeur_instruction)
    
        instruction, adresse = bootcode[pointeur_instruction]

        adresse = parse(Int, adresse)
        if "acc" == instruction
            pointeur_instruction += 1
            accumulator += adresse
        elseif "jmp" == instruction
            pointeur_instruction += adresse
        elseif "nop" == instruction
            pointeur_instruction += 1
        end
    end
    accumulator
end

println(execute(bootcode))