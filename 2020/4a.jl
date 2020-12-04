#!/usr/bin/env julia

list = readlines(ARGS[1])

obligatoires = ["byr","iyr","eyr","hgt","hcl","ecl","pid"]

nbValids = 0

fields_pp = Dict()
for infos_pp in list
    if (infos_pp == "")
        # println("fin infos_pp", "\n")
        fields_presents = filter(x -> haskey(fields_pp, x), obligatoires)
        if (length(fields_presents) == 7)
            global nbValids += 1
        end 
        global fields_pp = Dict()
        continue
    end
    # println("\tinfos_pp=",infos_pp)
    ppfields = split(infos_pp)
    # println("\tppfields=",ppfields)
    cleval = map(x -> split(x, ':'), ppfields)
    # println("\tcleval=",cleval)
    for kv in cleval
        # println(kv)
        k, v = kv
        fields_pp[k] = v
    end
    # println(fields_pp)
end
# le dernier
# println(fields_pp)
fields_presents = filter(x -> haskey(fields_pp, x), obligatoires)
if (length(fields_presents) == 7)
    global nbValids += 1
end

println(nbValids)