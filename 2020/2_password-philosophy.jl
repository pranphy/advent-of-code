
#!/usr/bin/env julia
# author : Prakash
# date   : Thu 03 Dec 2020 06:40:32 PM EST

function read_file(filename)
    policies = readlines(filename)
    [(split(x,"-")[1],split(split(x,"-")[2]," ")[1], split(split(x," ")[2],":")[1], split(x,": ")[2]) for x in policies]
end

function philosophy1(min,max,char,password)
    total = sum([string(char) == string(cur) ? 1 : 0 for cur in password])
    total >= min && total <= max
end

function philosophy2(min,max,letter,password)
    (password[min] == letter) ⊻ (letter == password[max])

end

function check_valid(info,philosophy)
    valid = 0
    for policy in info
        min = tryparse(Int64,policy[1]) 
        max = tryparse(Int64,policy[2])
        character = policy[3][1]
        password = policy[4]
        valid += philosophy(min,max,character,password) ? 1 : 0
    end
    valid
end

info = read_file("./files/2_password-philosophy.txt")

total_valid_1 = check_valid(info,philosophy1)
total_valid_2 = check_valid(info,philosophy2)
println("There are $(total_valid_1) valid passwords in the file with policy 1")
println("There are $(total_valid_2) valid passwords in the file with policy 2")