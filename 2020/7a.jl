#!/usr/bin/env julia

# merci https://tcuvelier.developpez.com/tutoriels/julia/introduction-lightgraphs-1.2/
using LightGraphs

bagspecs = readlines(ARGS[1])

g = SimpleDiGraph(length(bagspecs))

toutesLesCouleurs = [] #le graph ne travaille qu'avec des entiers, on a besoin d'un indice par couleur
for l in bagspecs
    contenant, contenus = split(l, " bags contain ")
    if contenant ∉ toutesLesCouleurs
        push!(toutesLesCouleurs, contenant)
    end
    # println(contenant, contenus)
    for contenu in split(contenus, ", ")
        # println(contenu)
        m = match(r"(?<nombre>[\d]+) (?<couleur>[\w\s]+) bag", contenu)
        # show(m)
        if (m !== nothing)
            if m[:couleur] ∉ toutesLesCouleurs
                push!(toutesLesCouleurs, m[:couleur])
            end
            add_edge!(g, findfirst(x -> x == m[:couleur], toutesLesCouleurs), findfirst(x -> x == contenant, toutesLesCouleurs))
        end
    end
end
# println(toutesLesCouleurs)

nbCouleurs = 0
iSg = findfirst(x -> x == "shiny gold", toutesLesCouleurs)
# println("iSg=",iSg)
# println("ntlc=",length(toutesLesCouleurs))
for i in keys(toutesLesCouleurs)
    if i == iSg
        continue
    end
    if has_path(g, iSg, i) # renvoi true si il a un chemin en iSg et i
        global nbCouleurs += 1
    end
end
println(nbCouleurs)