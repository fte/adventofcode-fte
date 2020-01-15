#!/usr/bin/env python3

import sys, operator
from math import atan2, pi, degrees, sqrt

def get_hémorroïdes():
    with open('input.txt') as fc:
        data = fc.read().splitlines()
        for y, line in enumerate(data):
            for x, p in enumerate(line):
                if p == '#':
                    yield (x, y)

hémorroïdes= list(get_hémorroïdes())

def get_angle(aster1, aster2):
    θ= atan2(aster2[0] - aster1[0], aster1[1] - aster2[1])
    θdeg= degrees(θ)
    if θdeg < 0:
        return 360 + θdeg
    return θdeg

max= 0
for a1 in hémorroïdes:
    angles= set()
    anglesByPos= {}
    for a2 in hémorroïdes:
        if a1 != a2:
            ang= get_angle(a1,a2)
            angles.add(ang)
            anglesByPos[a2]= ang

    nb_visibles= len(angles)
    if nb_visibles > max:
        max= nb_visibles
        pos= a1

print('best position',pos)

anglesByPos= {}
# anglesByDist= {}
# distByAng= {}
distByPos= {}
# posByAngle={}
# distByAngle={}
asteroids= {}
for a in hémorroïdes:
    # print(a, end='')
    ang= get_angle(pos,a)
    # print('angle=',ang)
    distance= sqrt(sum([(a - b) ** 2 for a, b in zip(pos, a)]))
    asteroids[a]= (ang,distance)
    # anglesByPos[a]= ang
    # posByAngle[ang]= a
    # anglesByDist[distance]= ang
    # distByAng[ang]= distance
    # distByPos[a]= distance

# print(anglesByPos)

i= 0
del(asteroids[pos]) # no suicide
mindist= sys.maxsize
minang= sys.maxsize

i=0
lastVaporizedAng= -1
# print('(19,8)',asteroids[(19,8)])
# print('(16,10)',asteroids[(16,10)])
# print('(10,13)',asteroids[(10,13)])
# print('(12,13)',asteroids[(12,13)])
# print('(11,14)',asteroids[(11,14)])
# print('(19,14)',asteroids[(19,14)])

while asteroids:
    # print('len', len(asteroids))
    # print(asteroids)
    # lastVaporizedAng= -1
    # for pos1 in list(asteroids):
    mindist= sys.maxsize
    minang= sys.maxsize
    maxang= 0
    lasti= 0
    toVaporize= 0
    for p in list(asteroids):
        ang= asteroids[p][0]
        if ang > maxang:
            maxang= ang

    for pos1 in list(asteroids):
        # print(pos1,end='')
        ang1= asteroids[pos1][0]
        dist1= asteroids[pos1][1]
        # print('pos1',pos1,ang1,dist1)

        mindist= sys.maxsize
        # minang= sys.maxsize
        for pos2 in list(asteroids):
            ang2= asteroids[pos2][0]
            dist2= asteroids[pos2][1]
            # print('\tpos2',i, pos2,ang2,dist2)
            # if minang > ang2 and ang2 != lastVaporizedAng and mindist > dist2 :
            # print('minang',minang,'ang2',ang2,'lastVaporizedAng',lastVaporizedAng,'maxang',maxang)
            if minang >= ang2 and ang2 > lastVaporizedAng:
                if minang == ang2 and mindist >= dist2:
                    minang= ang2
                    mindist= dist2
                    minpos= pos2
                    # print('\t\tmini minang==ang2 ',i, minpos,minang,mindist)
                
                if minang > ang2:
                    minang= ang2
                    mindist= dist2
                    minpos= pos2
                    # print('\t\tmini minang>ang2',i, minpos,minang,mindist)
                
        # print('before',i,pos1, ang1,'ang1==minang', minang, 'and ', dist1,'dist1==mindist', mindist,'and', ang1, 'ang1!=lastvap', lastVaporizedAng)
        if ang1 == minang and dist1 == mindist and ang1 > lastVaporizedAng:
            i+= 1
            if ang1 >= maxang:
                lastVaporizedAng= -1
            else:
                lastVaporizedAng= ang1
            
            # print('after',i, ang1,'ang1==minang', minang, 'and ', dist1,'dist1==mindist', mindist,'and', ang1, 'ang1!=lastvap', lastVaporizedAng)
            # print(i, 'vapor',pos1, 'angle', lastVaporizedAng, 'calc', 100*pos1[0]+pos1[1])
            print(i, 'vapor',pos1, 100*pos1[0]+pos1[1])
            # print(i, 'vapor',pos1, 100*pos1[0]+pos1[1],'a1',ang1,'d1',dist1,'lasta',lastVaporizedAng)
            asteroids.pop(pos1)
            mindist= sys.maxsize
            minang= sys.maxsize