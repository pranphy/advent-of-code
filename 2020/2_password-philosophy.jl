
#!/usr/bin/env julia
# author : Prakash
# date   : Thu 03 Dec 2020 06:40:32 PM EST

function read_file(filename)
    policies = readlines(filename)
    [(split(x,"-")[1],split(split(x,"-")[2]," ")[1], split(split(x," ")[2],":")[1], split(x,": ")[2]) for x in policies]
end

function check_valid_policy1(info)
    valid = 0
    for policy in info
        min= tryparse(Int64,policy[1]) 
        max = tryparse(Int64,policy[2])
        char = policy[3]
        password = policy[4]
        chars = [string(char) == string(cur) ? 1 : 0 for cur in password]
        total = sum(chars)
        if total >= min && total <= max
            valid += 1
        end
    end
    valid
end

function check_valid_policy2(info)
    valid = 0
    for policy in info
        min = tryparse(Int64,policy[1])
        max = tryparse(Int64,policy[2])
        char = policy[3]
        password = policy[4]
        cond1 = string(password[min])==string(char) ? 1 : 0
        cond2 = string(password[max])==string(char) ? 1 : 0
        if cond1 + cond2 == 1
            valid +=1
        end
    end
    valid
end

info = read_file("./files/2_password-philosophy.txt")

total_valid_1 = check_valid_policy1(info)
total_valid_2 = check_valid_policy2(info)
println("There are $(total_valid_1) valid passwords in the file with policy 1")
println("There are $(total_valid_2) valid passwords in the file with policy 2")