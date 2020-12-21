#!/usr/bin/env julia

numbers = parse.(Int, split.(readlines(ARGS[1]), ',')[1])

spoken_numbers = Dict(num => tour for (tour, num) in enumerate(numbers))
# println(spoken_numbers)
lastn = last(numbers)
for tour in (length(numbers) + 1):30000000
    tour_precedent = tour - 1
    if lastn ∈ keys(spoken_numbers)
        num = tour_precedent - spoken_numbers[lastn]
    else
        num = 0
    end
    spoken_numbers[lastn] = tour_precedent
    global lastn = num
end
println(lastn)