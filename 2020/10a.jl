#!/usr/bin/env julia

output_joltages = sort!(parse.(Int, eachline(ARGS[1])))
# println(output_joltages)

device_rating = 3
device_adapter_output = output_joltages[end] + device_rating;

# println("slice=",output_joltages[2:end] )
oj_shift_right = copy(output_joltages)
push!(oj_shift_right,device_adapter_output)
pushfirst!(output_joltages, 0)

# println("a=",oj_shift_right)
# println("o=",output_joltages)
# println("moins=", map(-, [1, 2, 3], [10, 20, 30]))
# println("moins=", map.(-, oj_shift_right, output_joltages))
all_diffs = map(-, oj_shift_right, output_joltages)

number_1jolts = count(i -> (i == 1), all_diffs)
number_3jolts = count(i -> (i == 3), all_diffs)
println(number_1jolts * number_3jolts)
