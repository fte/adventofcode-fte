#!/usr/bin/env julia

s = split(read(ARGS[1], String), "\n\n")

rules = Dict()
for rule in split(s[1], "\n")
    m = match(r"(?<field>[\w\s\w]+):\s+(?<r1>[\d\-]+) or (?<r2>[\d\-]+)", rule)
    rules[m[:field]] = (m[:r1], m[:r2])
end

myticket = split(s[2], "\n")[2]

nearbytickets =  split.(split(s[3], "\n", keepempty=false)[2:end], ",")

notvalids = []
for (nt, ticket) in enumerate(nearbytickets)
    for val in ticket
        isValid = false
        val = parse(Int, val)
        for (field, field_rules) in rules
            range1 = parse.(Int, split(field_rules[1], '-'))
            range2 = parse.(Int, split(field_rules[2], '-'))
            if range1[1] ≤ val ≤ range1[2]
                isValid |= true
            end
            if range2[1] ≤ val ≤ range2[2]
                isValid |= true
            end
        end
        if ! isValid 
            push!(notvalids, nt)
        end
    end
end
deleteat!(nearbytickets, notvalids)
# println(nearbytickets)

# filter!(p -> startswith(p.first, "departure"), rules)
# println(rules)


fieldsValid =  Dict()
for k in keys(rules)
    fieldsValid[k] = []
end 
# println(fieldsValid)
for nv in 1:length(nearbytickets[1])
    for ticket in nearbytickets
        # println(ticket[nv], " ", length(ticket))
        val = parse(Int, ticket[nv])
        
        for (field, field_rules) in rules
            isValid = false
            range1 = parse.(Int, split(field_rules[1], '-'))
            range2 = parse.(Int, split(field_rules[2], '-'))
            
            if range1[1] ≤ val ≤ range1[2]
                isValid |= true
            end
            if range2[1] ≤ val ≤ range2[2]
                isValid |= true
            end
            if isValid
                push!(fieldsValid[field], nv)
            end
        end

    end
end
# println(fieldsValid)
fieldsPos = Dict()
iTotalTickets = length(nearbytickets)
for (f, v) in fieldsValid
    d = Dict([(i, count(x -> x == i, v)) for i in v])
    for (i, v) in d
        if v < iTotalTickets
            delete!(d, i)
        end
    end
    # println(d, typeof(d))
    fieldsPos[f] = [(e) for e in keys(d)]
end
# @todo dinic,dinitz, maxflow algo 
# println(fieldsPos)
iTotalFields = length(rules)
fields = Dict()
posAttrib = []
while length(fields) < iTotalFields
# for a in 1:2
    for (f, positions) in fieldsPos
        filter!(x -> x ∉ posAttrib, positions)
        if length(positions) == 1
            # println(positions, ' ', typeof(positions), ' ', first(positions))
            fields[f] = first(positions)
            delete!(fieldsPos, f)
            push!(posAttrib, first(positions))
        end
    end
    # println(fields, ' ', length(fields), " ", iTotalFields, ' ', posAttrib)
end
# println(fields)
filter!(p -> startswith(p.first, "departure"), fields)
# println(fields)
mul = 1
# println(myticket)
for (p, n) in fields
    # println(split(myticket,',')[n])
    global mul *= parse(Int, split(myticket, ',')[n])
end
println(mul)
