#!/usr/bin/env python3

import sys

fils= []
coordonees= []
distances_croisement= []


sys.argv.pop(0)
for fil in sys.argv:
    fils.append(fil.split(','))

# print("fils:",len(fils))
for num,fil in enumerate(fils):    
    # print(num)
    pos= [0,0]
    # coords= []
    coords= set()
    for dir_step in fil:
        # print('.')
        dir= dir_step[0]
        step= int(dir_step[1:])
        if(dir == 'R'):
            i=0
            while i<step:
                pos[0]+= 1
                i+=1
                cur_coord= str(pos[0])+','+str(pos[1])
                if not coords.__contains__(cur_coord):
                    coords.add(cur_coord)
        elif(dir == 'L'):
            i=0
            while i<step:
                pos[0]-= 1
                i+=1
                cur_coord= str(pos[0])+','+str(pos[1])
                if not coords.__contains__(cur_coord):
                    coords.add(cur_coord)
        elif(dir == 'U'):
            i=0
            while i<step:
                pos[1]+= 1
                i+=1
                cur_coord= str(pos[0])+','+str(pos[1])
                if not coords.__contains__(cur_coord):
                    coords.add(cur_coord)
        elif(dir == 'D'):
            i=0
            while i<step:            
                pos[1]-= 1
                i+=1
                cur_coord= str(pos[0])+','+str(pos[1])
                if not coords.__contains__(cur_coord):
                    coords.add(cur_coord)
        else:
            print('erreur')
    print("coord uniques ajoutees",len(coords),"fil num.",num)
    # print(num, coords)
    coordonees.append(coords)

for c1 in coordonees[0]:
    # print("c1",c1)
    if coordonees[1].__contains__(c1):
        print("croisement",c1)
        xy= c1.split(',')
        distances_croisement.append(abs(int(xy[0]))+abs(int(xy[1])))

print("distances",distances_croisement)
print("distance mini", min(distances_croisement))