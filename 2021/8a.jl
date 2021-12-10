#!/usr/bin/env julia

puzzle = readlines(ARGS[1])

sum = 0
for line in puzzle
    digits = split.(split(line, "| ")[2], ' ')
    # @info digits
    global sum += count(x -> length(x) in (2, 3, 4, 7), digits)
end
@info sum
