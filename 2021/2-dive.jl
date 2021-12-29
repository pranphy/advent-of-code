#!/usr/bin/env julia
# author : Prakash
# date   : Sun Dec 26 05:56:41 PM EST 2021

filename = "files/2-input.txt"
lines = readlines(filename) .|> x-> split(x,' ') |> x ->  (x[1],tryparse(Int64,x[2]))

# Part 1
dir_mat(x) = Dict("forward" => [1,0], "down" => [0,-1], "up" => [0,1])[x]
disp = sum(lines[x][2] * dir_mat(lines[x][1]) for x in 1:length(lines))
product = abs(disp[1]*disp[2])

println("The product is : $(product)")

# Part 2
aim_mat(x) = Dict("forward" => 0, "down" => -1, "up" => 1)[x]

forward = [line[1] == "forward" ? line[2] : 0 for line in lines]
aim = cumsum([line[2]*aim_mat(line[1]) for line in lines])
product = abs(sum(forward) * sum(forward .* aim))

println("The product is : $(product) ")

