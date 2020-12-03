#!/usr/bin/env julia

mdp= readlines(ARGS[1])

global nbValid= 0
for l in mdp
    tmp= split(l)
    min= parse.(Int,split(tmp[1],'-')[1])
    max= parse.(Int,split(tmp[1],'-')[2])
    aiguille= chop(tmp[2])[1]
    meule= tmp[3]
    # println(min,' ',max, ' ',aiguille,' ', meule)
    count= 0
    for c in meule
        # println(typeof(c),' ',typeof(aiguille))
        # if (cmp(aiguille,parse.(String,c)))
        if (c == aiguille)
            # println(c, '=', aiguille)
            count+= 1
        end
    end

    if ( count >= min && count <= max)
        global nbValid+= 1
    end

end
println(nbValid)