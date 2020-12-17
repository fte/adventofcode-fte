#!/usr/bin/env julia

l = readlines(ARGS[1])
depart = parse(Int, l[1])
bus_brut = split(l[2], ',')
bus_id = findall(x -> x != "x", bus_brut)
bus = parse.(Int, bus_brut[bus_id])

# println("depart=",depart)
# println("map=", map(x -> ceil(depart / x) * x - depart, bus))
# println("cld=", cld.(depart,bus) )
# println("cld=", cld.(depart,bus) .* bus .- depart )
# println("fm=", findmin(cld.(depart,bus) .* bus .- depart ))
attente, bus_id = findmin(cld.(depart, bus) .* bus .- depart)
println(attente * bus[bus_id])