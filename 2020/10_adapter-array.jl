#!/usr/bin/env julia
# author : Prakash
# date   : Sat 12 Dec 2020 01:09:18 PM EST

filename = "./files/10_adapter-array.txt"
joltages = (readlines(filename)  .|> x->tryparse(Int64,x)) |> sort

insert!(joltages,1,0) # inserting source joltage
insert!(joltages,length(joltages)+1,maximum(joltages)+3) # inserting device joltage

diff = joltages[2:end] .- joltages[1:end-1]
one_count = sum([x==1 ? 1 : 0 for x in diff])
three_count = sum([x==3 ? 1 : 0 for x in diff])

print("The product of one count and three count is $(one_count*three_count)")
