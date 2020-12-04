
#!/usr/bin/env julia
# author : Prakash
# date   : Fri 04 Dec 2020 12:07:37 AM EST


function format(data)
    push!(data,"")
    formatted = Array{String}(undef,0)
    cur = ""
    for row in data
        cur *= " " * row
        if row == ""
            push!(formatted,cur)
            cur = ""
        end
    end
    formatted
end

function validity1(info)
    req_fields = ["byr","iyr","eyr","hgt","hcl","ecl","pid"]
    for field in req_fields
        if !occursin(field*":",info)
            return false
        end
    end
    true
end

function validity2(info)
    if validity1(info)
        fields = split(info," ")
        for field in fields
            if field == ""
                continue
            end
            field,val = split(strip(field),":")
            if field == "byr"
                val = tryparse(Int64,val)
                if val < 1920 || val > 2002
                    return false
                end
            elseif field == "iyr"
                val = tryparse(Int64,val)
                if val < 2010 || val > 2020
                    return false
                end
            elseif field == "eyr"
                val = tryparse(Int64,val)
                if val < 2020 || val > 2030
                    return false
                end
            elseif field == "hgt"
                unit = val[end-1:end]
                val  = tryparse(Int64,val[1:end-2])
                if unit == "cm"
                    if val < 150 || val > 193
                        return false
                    end
                elseif unit == "in"
                    if val < 59 || val > 76
                        return false
                    end
                else
                    return false
                end
            elseif field == "hcl"
                mtch = match(r"#[a-f0-9]{6}",val)
                if mtch == nothing
                    return false
                elseif val != mtch.match
                    return false
                end
            elseif field == "ecl"
                if ! (val  in ["amb","blu","brn","gry","grn","hzl","oth"])
                    return false
                end
            elseif field == "pid"
                mtch = match(r"[0-9]{9}",val)
                if mtch == nothing
                    return false
                elseif mtch.match != val
                    return false
                end
            end
        end
    else
        return false
    end
    true
end
        

    

function count_valid(data,validity)
    reduce(+,[validity(row) ? 1 : 0 for row in format(data)])
end

data = readlines("./files/4_passport-processing.txt")
req_fields = ["byr","iyr","eyr","hgt","hcl","ecl","pid"]

valid_passp1 = count_valid(data,validity1)

println("The number of valid passports rule 1 is : $valid_passp1")
valid_passp2 = count_valid(data,validity2)
println("The number of valid passports rule 2 is : $valid_passp2")
