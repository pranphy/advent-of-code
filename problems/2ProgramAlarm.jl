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

function get_output(noun,verb)
    pos = 1

    code_vec = read_program_array()

    code_vec[1+1] = noun
    code_vec[2+1] = verb 

    while code_vec[pos] != 99

        command,pos1,pos2,pos3 = code_vec[pos:pos+3]
        pos += 4

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
    return code_vec[1]
end


function get_nounsum()
    Val = 19690720
    for noun = 0:99
        for verb = 0:99
            op = get_output(noun,verb)
            if op == Val
                println("Noun : ",noun," Verb : ",verb, " Result : ",100*noun+verb)
            end
        end
    end
end

println("The first value is ",get_output(12,2))

get_nounsum()

