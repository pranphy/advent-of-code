filename = "files/2_input.txt"

function safe(x)
    rdiff = x[1:end-1] .- x[2:end]
    adiff = abs.(rdiff)
    (adiff  == rdiff || adiff == (-1 .* rdiff) ) && all(adiff .>= 1) && all(adiff .<= 3)
end

lazy_safe_count(x) = safe(x) || any( safe(deleteat!(copy(x),t)) for t in 1:length(x) )


reports = readlines(filename) .|> x ->split(x,r"\s+") |> x -> [parse(Int64,t) for t in x] |> safe
println("Part 1: ",sum(reports))

reports = readlines(filename) .|> x ->split(x,r"\s+") |> x -> [parse(Int64,t) for t in x] |>  lazy_safe_count
println("Part 2: ",sum(reports))


