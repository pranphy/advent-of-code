#!/usr/bin/env julia
# -*- coding: utf-8 -*-
# vim: ai ts=4 sts=4 et sw=4 ft=julia

# author : Prakash [प्रकाश]
# date   : 2019-12-03 22:38

function get_paths_from_file(filepath)
    paths = readlines(filepath)
    return  [split(paths[1],","), split(paths[2],",")]
end


function insert_points_touched(holder,start,segment,dist_so_far=0)
    direction   = segment[1]
    seg_len_str = segment[2:length(segment)]
    seg_length = tryparse(Int64,seg_len_str)

    #print("Distance so far is : ",dist_so_far)


    xi,yi = start

    dir = [0,0]

    if direction == 'R'
        dir = [1,0]
    elseif direction == 'L'
        dir = [-1,0]
    elseif direction == 'U'
        dir = [0,1]
    elseif direction == 'D'
        dir = [0,-1]
    else
        warn("Something wrong")
    end

    for i in 1:seg_length
        dist_so_far += 1
        xi += dir[1]*1
        yi += dir[2]*1

        point = [xi,yi]
        key = [xi,yi]
        holder[key]  = dist_so_far 
    end
    #println(" Length is ",seg_length, " and dist so far now is ",dist_so_far)
    return [xi,yi],dist_so_far
end



function get_point_sets()
    l1,l2 = get_paths_from_file("./files/3wire_paths.txt")

    holder1 = Dict{Vector,Int64}()
    holder2 = Dict{Vector,Int64}()

    last_point = [0,0]
    dist_so_far = 0
    for segment in l1
        last_point,dist_so_far = insert_points_touched(holder1,last_point,segment,dist_so_far)
    end
    last_point = [0,0]
    dist_so_far = 0
    for segment in l2
        last_point,dist_so_far = insert_points_touched(holder2,last_point,segment,dist_so_far)
    end
    return holder1,holder2
end


function find_common()
    h1,h2 = get_point_sets()
    common = Vector{Vector}()
    i = 1
    c = 0
    t = length(h1)


    for point in keys(h1)
        print("\r ",i ," ",c , " ", t ," ")
        i += 1
        if haskey(h2,point)
            pv1 = h1[point]
            pv2 = h2[point]
            item = [point, [pv1,pv2]]
            c += 1
            push!(common,item)
        end
    end
    return common
end


function distance(metric,points)
    if metric == "manhattan"
        return abs(points[1][1]) +  abs(points[1][2])
    elseif metric == "signaltime"
        return abs(points[2][1]) + abs(points[2][2])
    else
        warn("Something horribly wrong")
    end
end


function find_min_distance(metric)
    commons = find_common()
    dists = Vector{Int64}()
    for points in commons
        #dist = abs(points[2][1]) + abs(points[2][2])
        dist = distance(metric,points)
        push!(dists,dist)
    end
    min = dists[1]
    for i in dists
        if i  < min
            min = i
        end
    end
    return min
end

min_man = find_min_distance("manhattan")
min_sig = find_min_distance("signaltime")
println("")
println("The minimum  manhattan distance is ",min_man)
println("The minimum signaltime distance is ",min_sig)

