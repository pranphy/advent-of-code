#!/usr/bin/env julia
# -*- coding: utf-8 -*-
# vim: ai ts=4 sts=4 et sw=4 ft=julia

# author : Prakash [प्रकाश]
# date   : 2019-12-08 23:35


orbit_dict = Dict(x[2] => x[1] for x in  map(x -> split(x,")"), readlines("./files/6orbit_info.txt")))
count_orbits(name) = name == "COM" ? 0 : 1 + count_orbits(orbit_dict[name])
total = sum(map(count_orbits,collect(keys(orbit_dict))))
print("Ths total number of orbits is $total")

