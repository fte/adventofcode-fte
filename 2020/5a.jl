#!/usr/bin/env julia

codes = readlines(ARGS[1])
println(codes)
code= "FFFBBBFRRR"
trads = Dict('F' => '0', 'B' => '1', 'R' => '1', 'L' => '0')
bin= join([trads[c] for c in code])
println(bin,' ',typeof(bin))
# println(Int(string("0b",bin)))
println(parse(Int, bin; base=2))
