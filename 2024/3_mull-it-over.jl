filename = "files/3_input.txt"

pat = r"mul\((\d+),(\d+)\)"
total  = sum(readlines(filename) .|> line -> sum(eachmatch(pat,line) .|> x -> parse(Int64,x.captures[1]) * parse(Int64,x.captures[2]) ))

println("Part 1: ",total)





# Part 2
fac = 1
patl = r"mul\((\d{1,3}),(\d{1,3})\)|do\(\)|don't\(\)"

function lineprod(line)
    stb = line
    pr = 0;
    while stb != ""
        m1 = match(patl,stb)
        m1 != nothing || break
        loc = findfirst(patl,stb)
        if startswith(m1.match ,"mul(")
            mul = parse(Int64,m1.captures[1]) * parse(Int64,m1.captures[2])
            pr += fac * mul
        elseif m1.match == "do()"
            global fac = 1
        elseif m1.match == "don't()"
            global fac = 0
        end
        stb = stb[maximum(loc)+1:end]
    end
    return pr
end


prds =  readlines(filename) .|> lineprod
println("Part 2: ",sum(prds))
