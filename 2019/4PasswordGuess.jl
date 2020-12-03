#!/usr/bin/env julia
# -*- coding: utf-8 -*-
# vim: ai ts=4 sts=4 et sw=4 ft=julia

# author : Prakash [प्रकाश]
# date   : 2019-12-04 13:44

function is_monotonic(number)
    numstr = string(number)
    old = '0'
    for x in numstr
        if x < old
            return false
        else
            old = x
        end
    end
    return true
end
    
function count_digits(number)
    numstr = string(number)
    counts = Vector{Int64}()
    for x in numstr
        cnt = count(i -> (i==x), numstr)
        push!(counts,cnt)
    end
    return counts
end


function get_count(criteria)
    first = 156666
    last  = 652527
    count = 0

    for x = first:last
        if is_monotonic(x)
            counts = count_digits(x)
            count += criteria(counts)
        end
    end
    return count
end

criteria1(list) = maximum(list) >= 2
criteria2(list)  =  2 in list

count1 = get_count(criteria1)
count2 = get_count(criteria2)

println("There are a total of ",count1, " matching first criteria")
println("There are a total of ",count2, " matching second criteria")

