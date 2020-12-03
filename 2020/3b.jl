#!/usr/bin/env julia

area= readlines(ARGS[1])

max_y= length(area)
max_x= length(area[1])

function doSlope(go_right,go_down)
    x = 1
    y = 1
    nbTrees= 0
    while y < max_y
        x+= go_right
        y+= go_down
        if (x > max_x)
            x-= max_x
        end
        if ('#' == area[y][x])
            nbTrees+= 1
        end
    end
    
    return nbTrees
end

println(doSlope(1,1)*doSlope(3,1)*doSlope(5,1)*doSlope(7,1)*doSlope(1,2))