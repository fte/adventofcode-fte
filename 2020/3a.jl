#!/usr/bin/env julia

area= readlines(ARGS[1])

# println(area[1][2])

max_y= length(area)
max_x= length(area[1])

# println(max_x,'x', max_y)
global x= 1
global y= 1
global nbTrees= 0
while y < max_y
    global x+= 3
    global y+= 1
    if (x > max_x)
        x-= max_x
    end
    if ('#' == area[y][x])
        global nbTrees+= 1
    end
end
println(nbTrees)