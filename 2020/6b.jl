#!/usr/bin/env julia

reponses = split(chomp(read(ARGS[1], String)), "\n\n")
# println(reponses)

global total = 0 
a2z= "abcdefghijklmnopqrstuvwxyz"
for groupe in reponses
    aGrp = split(groupe, "\n")
    aGrp =  Array{Char,1}[collect(g) for g in aGrp]
    nbPersonnes = length(aGrp)
    for c in a2z
        nbLettre = count(i -> (i == c), groupe)	
        # println("grp=",groupe," lettre=",c," nbLettre=",nbLettre)
		if nbLettre == nbPersonnes
			global total += 1
		end
    end
end
println(total)