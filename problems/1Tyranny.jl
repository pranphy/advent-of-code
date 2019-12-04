# author : Prakash
# date   : Tue Dec  3 12:27:05 EST 2019

masses = readlines("./files/1module_masses.txt")

function fuel_for_mass(mass)
    floor(mass/3)-2
end


function rec_fuel(mass)
    if fuel_for_mass(mass) <= 0
        return 0
    else
        fuel = fuel_for_mass(mass)
        return fuel + rec_fuel(fuel)
    end
end

sum = 0
rec_sum = 0

for mass in masses
    mass = tryparse(Float64,mass)
    global sum += fuel_for_mass(mass)
end
println(sum)

for mass in masses
    mass = tryparse(Float64,mass)
    global rec_sum += rec_fuel(mass)
end

println(rec_sum)

