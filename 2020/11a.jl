#!/usr/bin/env julia

places = reduce(vcat, permutedims.(collect.(readlines(ARGS[1])))) # https://discourse.julialang.org/t/converting-a-array-of-strings-to-an-array-of-char/35123

# print area 10x10
function showArea(area)
    dimX, dimY = size(area)
    idX, idY = axes(area)
    for x in idX, y in idY
        # print(x, ":", y, "=")
        print(area[x,y])
        if y == dimY
            println()
        end
    end 
end

dimX, dimY = size(places)
# println(dimX,'x',dimY)
idX, idY = axes(places)
# showArea(places)
k = 0
while true
# for k in 1:3
    previous_area = deepcopy(places)
    # println(k, " sa=")
    # showArea(places)
    for x in idX, y in idY
        if places[x,y] == '.'
            continue
        end
        adjacents = [   (x - 1, y + 1), (x, y + 1), (x + 1, y + 1),
                        (x - 1, y), (x + 1, y),
                        (x - 1, y - 1), (x, y - 1), (x + 1, y - 1)]
                       
        adjacents_ok = []
        for ci in CartesianIndex.(adjacents)
            # println("b=", x, ':', y, " ", ci, "cb=", checkbounds(Bool, places, ci)) 
            checkbounds(Bool, previous_area, ci) && push!(adjacents_ok, previous_area[ci])
        end
        # if x == 10 && y == 10
        #     println(x, ":", y, " c=", places[x,y], " adj=", adjacents_ok, " n#=", count(x -> x == '#', adjacents_ok))
        # end

        if previous_area[x,y] == '#' && count(x -> x == '#', adjacents_ok) >= 4
            # println("libere=", x, ":", y, " c=", places[x,y], "pc=", previous_area[x,y], " adj=", adjacents_ok, " n#=", count(x -> x == '#', adjacents_ok))
            places[x,y] = 'L'
        end
        if previous_area[x,y] == 'L' && count(x -> x == '#', adjacents_ok) == 0
            places[x,y] = '#' 
        end 
    end
    if places == previous_area
        break
    end
    # println(k, " sa=")
    # showArea(places)
    # println()
end
println(count(x -> x == '#', places))