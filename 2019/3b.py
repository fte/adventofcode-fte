#!/usr/bin/env python3

import sys

fils= [];
coordonees= [];
distances_croisement= [];
pas_croisement=[];
allStepsByCoords=[];

sys.argv.pop(0);
for fil in sys.argv:
    fils.append(fil.split(','));

for num,fil in enumerate(fils):    
    pos= [0,0];
    coords= set();
    stepsByCoords= {};
    totalPas= 0;
    for dir_step in fil:
        dir= dir_step[0];
        step= int(dir_step[1:]);
        if(dir == 'R'):
            i=0;
            while i<step:
                pos[0]+= 1;
                i+=1;
                totalPas+=1;
                cur_coord= str(pos[0])+','+str(pos[1]);
                if not coords.__contains__(cur_coord):
                    coords.add(cur_coord);
                    stepsByCoords[cur_coord]= totalPas;
        elif(dir == 'L'):
            i=0;
            while i<step:
                pos[0]-= 1;
                i+=1;
                totalPas+=1;
                cur_coord= str(pos[0])+','+str(pos[1]);
                if not coords.__contains__(cur_coord):
                    coords.add(cur_coord);
                    stepsByCoords[cur_coord]= totalPas;
        elif(dir == 'U'):
            i=0;
            while i<step:
                pos[1]+= 1;
                i+=1;
                totalPas+=1;
                cur_coord= str(pos[0])+','+str(pos[1]);
                if not coords.__contains__(cur_coord):
                    coords.add(cur_coord);
                    stepsByCoords[cur_coord]= totalPas;
        elif(dir == 'D'):
            i=0;
            while i<step:            
                pos[1]-= 1;
                i+=1;
                totalPas+=1;
                cur_coord= str(pos[0])+','+str(pos[1]);
                if not coords.__contains__(cur_coord):
                    coords.add(cur_coord);
                    stepsByCoords[cur_coord]= totalPas;
        else:
            print('erreur');
    print("coord uniques ajoutees",len(coords),"fil num.",num);
    # print(num, coords);
    coordonees.append(coords);
    allStepsByCoords.append(stepsByCoords);


print("allStepsByCoords",allStepsByCoords);
for c1 in coordonees[0]:
    # print("c1",c1);
    if coordonees[1].__contains__(c1):
        print("croisement",c1);
        xy= c1.split(',');
        distances_croisement.append(abs(int(xy[0]))+abs(int(xy[1])));
        pas_croisement.append(allStepsByCoords[0][c1] + allStepsByCoords[1][c1]);


print("distances",distances_croisement);
print("distance mini", min(distances_croisement));

print("pas",pas_croisement);
print("pas mini", min(pas_croisement));