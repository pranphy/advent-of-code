#!/usr/bin/env julia
# author : Prakash
# date   : Sat 05 Dec 2020 01:36:34 AM EST


function find_row_col(boardid)
    fbid = boardid[1:end-3]
    lrid = boardid[end-2:end]
    bifbid = [cid == 'F' ? 0 : 1 for cid ∈ fbid]
    bilrid = [cid == 'L' ? 0 : 1 for cid ∈ lrid]
    hlen = 64
    row = 0
    for fbbit in bifbid
        row += fbbit*hlen
        hlen ÷= 2
    end
    col = 0
    hlen=4
    for lrbit in bilrid
        col += lrbit*hlen
        hlen ÷= 2
    end
    return (row,col)
end

function seat_id(boardid)
    row,col = find_row_col(boardid)
    return row*8+col
end

all_ids  = [seat_id(boardid) for boardid in readlines("./files/5_binary-boarding.txt") ]

highestid = maximum(all_ids)
println("The highest id is $(highestid)")

sort!(all_ids)
_,id = findmax(all_ids[2:end] .- all_ids[1:end-1])
my_seat = all_ids[id] + 1

println("My set id is $(my_seat)")