#!/usr/bin/env julia

reponses = split(read(ARGS[1], String), "\n\n")

global total = 0 
for groupe in reponses
    aGrp = collect(replace(groupe, "\n" => ""))
    global total += length(unique(aGrp))
end
println(total)