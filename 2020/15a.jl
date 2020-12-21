#!/usr/bin/env julia

numbers = parse.(Int, split.(readlines(ARGS[1]), ',')[1])

# 0,3,6
# println(numbers)
# while length(numbers) < 11
while length(numbers) < 2020
    # println(length(numbers), " nbr=", numbers)
    if last(numbers) ∉ numbers[1:end - 1]
        push!(numbers, 0)
    else
        # println("fa2=", findall(numbers .== last(numbers)))
        # println("df2=", diff(findall(numbers .== last(numbers))))
        age = last(diff(findall(numbers .== last(numbers))))
        push!(numbers, age)
    end
end
println(last(numbers))