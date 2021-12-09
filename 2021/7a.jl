#!/usr/bin/env julia

crabs = parse.(Int, split(readline(ARGS[1]), ','))

# @show crabs

consos = Int64[]
for pos in crabs
    push!(consos, sum(x -> abs(x - pos), crabs))
end

@show min(consos...)
