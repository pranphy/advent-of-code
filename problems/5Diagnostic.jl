#!/usr/bin/env julia
# -*- coding: utf-8 -*-
# vim: ai ts=4 sts=4 et sw=4 ft=julia

# author : Prakash [प्रकाश]
# date   : 2019-12-04 23:17

# https://adventofcode.com/2019/day/5


function read_program_array()
    opcodes = readlines("./files/5diagnostic_code.txt")[1]
    map(x -> tryparse(Int64,x), split(opcodes,","))
end

op_length(x) = Dict(1 => 3, 2 => 3, 3 => 1, 4 => 1, 5 => 2, 6 =>2, 7=>3, 8 => 3)[x]
op_func(x) = Dict(1 => (x,y) -> x+y, 2 => (x,y) -> x*y, 3 =>  x -> x , 4 => x -> x)[x]

function decompose(command)
    opcode = command % 100
    mode = command ÷ 100 # Int64(floor(command / 100)) # how about this

    modes = [digits(mode); zeros(op_length(opcode)-length(digits(mode)))]
    return opcode,modes
end

function process_blocks(program_register,pos,input=1)
    opcode,modes = decompose(program_register[pos])
    param_count = op_length(opcode)
    if opcode == 3
        address = program_register[pos+1]
        program_register[address+1] = input
    elseif opcode == 4
        address = program_register[pos+1]
        println(" julia@mars: ~ : ",program_register[address+1])
    elseif opcode in [1,2]
        block = program_register[pos+1:pos+param_count]
        params = map(i -> modes[i] == 0 ? program_register[block[i]+1] : block[i],1:param_count-1)
        program_register[block[3]+1] = op_func(opcode)(params[1],params[2])
    end
    pos += param_count + 1
    return program_register,pos
end




function run_program(program_register,inp)
    pos = 1
    while program_register[pos] != 99
        program_register,pos = process_blocks(program_register,pos,inp)
    end
end


function doit()
    program_register = read_program_array()
    println("Part one :: ")
    run_program(program_register,1)
end

doit()
