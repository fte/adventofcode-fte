#!/usr/bin/env julia

using LightGraphs
using GraphPlot

map_raw= readlines(ARGS[1])

objects_raw= String[]
for orbit_raw in map_raw
    object1, object2= split(orbit_raw,')')
    push!(objects_raw,object1)
    push!(objects_raw,object2)
end
objects= unique(objects_raw)
g= SimpleDiGraph(length(objects))

for orbit_raw in map_raw
    obj1, obj2= split(orbit_raw,')')
    e1= findfirst(x -> x == obj2, objects)
    e2= findfirst(x -> x == obj1, objects)
    # println(objects[e1]," orbite directement autour de -> ",objects[e2])
    add_edge!(g, e1, e2)
end

global total= 0
for v in vertices(g)
    gdist= gdistances(g, v)
    dists= Int64[]
    for d in gdist
        if d < typemax(Int64)
            push!(dists, d)
        end
    end
    global total+= maximum(dists)
end
println(total)