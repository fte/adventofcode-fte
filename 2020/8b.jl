#!/usr/bin/env julia

bootcode = split.(readlines(ARGS[1]))

function execute(bootcode)
    accumulator = 0
    pointeur_instruction = 1 
    pile = Set()
    # while true
    while pointeur_instruction ∉ pile
        push!(pile, pointeur_instruction)
    
        instruction, adresse = bootcode[pointeur_instruction]
        adresse = parse(Int, adresse)
        # println("\t", pointeur_instruction, ": ", instruction, "@", adresse)
        if "acc" == instruction
            pointeur_instruction += 1
            accumulator += adresse
        elseif "jmp" == instruction
            pointeur_instruction += adresse
        elseif "nop" == instruction
            pointeur_instruction += 1
        end

        # println("\tpi=", pointeur_instruction, " lbc=", length(bootcode))
        if pointeur_instruction > length(bootcode)
            # println("\texecute ok")
            return false, accumulator
        end
    end
    # println("\texecute infini")
    return true, accumulator
end

function bruteforce(bc)
    index_instruction_modif = 1
    ibc = length(bc)
    for index_instruction_modif in 1:ibc
        isInfiniteLoop = Nothing
        accu = 0
        # https://discourse.julialang.org/t/what-is-the-difference-between-copy-and-deepcopy/3918/2
        alter_bootcode = deepcopy(bc)
        # println(index_instruction_modif, ' ', bc)
        # println(index_instruction_modif, ' ', bootcode[index_instruction_modif][1])
        if "jmp" == alter_bootcode[index_instruction_modif][1]
            alter_bootcode[index_instruction_modif][1] = "nop"
            # println(index_instruction_modif, " jmp->nop ", alter_bootcode)
            isInfiniteLoop, accu = execute(alter_bootcode)
        elseif "nop" == alter_bootcode[index_instruction_modif][1]
            alter_bootcode[index_instruction_modif][1] = "jmp"
            # println(index_instruction_modif, " nop->jmp ", alter_bootcode)
            isInfiniteLoop, accu = execute(alter_bootcode)
        end
        # println("isInfiniteLoop=", isInfiniteLoop, " accu=", accu)
        index_instruction_modif += 1
        if isInfiniteLoop == false
            return accu
        end
    end
end

println(bruteforce(bootcode))