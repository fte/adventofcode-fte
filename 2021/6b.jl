#!/usr/bin/env julia

lf = parse.(Int, split(readline(ARGS[1]), ','))

initial_state = deepcopy(lf)
# @show lf
jours = 256
# lfByTimers= zeros(Int8, 9) # arrrrrrrg
lfByTimers = Array{Int64}(undef, 9)
# @show lfByTimers
for timer in lf
    lfByTimers[timer+1] += 1
end

# @show lfByTimers
for _ = 1:jours
    nouvellefraie = first(lfByTimers)
    global lfByTimers = circshift(lfByTimers, -1)

    lfByTimers[7] += nouvellefraie
    lfByTimers[9] = nouvellefraie
    # @show lfByTimers
end
@show sum(lfByTimers)