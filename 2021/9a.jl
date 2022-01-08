#!/usr/bin/env julia

hm = [parse.(Int, split(line, "")) for line in readlines(ARGS[1])]
hm = hcat(hm...)
hm = pairs(hm)

global lowPoints = []

for (idx, val) in hm
    adjacents = []
    adj = []
    for d in [(0, +1), (-1, 0), (+1, 0), (0, -1)]
        push!(adj, Tuple(idx) .+ d)
    end
    for i in adj
        push!(adjacents, get(hm, i, 9))
    end
    if all(val .< adjacents)
        push!(lowPoints, idx)
    end
end
# @show lowPoints
somme = 0
for i in lowPoints
    global somme += hm[i] + 1
end
@show somme
