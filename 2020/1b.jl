#!/usr/bin/env julia

entiers= parse.(Int, readlines(ARGS[1]))
for a in entiers
    for b in entiers
        for c in entiers
            if a+b+c == 2020
                println(a,',',b,',',c,':',a*b*c)
                return a*b*c
            end
        end
    end
end