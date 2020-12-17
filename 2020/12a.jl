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

facing_dir = [1, 0] # east
cardinals = Dict(
    'N' => [0, 1], 'S' => [0, -1], 'E' => [1, 0], 'W' => [-1, 0]
)
pos = [0,0]
for inst in nav_inst
    # println(inst)
    action = inst[1]
    value = parse(Int, inst[2:end])
    # println("action=", action, " value=", value)
    if 'F' == action 
        global pos += value * facing_dir
    elseif 'R' == action || 'L' == action
        global facing_dir = getRotation(action, value) * facing_dir 
    else 
        global pos += cardinals[action] * value
    end

    # println(pos)
end
println(abs(pos[1]) + abs(pos[2]))

# println("R90 ", getRotation('R',90))
# println("R180 ", getRotation('R',180))
# println("L90 ", getRotation('R',90))
# println("L180 ", getRotation('L',180))
# println("L270 ", getRotation('L',270))