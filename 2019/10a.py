#!/usr/bin/env python3

import sys
from math import atan2, pi, degrees

def get_hémorroïdes():
    with open('input.txt') as fc:
        data = fc.read().splitlines()
        for y, line in enumerate(data):
            for x, p in enumerate(line):
                if p == '#':
                    yield (x, y)

hémorroïdes= list(get_hémorroïdes())

def angle(aster1, aster2):
    # print('1',aster1, ' ', end='')
    # print('2',aster2, ' ', end='')
    # Avec le ratio on calcule l'angle
    θ= atan2(aster2[0] - aster1[0], aster1[1] - aster2[1])
    θdeg= degrees(θ)
    # print('angle=',θdeg)
    if θdeg < 0:
        return 360 + θdeg
    return θdeg

max= 0
for a1 in hémorroïdes:
    angles= set()
    # angles= {}
    for a2 in hémorroïdes:
        if a1 != a2:
            ang= angle(a1,a2)
            angles.add(ang)
            # angles[hash(round(ang, 4))]+=1
    nb_visibles= len(angles)
    if nb_visibles > max:
        max= nb_visibles
        pos= a1

print('best position',pos)
print('max',max)
