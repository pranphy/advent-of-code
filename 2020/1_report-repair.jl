#!/usr/bin/env julia
# author : Prakash
# date   : Thu 03 Dec 2020 06:05:38 PM EST


expenses = readlines("./files/1_report-repair.txt")

for i in 1:length(expenses)
    e1 = tryparse(Int64,expenses[i])
    for j in i:length(expenses)
        e2 =  tryparse(Int64,expenses[j])
        if e1+e2 == 2020
            print("$(e1*e2) is the product of two \n")
        end
        for k in j:length(expenses)
            e3 = tryparse(Int64,expenses[k])
            if e1+e2+e3 == 2020
                print("$(e1*e2*e3) is the product of three \n")
            end
        end
    end
end


