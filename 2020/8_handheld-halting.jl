#!/usr/bin/env julia
# author : Prakash
# date   : Thu 10 Dec 2020 07:16:13 PM EST

read_code(filename) = map(x->(x[1],tryparse(Int64,x[2])),map(x->split(x," "),readlines(filename)))



function execute(code)
    acc = 0
    visited = []
    pointer = 1
    last_pointer = length(code)
    while !(pointer ∈ visited) && pointer <= last_pointer
        ins,param = code[pointer]
        push!(visited,pointer)
        if ins == "acc" 
            acc += param
            pointer += 1
        end
        ins == "nop" && (pointer += 1)
        ins == "jmp" && (pointer += param)
    end
    return pointer == last_pointer + 1 ? (true,acc) : (false,acc)
end

function fix_code(code)
    for (i,(ins,param)) ∈ enumerate(code)
        if ins == "jmp"
            cp_code = copy(code)
            cp_code[i] = ("nop",param)
            completion, acc = execute(cp_code)
            completion && return acc
        elseif ins == "nop"
            cp_code = copy(code)
            cp_code[i] = ("jmp",param)
            completion,acc = execute(cp_code)
            completion && return acc
        end
    end
    print("failed to fix")
end

code =  read_code("./files/8_handheld-halting.txt")
println(length(code))

completion, acc = execute(code)
println("The accumulator value at fault is $(acc) completion=$(completion)")


acc = fix_code(code)
println("The fixed code has accumulator $(acc)")

