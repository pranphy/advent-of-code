#!/usr/bin/env julia
# author : Prakash
# date   : Thu 10 Dec 2020 09:31:04 PM EST

using Combinatorics

function find_error_loc(nums,N=25)
    for x ∈ N+2:length(nums)
        prev = nums[x-1-N:x-1]
        all_combs = collect(combinations(prev,2))
        !(nums[x] ∈ map(sum,all_combs)) && return x
    end
    println("Everyting seems ok")
end

function find_cont_list(nums,err_loc)
    err_num = nums[err_loc]
    prec_list = nums[1:err_loc-1]
    for i ∈ 1:length(prec_list)
        for j ∈ i+1:length(prec_list)
            cont_list = prec_list[i:j]
            sum(cont_list) == err_num && return cont_list
        end
    end
    println("No such list exists")
    []
end

nums = readlines("./files/9_encoding-error.txt") .|> x-> tryparse(Int64,x)

# Part one
err_loc = find_error_loc(nums)
println("The error num is $(nums[err_loc])")

# Part two
cont_list = find_cont_list(nums,err_loc)
maxminsum = maximum(cont_list) + minimum(cont_list)
println("The encryption weakness is $(maxminsum)")

