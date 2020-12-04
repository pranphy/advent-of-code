
#!/usr/bin/env julia
# author : Prakash
# date   : Thu 03 Dec 2020 10:39:38 PM EST

function count_trees(tree,right,down)
    height,rows = length(tree), length(tree[1])
    r,c = 1,1
    count = 0
    while c <= height
        count += tree[c][r] == '#' ? 1 : 0
        r = mod1(r+right, rows)
        c += down
    end
    count
end


file_trees = readlines("./files/3_toboggan-trajectory.txt")

# Part One
tree_count   = count_trees(file_trees,3,1)
println("Total number of trees is $(tree_count)")


# Part Two
slopes = [[1,1],[3,1],[5,1],[7,1],[1,2]] 
tree_product = reduce(*,[count_trees(file_trees,sl[1],sl[2]) for sl in slopes])
println("The product of all tree number is $(tree_product)")
