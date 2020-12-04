#!/usr/bin/env julia

list = readlines(ARGS[1])

function isPpValid(fields_pp)
    obligatoires = ["byr","iyr","eyr","hgt","hcl","ecl","pid"]

    fields_presents = filter(x -> haskey(fields_pp, x), obligatoires)
    bMandatFields = (length(fields_presents) == length(obligatoires))

    if (occursin(r"^\d{4}$", fields_pp["byr"]) 
        && parse(Int, fields_pp["byr"]) >= 1920
        && parse(Int, fields_pp["byr"]) <= 2002 ) 
        bByr = true
    else
        bByr = false
    end

    if (occursin(r"^\d{4}$", fields_pp["iyr"]) 
        && parse(Int, fields_pp["iyr"]) >= 2010
        && parse(Int, fields_pp["iyr"]) <= 2020 ) 
        bIyr = true
    else
        bIyr = false
    end

    if (occursin(r"^\d{4}$", fields_pp["eyr"]) 
        && parse(Int, fields_pp["eyr"]) >= 2020
        && parse(Int, fields_pp["eyr"]) <= 2030 ) 
        bEyr = true
    else
        bEyr = false
    end

    bPid=  occursin(r"^\d{9}$", fields_pp["pid"]) 

    # println(fields_pp["hcl"],' ', occursin(r"^#\w{6}$", fields_pp["hcl"]))
    bHcl= occursin(r"^#\w{6}$", fields_pp["hcl"]) 

    # println(fields_pp["ecl"], fields_pp["ecl"] in split("amb blu brn gry grn hzl oth"))
    bEcl = fields_pp["ecl"] in split("amb blu brn gry grn hzl oth")

    # return bMandatFields & bByr & bIyr & bEyr & bPid & bHcl & bEcl
    return bMandatFields & bByr & bIyr & bEyr & bPid & bHcl
end


nbValids = 0
fields_pp = Dict()
for infos_pp in list
    if (infos_pp == "")
        if (isPpValid(fields_pp))
            global nbValids += 1
        end
        global fields_pp = Dict()
        continue
    end
    ppfields = split(infos_pp)
    cleval = map(x -> split(x, ':'), ppfields)
    for kv in cleval
        k, v = kv
        fields_pp[k] = v
    end
end
# le dernier
if (isPpValid(fields_pp))
    global nbValids += 1
end

println(nbValids)