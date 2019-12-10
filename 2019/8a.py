#!/usr/bin/env python3

import sys

pwide= 25
ptall= 6

taille= pwide * ptall
npixels= 0
pixels=[]
with open('input.txt') as desc:
    for raw in desc:
        for d in raw:
            if (d.isnumeric()):
                pixels.append( int(d) )
                npixels+=1

# print(npixels)
nlayers=int(npixels/taille)
print('nb layers', nlayers)

i= 0
f= taille
max= sys.maxsize
calc= 0
for ilayer in range(1,nlayers) :
    layer= pixels[i:f]
    # print(layer)
    i+=taille
    f+= taille
    n0s,n1s,n2s= 0,0,0
    for d in layer:
        if(d == 2):
            n2s+=1
        if(d == 1):
            n1s+=1
        if(d == 0):
            n0s+=1
    print('0s=',n0s,'1s=',n1s,'2s=',n2s)
    if n0s < max:
        max= n0s
        calc= n1s * n2s
print(calc)