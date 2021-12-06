#!/usr/bin/env julia

p = split.(replace.(readlines(ARGS[1]), " -> " => ','), ',')
# @show p
c = fill(0, (991, 991)) # cat input5a.txt |sed "s/ \-> /,/"|tr "," "\n"|sort -nu|tail -n 1 : 990
# @info c
for ligne in p
    x1, y1, x2, y2 = map(x -> x + 1, parse.(Int, ligne)) # julia index à
    # @info x1, y1, x2, y2
    if x1 == x2
        # @show x1, y1, x2, y2
        if y1 > y2
            y1, y2 = y2, y1
        end
        # @show x1, y1, y2
        c[x1, y1:y2] .+= 1
    elseif y1 == y2
        if x1 > x2
            x1, x2 = x2, x1
        end
        # @show x1 x2, y1
        # @info c[x1:x2, y1]
        c[x1:x2, y1] .+= 1
        # @info c[x1:x2, y1]
    else
        continue
    end
end

@info sum(>=(2), c)
