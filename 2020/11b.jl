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
idX, idY = axes(places)
# showArea(places)
k = 0
while true
    previous_area = deepcopy(places)
    # println(k, " sa=")
    # showArea(places)
    for x in idX, y in idY
        if places[x,y] == '.'
            continue
        end
        directions = [ CartesianIndex(x, y) for x in -1:1 for y in -1:1 if (x, y) != (0, 0) ]
        adjacents_ok = []

        for dir in directions
            ci = CartesianIndex(x, y) + dir
            # println("xy=",xy)
            while checkbounds(Bool, previous_area, ci) && previous_area[ci] == '.'
                ci += dir
            end
            checkbounds(Bool, previous_area, ci) && push!(adjacents_ok, previous_area[ci])
        end
        
        if previous_area[x,y] == '#' && count(x -> x == '#', adjacents_ok) >= 5
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