#!/usr/bin/env julia

bus = map(s -> s == "x" ? missing : parse(Int, s), split(readlines(ARGS[1])[2], ','))
# println("bus=",bus)
# The earliest timestamp that matches the list 17,x,13,19 is 3417.
# 67,7,59,61 first occurs at timestamp 754018.
# 67,x,7,59,61 first occurs at timestamp 779210.
# 67,7,x,59,61 first occurs at timestamp 1261476.
# 1789,37,47,1889 first occurs at timestamp 1202161486.

# https://rosettacode.org/wiki/Chinese_remainder_theorem#Julia
function restesChinois(n::Array, a::Array)
    Π = prod(n)
    mod(sum(ai * invmod(Π ÷ ni, ni) * (Π ÷ ni) for (ni, ai) in zip(n, a)), Π)
end

# @show restesChinois([3, 5, 7], [2, 3, 2])

# bus=[67,7,59,61]
idx = findall(!ismissing, bus)
bus_sans_x = bus[idx]
minutes = idx .- 1
ecarts = []
for (k, b) in enumerate(bus_sans_x)
    push!(ecarts, b - minutes[k])
end
ecarts[1] = 0
# println("ecc=",ecarts)
# ecarts = [ 0, 7 - 1, 59 - 2, 61 - 3]
# println("eca=", ecarts)
# println("t2=",[754018%67,754018%7,754018%59,754018%61])

println(restesChinois(bus_sans_x, ecarts))
