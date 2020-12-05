#!/usr/bin/env julia

codes = readlines(ARGS[1])
# code= "FFFBBBFRRR"
trads = Dict('F' => '0', 'B' => '1', 'R' => '1', 'L' => '0')
max = 0
sieges_attribues = Int[]
for code in codes
    bin = join([trads[c] for c in code])
    dec = parse(Int, bin; base=2)
    push!(sieges_attribues, dec)
    if (dec > max)
        global max = dec
    end
end
# println(max)
# println(typeof(sieges_attribues))
for siege = 1:max

    place_avant = findfirst(x -> x == siege - 1, sieges_attribues)
    place = findfirst(x -> x == siege, sieges_attribues)
    place_apres = findfirst(x -> x == siege + 1, sieges_attribues)
    if (nothing == place && place_avant !== nothing && place_apres !== nothing)
        # println(siege-1,' ',siege,' ',siege+1)
        # show(place_avant)
        # show(place)
        # show(place_apres)
        println(siege)
        return 
    end
end