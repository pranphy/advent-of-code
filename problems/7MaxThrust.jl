#!/usr/bin/env julia
# -*- coding: utf-8 -*-
# vim: ai ts=4 sts=4 et sw=4 ft=julia

# author : Prakash [प्रकाश]
# date   : 2019-12-09 11:02

using DataStructures
import Combinatorics


read_program_array(filename)  =  map(x -> tryparse(Int64,x), split(readlines(filename)[1],","))
PROGRAM_ARRAY = read_program_array("./files/7maximum_thrust.txt")

input_buffer = Queue{Int}()
output_buffer = Queue{Int}()


struct State
    type::String
    opcode::Int64
end

struct Instruction
    pos::Int64
    command::Int64
    opcode::Int64
    modes::Vector{Int64}()
    params::Vector{Int64}()
    out::Int64
end

struct Amplifier
    program_reg::Array{Int64}()
    current_block::Instruction
    state::State
end


function initialize_array(num_blocks=5)
    amp_chain = Vector{Amplifier}(num_blocks)
    for i in 1:num_blocks:
        program_reg = copy(PROGRAM_ARRAY)
        instrution = Instruction(1,1,1,[],[],1)
        state = State("Beg")
        amplifier = Amplifier(program_reg,intruction,state)
        amp_chain[i] = amplifier
    end
end


ADD(ins::Instruction) = ins.out = ins.params[1]+ins.params[2]
MUL(ins::Instruction) = ins.out = ins.params[1]*ins.params[2]
INP(ins::Instruction) = if isempty(input_buffer)  State("WAIT") else ins.pos += 2; dequeue!(input_buffer) end
OUT(ins::Instruction) = enqueue!(output_buffer,inp.params[end])
JIT(ins::Instruction) = ins.pos = ins.param[0] != 0 ?  ins.params[end] + 1 : ins.pos + 2
JIF(ins::Instruction) = ins.pos = ins.param[0] == 0 ?  ins.params[end] + 1 : ins.pos + 2
LTI(ins::Instruction) = ins.out = ins.param[0] < ins.parms[1] ? 0 : 1
EQI(ins::Instruction) = ins.out = ins.param[0] == ins.parms[1] ? 0 : 1


op_length(x) = Dict(1 => 3, 2 => 3, 3 => 1, 4 => 1, 5 => 2, 6 =>2, 7=>3, 8 => 3)[x]
op_func(x) = Dict(1 => ADD, 2 => MUL, 3 => INP, 4=> OUT, 5 => JIT, 6 => JIF, 7=> JIL, 8 => JIE)[x]

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
    if opcode in [1,2,3,7,8]
        program_register[block[end]+1] = op_func(opcode)(params)
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
    return pos == 1 ? 1 : 0
end

function find_thrust(combination)
    amplifier_register = Dict(x => read_program_array() for x in 1:length(combination))
    prev_output = 0 # first input is zero
    while not halt
        for (i,phase) in enumerate(combination)
            program_register = amplifier_register[i]

            empty!(input_buffer)
            empty!(output_buffer)

            enqueue!(input_buffer,phase)
            enqueue!(input_buffer,prev_output)

            run_program(program_register)

            prev_output = back(output_buffer)
        end
    end
    return prev_output
end


phase_combinations = Combinatorics.permutations([0,1,2,3,4])
thrusts = map(find_thrust,phase_combinations)
println(" Maximum thrust is $(maximum(thrusts)) ")

function run_block(num):
    if input:
        if output_buffer is empty:
            op = 
        deque(output_buffer)
