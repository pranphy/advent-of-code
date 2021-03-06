#!/usr/bin/env julia
# -*- coding: utf-8 -*-
# vim: ai ts=4 sts=4 et sw=4 ft=julia

# author : Prakash [प्रकाश]
# date   : 2019-12-17 10:30


function read_imgdata(filename::String)
    map(x->parse(Int,x),collect(readlines(filename)[1]))
end

function slice_them(imgdata::Array{Int,1},row::Int,col::Int,)
    layers = Vector{Array{Int64,2}}(undef,0)
    block_size = row*col
    pos = 1; end_pos = pos + block_size - 1
    while end_pos <= length(imgdata)
        layer = transpose(reshape(imgdata[pos:end_pos],col,row))
        push!(layers,layer)
        pos = end_pos+1; end_pos = pos+block_size - 1
    end
    return  layers
end

function count_digit(array::Array{Int64,2},num::Int64)
    count(x-> x==num,array)
end

function fewest_layer_n(layers::Vector{Array{Int64,2}},n::Int=0)
    n_counts = map(x -> count_digit(x,n),layers)
    min_count = minimum(n_counts)
    min_idx = findall(x -> x == min_count,n_counts)[1]
    return layers[min_idx]
end

function get_pixel_val(i,j,layers::Vector{Array{Int64,2}})
    layers[1][i,j] == 2 ? get_pixel_val(i,j,layers[2:end]) : layers[1][i,j]
end


function stack_layers(layers::Vector{Array{Int64,2}})
    row,col = size(layers[1]) # All the layers have the same size; so first
    final = zeros(size(layers[1]))
    for i in 1:row
        for j in 1:col
            pixel = get_pixel_val(i,j,layers)
            final[i,j] = pixel
        end
    end
    return final
end

function imshow(image)
    r,c = size(image)
    for i in 1:r
        for j in 1:c
            vl = image[i,j]
            vl = vl != 0 ? '#' : ' '
            print(vl)
        end
        println("")
    end
end

        
imagedata = read_imgdata("./files/8image_data.txt")

width = 25
height = 6
layers = slice_them(imagedata,height,width)

min_layer = fewest_layer_n(layers,0)
one_count = count_digit(min_layer,1)
two_count = count_digit(min_layer,2)

println("The product required is $one_count x $two_count =  $(one_count * two_count) ")

println("The message is ::")
final = stack_layers(layers)
imshow(final)



