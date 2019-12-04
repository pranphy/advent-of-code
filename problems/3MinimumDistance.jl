#!/usr/bin/env julia
# -*- coding: utf-8 -*-
# vim: ai ts=4 sts=4 et sw=4 ft=julia

# author : Prakash [प्रकाश]
# date   : 2019-12-03 22:38

function get_paths_from_file(filepath)
    paths = readlines(filepath)
    return  [split(paths[1],","), split(paths[2],",")]
end


function insert_pints_touched(holder,start,segment,dist_so_far=0)
    direction   = segment[1]
    seg_len_str = segment[2:length(segment)]
    seg_length = tryparse(Int64,seg_len_str)

    dist_so_far += seg_length

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

    for _ in 1:seg_length
        xi += dir[1]*1
        yi += dir[2]*1

        point = [xi,yi]
        push!(holder,point)
    end
    return [xi,yi],dist_so_far
end



function get_point_sets()
    l1,l2 = get_paths_from_file("./files/3wire_paths.txt")

    holder1 = Set{Vector}()
    holder2 = Set{Vector}()

    last_point = [0,0]
    dist_so_far = 0
    for segment in l1
        last_point,dist_so_far = insert_pints_touched(holder1,last_point,segment,dist_so_far)
    end
    last_point = [0,0]
    dist_so_far = 0
    for segment in l2
        last_point,dist_so_far = insert_pints_touched(holder2,last_point,segment,dist_so_far)
    end
    return holder1,holder2
end


function find_common()
    h1,h2 = get_point_sets()
    common = Set{Vector}()

    for point in h1
        if (point in h2)
            push!(common,point)
        end
    end
    return common
end


function find_min_distance()
    commons = find_common()
    dists = Set{Int64}()
    for points in commons
        dist = abs(points[1]) + abs(points[2])
        push!(dists,dist)
        #println("Points ", points, " distance ",dist)
    end
    min = 999999 
    for i in dists
        if i  < min
            min = i
        end
    end
    return min
end

min = find_min_distance()
print("The minimum distance is ",min)


