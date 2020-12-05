#!/usr/bin/env julia

codes = readlines(ARGS[1])
# code= "FFFBBBFRRR"
trads = Dict('F' => '0', 'B' => '1', 'R' => '1', 'L' => '0')
max = 0
for code in codes
    bin = join([trads[c] for c in code])
    dec = parse(Int, bin; base=2)
    if (dec > max)
        global max = dec
    end
end
println(max)