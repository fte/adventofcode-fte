#!/usr/bin/env julia

mdp= readlines(ARGS[1])

global nbValid= 0

for l in mdp
    tmp= split(l)
    pos1= parse.(Int,split(tmp[1],'-')[1])
    pos2= parse.(Int,split(tmp[1],'-')[2])
    aiguille= chop(tmp[2])[1]
    meule= tmp[3]
    # println(pos1,' ',pos2, ' ',aiguille,' ', meule)
    # println(meule[pos1],' ',meule[pos2], ' ',aiguille,' ', meule)
    if (aiguille == meule[pos1])
        bPos1= true
    else 
        bPos1= false
    end
    if (aiguille == meule[pos2])
        bPos2= true
    else
        bPos2= false
    end 

    if (xor(bPos1, bPos2))
        # println(l)
        global nbValid+= 1
    end 
end
println(nbValid)