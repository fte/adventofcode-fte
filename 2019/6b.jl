#!/usr/bin/env julia

using LightGraphs

map_raw= readlines(ARGS[1])

objects_raw= String[]
for orbit_raw in map_raw
    object1, object2= split(orbit_raw,')')
    push!(objects_raw,object1)
    push!(objects_raw,object2)
end
objects= unique(objects_raw)
# g= SimpleDiGraph(length(objects))
g= SimpleGraph(length(objects))

global pèrenoël,moi
for orbit_raw in map_raw
    obj1, obj2= split(orbit_raw,')')
    e1= findfirst(x -> x == obj2, objects)
    e2= findfirst(x -> x == obj1, objects)
    
    if obj2 == "YOU"
        global moi= e1
    end
    if obj2 == "SAN"
        global pèrenoël= e1
    end

    add_edge!(g, e1, e2)
end
mon_voisin= neighbors(g,moi)[1]
son_voisin= neighbors(g,pèrenoël)[1]
println("proche de moi ",objects[mon_voisin])
println("proche du pere noel ",objects[son_voisin])
o= a_star(g, mon_voisin, son_voisin)
println(length(o))