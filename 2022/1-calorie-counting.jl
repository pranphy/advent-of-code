#!/usr/bin/env julia
# author : Prakash
# date   :  Thu Dec  1 10:26:02 PM EST 2022

calories = []
curcal = []
for line in readlines("./files/1-input.txt")
    if line == ""
        push!(calories,curcal)
        global curcal = []
    else
        push!(curcal,tryparse(Int64,line))
    end
end
sumcalories = [sum(x) for x in calories]

# part one
most = maximum(sumcalories)
println("The  most calories is: $(most)")

# part two
sumthree = sum(sort(sumcalories,rev=true)[1:3])
println("The sum of top three calories is: $(sumthree) ")

