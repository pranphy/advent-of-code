#!/usr/bin/env julia
# -*- coding: utf-8 -*-
# vim: ai ts=4 sts=4 et sw=4 ft=julia

# author : Prakash [प्रकाश]
# date   : 2019-12-08 23:35


orbit_dict = Dict(x[2] => x[1] for x in  map(x -> split(x,")"), readlines("./files/6orbit_info.txt")))
count_orbits(name) = name == "COM" ? 0 : 1 + count_orbits(orbit_dict[name])
total = sum(map(count_orbits,collect(keys(orbit_dict))))
println("Ths total number of orbits is $total")


transfers_needed(first,last="COM") = first == last ? 0 : 1 + transfers_needed(orbit_dict[first],last)
objects_between(first,last="COM") = first == last ? [] : [orbit_dict[first]; objects_between(orbit_dict[first],last)]
you_to_com, san_to_com = objects_between("YOU","COM"), objects_between("SAN","COM")
common = intersect(you_to_com,san_to_com)[1] # take the first common
total_dist = transfers_needed("YOU",common) + transfers_needed("SAN",common) - 2 # exclude you and san -2
println("Total transfers needed between YOU and SAN  is $total_dist")

