#!/usr/bin/env julia

crabs = parse.(Int, split(readline(ARGS[1]), ','))

# @show crabs

consos = Int64[]
# pos = 5
for pos in minimum(crabs):maximum(crabs)
    # println(pos)
    push!(consos, sum(x -> sum(1:abs(x - pos)), crabs))
end
# println(consos)
@show min(consos...)
