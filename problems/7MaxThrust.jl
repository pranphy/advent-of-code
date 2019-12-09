#!/usr/bin/env julia
# -*- coding: utf-8 -*-
# vim: ai ts=4 sts=4 et sw=4 ft=julia

# author : Prakash [प्रकाश]
# date   : 2019-12-09 11:02

using DataStructures
import Combinatorics; const cmb=Combinatorics

input_buffer = Queue{Int}()
output_buffer = Queue{Int}()

function read_program_array()
    opcodes = readlines("./files/7maximum_thrust.txt")[1]
    map(x -> tryparse(Int64,x), split(opcodes,","))
end

op_length(x) = Dict(1 => 3, 2 => 3, 3 => 1, 4 => 1, 5 => 2, 6 =>2, 7=>3, 8 => 3)[x]
op_func(x) = Dict(1 => (x,y) -> x+y, 2 => (x,y) -> x*y, 7 => (x,y) -> x < y ? 1 : 0, 8 => (x,y) -> x == y ? 1 : 0)[x]

function decompose(command)
    opcode = command % 100
    mode = command ÷ 100 # Int64(floor(command / 100)) # how about this

    modes =map(x -> Int64(x), [digits(mode); zeros(op_length(opcode)-length(digits(mode)))])
    return opcode,modes
end

function process_blocks(program_register,pos)
    opcode,modes = decompose(program_register[pos])
    param_count = op_length(opcode)
    jump = param_count + 1
    block = program_register[pos+1:pos+param_count]
    params = map(i -> modes[i] == 0 ? program_register[block[i]+1] : block[i],1:param_count)
    if opcode in [1,2,7,8]
        program_register[block[end]+1] = op_func(opcode)(params[1],params[2])
    elseif opcode == 3
        input = dequeue!(input_buffer)
        program_register[block[end]+1] = input
    elseif opcode == 4
        enqueue!(output_buffer,program_register[block[end]+1])
    elseif opcode == 5
        pos = params[1] != 0 ? params[end] + 1 : pos + jump
        jump = 0
    elseif opcode == 6
        pos = params[1] == 0 ? params[end] + 1 : pos + jump
        jump = 0
    end
    pos += jump
    return program_register,pos
end

function run_program(program_register)
    pos = 1
    while program_register[pos] != 99
        program_register,pos = process_blocks(program_register,pos)
    end
end

function find_thrust(combination)
    prev_output = 0 # first input is zero
    for phase in combination
        program_register = read_program_array()

        empty!(input_buffer)
        empty!(output_buffer)

        enqueue!(input_buffer,phase)
        enqueue!(input_buffer,prev_output)

        run_program(program_register)

        prev_output = back(output_buffer)
    end
    return prev_output
end


phase_combinations = cmb.permutations([0,1,2,3,4])
thrusts = map(find_thrust,phase_combinations)
println(" Maximum thrust is $(maximum(thrusts)) ")

