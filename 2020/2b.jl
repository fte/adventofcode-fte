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
    bPos2 = (aiguille == meule[pos1])
    bPos2 = (aiguille == meule[pos2])

    if (xor(bPos1, bPos2))
        # println(l)
        global nbValid+= 1
    end 
end
println(nbValid)