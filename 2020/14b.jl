#!/usr/bin/env julia

l = readlines(ARGS[1])

# compte les X et genere les 2^nbX bits possibles 
function makeAddrFromFloatingBits(address)
    addrs = []
    addr = copy(address)
    # println("input=\tadr=", join(addr))
    ffx = findall(x -> x == "X", addr)
    # println("ffx=",ffx)
    exp = length(ffx)
    max = 2^exp
    for i in 0:max - 1
        val_b2 = digits(i, base=2, pad=exp)
        # println("val_b2=",val_b2)
        for (idx, b) in zip(ffx, val_b2)
            addr[idx] = string(b)
        end
        # println("\tadg=", join(addr))
        push!(addrs, join(addr))
    end
    # println("addrs=", addrs)
    return addrs
end

mem = Dict()
mask = ""
for m in l
    if startswith(m, "mask")
        global mask = SubString(m, 8)
        continue
    end
    ai = match(r"mem.(?<addr>[\d]+). = (?<int_val>[\w\s]+)", m)
    val = parse(Int, ai[:int_val])
    addr = string.(reverse(digits(parse(Int, ai[:addr]), base=2, pad=36)))
    # println("adr=", join(addr))
    new_addresses = []
    # println("msk=", mask)
    for (i, b) in enumerate(mask)
        # println(i, " ", b, " ", typeof(b), " ", addr[i], " ", typeof(addr[i]))    
        if b != 'X'
            addr[i] =  parse(Bool, b) | parse(Bool, addr[i]) ? "1" : "0" 
        else 
            addr[i] = "X"
        end
    end
    # println("tpl=", join(addr))
    # println()
    new_addresses = makeAddrFromFloatingBits(addr)
    # println("nad=", new_addresses)
    for naddr in new_addresses
        # println("nad=", join(naddr))
        naddr_b10 = parse(Int, naddr; base=2)
        # println("nad10=", naddr_b10)
        mem[naddr_b10] = val
    end
end
# println(mem)
println(sum(values(mem)))