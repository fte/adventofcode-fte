#!/usr/bin/env julia

l = readlines(ARGS[1])

mem = Dict()
mask = ""
for m in l
    if startswith(m, "mask")
        global mask = SubString(m, 8)
        continue
    end
    ai = match(r"mem.(?<addr>[\d]+). = (?<int_val>[\w\s]+)", m)
    x = string.(reverse(digits(parse(Int, ai[:int_val]), base=2, pad=36)))
    # println("mev=", x, " ", typeof(x))
    # println("msk=", collect(mask))
    for (i, b) in enumerate(x)
        # println(i, " ", b, " ", typeof(b), " ", mask[i], " ", typeof(mask[i]))    
        if mask[i] != 'X'
            x[i] = string(mask[i])
        end
    end
    # println(parse(Int, join(x); base=2))
    mem[ai[:addr]] = parse(Int, join(x); base=2)
    # println(Int("0b".x))
end
println(sum(values(mem)))