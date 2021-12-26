#!/usr/bin/env julia
# author : Prakash
# date   : Sun Dec 26 05:26:42 PM EST 2021


depths = readlines("./files/1-input.txt") .|> x ->tryparse(Int64,x)

diffs = depths[2:end] .- depths[1:end-1]
inc = sum([x > 0 ? 1 : 0 for x in diffs])
println("It increased $(inc) times ")

winsums = [sum(depths[x:x+2]) for x in 1:length(depths)-2]
sumdiff = winsums[2:end] .- winsums[1:end-1]
suminc = sum([x > 0 ? 1 : 0 for x in sumdiff])
println("It increased $(suminc) times with sliding ")

