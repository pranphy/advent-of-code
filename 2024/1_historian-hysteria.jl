filename = "files/1_input.txt"

XY = readlines(filename) .|> x ->split(x,r"\s+") |> x -> (parse(Int64,x[1]), parse(Int64,x[end]))
X,Y = XY .|> x -> x[1], XY .|> x -> x[end]
println(sum(abs.(sort(X)  .- sort(Y))))
println(sum([x * length(findall( t -> t == x, Y ))  for x in X]))



