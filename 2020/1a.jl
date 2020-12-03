#!/usr/bin/env julia

entiers= parse.(Int, readlines(ARGS[1]))
for a in entiers
    for b in entiers
        if a+b == 2020
            println(a,',',b,':',a*b)
            return a*b
        end
    end
end