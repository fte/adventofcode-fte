#!/usr/bin/env julia

s = split(read(ARGS[1], String), "\n\n")
# println(s)
rules = Dict()
for rule in split(s[1], "\n")
    # println(rule)
    m = match(r"(?<field>[\w\s\w]+):\s+(?<r1>[\d\-]+) or (?<r2>[\d\-]+)", rule)
    rules[m[:field]] = (m[:r1], m[:r2])
end
# println(rules)

myticket = split(s[2], "\n")[2]
# println("mine=",myticket)

nearbytickets =  split.(split(s[3], "\n", keepempty=false)[2:end], ",")
# println("others=",nearbytickets)

notvalids = []
for ticket in nearbytickets
    # println(ticket)
    for val in ticket
        isValid = false
        val = parse(Int, val)
        # println(val, " ", typeof(val))
        for (field, field_rules) in rules
            # println(field_rules)
            range1 = parse.(Int, split(field_rules[1], '-'))
            range2 = parse.(Int, split(field_rules[2], '-'))
            # println(field, " ", range1[1], ">= ", val, " <=", range1[2])
            
            if range1[1] ≤ val ≤ range1[2]
                isValid |= true
            end
            # println("\t", val, " ", isValid)
            # println(field, " ", range2[1], "≥ ", val, " ≤", range2[2])
            if range2[1] ≤ val ≤ range2[2]
                isValid |= true
            end

            # println("\t", val, " ", isValid)
        end
        if ! isValid 
            # println("val=", val, " valid")
        # else
            # println("val=", val, " not valid")
            push!(notvalids, val)
        end
    end
end
# println(notvalids)
println(sum(notvalids))