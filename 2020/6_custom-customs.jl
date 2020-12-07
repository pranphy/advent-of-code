#!/usr/bin/env julia
# author : Prakash
# date   : Mon 07 Dec 2020 12:17:11 PM EST

function read_file(filename)
    lines = readlines(filename)
    loc = findall(isempty, lines)
    getindex.(Ref(lines), UnitRange.([1; loc .+ 1], [loc .- 1; length(lines)]))
end

get_group_count(answers,method) = length(reduce(method,map(Set,answers)))
get_sum(data,method) =  reduce(+,[get_group_count(answers,method) for answers in data])


data = read_file("./files/6_custom-ustoms.txt")

count_sum_1 = get_sum(data,union!)
println("The total sum with policy 1 is $(count_sum_1)")

count_sum_2 = get_sum(data,intersect!)
println("The total sum with policy 2 is $(count_sum_2)")

