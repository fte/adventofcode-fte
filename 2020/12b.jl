#!/usr/bin/env julia

nav_inst = readlines(ARGS[1])

function getRotation(act, val)
    r = [0 -1; 1 0]
    if act == 'L'
        if val == 90
            return r
        elseif val == 180
            return r * r
        elseif val == 270 
            return -r
        end
    elseif act == 'R'
        if val == 90
            return -r
        elseif val == 180
            return r * r
        elseif val == 270 
            return r
        end
    end
end

cardinals = Dict(
    'N' => [0, 1], 'S' => [0, -1], 'E' => [1, 0], 'W' => [-1, 0]
)
pos = [0,0]
waypoint = [10,1]
for inst in nav_inst
    # println(inst)
    action = inst[1]
    value = parse(Int, inst[2:end])
    # println("action=", action, " value=", value)
    if 'F' == action 
        global pos += value * waypoint
    elseif 'R' == action || 'L' == action
        global waypoint = getRotation(action, value) * waypoint 
    else 
        global waypoint += cardinals[action] * value
    end

    # println("\tship=",pos)
    # println("\twp=",waypoint)
end
println(abs(pos[1]) + abs(pos[2]))