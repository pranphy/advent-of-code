#!/usr/bin/env julia
# author : Prakash
# date   : Sat 12 Dec 2020 01:09:18 PM EST


function find_product(param)
    joltages = copy(param)
    insert!(joltages,1,0) # inserting source joltage
    insert!(joltages,length(joltages)+1,maximum(joltages)+3) # inserting device joltage

    diff = joltages[2:end] .- joltages[1:end-1]
    one_count = sum([x==1 ? 1 : 0 for x in diff])
    three_count = sum([x==3 ? 1 : 0 for x in diff])
    return one_count*three_count
end

function count_ways(param)
    joltages = param[end:-1:1]
    totalways = 1
    i = 1; total = length(joltages)
    previous = maximum(joltages) + 3 # device joltage
    while i <= length(joltages)
        # joltage within  3 of previous
        maxnext = min(i+3,total)
        count = sum([ x >= previous-3 for x in joltages[i:maxnext]])
        thisways = factorial(count)
        thisways = Dict(3=>7,2=>3,1=>1)[count]
        println(" previous was $(previous) and the next $(count) are in range $(joltages[i:maxnext]) ")
        println(" $(totalways) *= $(thisways) is $(totalways*thisways) ")

        totalways *= thisways
        i += count
        previous = joltages[min(i,total)-1]
        #i += 1
    end
    totalways
end

#filename = "./files/10_adapter-array.txt"
filename = "./files/10_test.txt"
joltages = (readlines(filename)  .|> x->tryparse(Int64,x)) |> sort
# Part one
product = find_product(joltages)
println("The one and three count multiply to $(product).")

# Part two
ways = count_ways(joltages)
println("There are $(ways) ways to rearrange the adapters.")

