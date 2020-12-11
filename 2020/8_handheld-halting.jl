#!/usr/bin/env julia
# author : Prakash
# date   : Thu 10 Dec 2020 07:16:13 PM EST


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
        if ins == "jmp" || ins == "nop"
            cp_code = copy(code)
            cp_code[i] = (ins == "jmp" ? "nop" : "jmp",param)
            completion, acc = execute(cp_code)
            completion && return acc
        end
    end
    print("failed to fix")
end

filename = "./files/8_handheld-halting.txt"
code = readlines(filename) .|> x -> split(x," ") |> a ->(a[1],tryparse(Int64,a[2]))

# Part one
completion, acc = execute(code)
println("The accumulator value at fault is $(acc)")

# Part two
acc = fix_code(code)
println("The fixed code has accumulator $(acc)")

