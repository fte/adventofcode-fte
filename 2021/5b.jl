#!/usr/bin/env julia

p = split.(replace.(readlines(ARGS[1]), " -> " => ','), ',')

if length(p) > 10
    c = fill(0, (991, 991))
else
    c = fill(0, (10, 10))
end

for ligne in p
    # @show ligne
    x1, y1, x2, y2 = map(x -> x + 1, parse.(Int, ligne)) # julia index à
    if x1 == x2
        if y1 > y2
            y1, y2 = y2, y1
        end
        # println("x=", x1, " de ", y1, " à ", y2)
        c[x1, y1:y2] .+= 1
    elseif y1 == y2
        if x1 > x2
            x1, x2 = x2, x1
        end
        # println("y=", y1, " de ", x1, " à ", x2)
        c[x1:x2, y1] .+= 1
    elseif abs(x1 - x2) == abs(y1 - y2)
        # elseif isdiag(c[x1:x2, y1:y2])
        # println("diago de ", x1, " ", x2, " à ", y1, " ", y2)
        if x1 > x2
            stepx = -1
        else
            stepx = 1
        end
        if y1 > y2
            stepy = -1
        else
            stepy = 1
        end

        c[x1, y1] += 1
        for i = 1:abs(x1 - x2)
            x1 += stepx
            y1 += stepy
            # @show x1, y1
            c[x1, y1] += 1
        end
    end
    # show(stdout, "text/plain", c')
    # name = readline()
end

# show(stdout, "text/plain", c')
println()
@info sum(>=(2), c)
