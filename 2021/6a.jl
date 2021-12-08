#!/usr/bin/env julia

lf = parse.(Int, split(readline(ARGS[1]), ','))

# @show lf
jours = 80

for _ in 1:jours
    for np in eachindex(lf)
        timer= lf[np]
        if timer == 0
            lf[np] = 6
            push!(lf, 8)
        else
            lf[np] = timer - 1
        end
    end
end

@show length(lf)