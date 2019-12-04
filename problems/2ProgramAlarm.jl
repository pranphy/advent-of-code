# author : Prakash
# date   : Tue Dec  3 18:04:18 EST 2019

function read_program_array()
    code_vec = Vector{Int64}(undef,0)
    opcodes = readlines("2alarm_code.txt")[1]
    code_list = split(opcodes,",")
    for cnt = 1:length(code_list)
        cur_code = code_list[cnt]
        int_code = tryparse(Int64,code_list[cnt])
        push!(code_vec,int_code)
    end
    return code_vec
end

pos = 1

code_vec = read_program_array()

code_vec[1+1] = 12
code_vec[2+1] = 2

while code_vec[pos] != 99

    command,pos1,pos2,pos3 = code_vec[pos:pos+3]
    global pos += 4

    val1 = code_vec[pos1 + 1]
    val2 = code_vec[pos2 + 1]
    val = 0

    if command == 1
        val = val1 + val2
    elseif command == 2
        val = val1 * val2
    else
        warn("Something wrong ")
    end

    code_vec[pos3 + 1] = val
end

println("The first value is ",code_vec[1])

    

