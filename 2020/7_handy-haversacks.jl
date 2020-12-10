#!/usr/bin/env julia
# author : Prakash
# date   : Tue 08 Dec 2020 11:14:52 AM EST

function read_file(filename)
    lines = readlines(filename)
    obag_contents = Dict{String,Any}()
    for line ∈ lines
        name,contents = match(r"(\w+\s\w+\sbag)[s]*[\s]*contain[\s]*(.*)",line).captures
        bagnumbers = tryparse.(Int64,getindex.(contents,findall(r"\d+",contents)))
        bagnames = getindex.(contents,findall(r"\w+\s\w+\sbag*",contents))
        obag_contents[name] = Dict(zip(bagnames,bagnumbers))
    end
    obag_contents
end

function contains(outer,inner,repository)
    rep_contents = repository[outer]
    length(keys(rep_contents)) < 1 && return false
    inner ∈ keys(rep_contents) && return true
    for key in keys(rep_contents)
        contains(key,inner,repository) && return true
    end
    return false
end

function num_contents(bag,repository)
    rep_contents = repository[bag]
    length(keys(rep_contents)) < 1 && return 0
    return sum([val + val*num_contents(key,repository) for (key,val) ∈ rep_contents])
end

count_container(bag,repository) = sum([contains(outer,bag,repository) ? 1 : 0 for outer in keys(repository)])

contents = read_file("./files/7_handy-haversacks.txt")

bag_in_question = "shiny gold bag"

# Part one
containers = count_container(bag_in_question,contents)
println("The number of containers of $(bag_in_question) is $(containers) of $(length(keys(contents)))")

# Part two
count = num_contents(bag_in_question,contents)
println("The $(bag_in_question) contains whooping $(count) bags")

