#!/usr/bin/env julia

puzzle = readlines(ARGS[1])

hpos = 0
vpos = 0
aim = 0
for l in puzzle
    tmp = split(l)
    steps = parse.(Int, tmp[2])
    dir = tmp[1]

    if dir == "forward"
        global hpos += steps
        global vpos += aim * steps
    elseif dir == "up"
        global aim -= steps
    elseif dir == "down"
        global aim += steps
    else
        println(dir)
    end
    # println(hpos,' ', vpos)
end
println(hpos * vpos)