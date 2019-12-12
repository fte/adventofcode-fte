#!/usr/bin/env python3

import sys

pwide= 25
ptall= 6
# pwide= 2
# ptall = 2

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
# print('nb layers', nlayers)

img= pixels[0:taille]
for nl in range(1,nlayers):
    lay= pixels[taille*nl:taille*nl+taille]
    # print(lay)
    for i in range(taille):
        # print(lay[i], end='')
        if img[i] == 2 :
            img[i]= lay[i]
print(img)

pos=0
for i in range(ptall):
    for j in range(pwide):
        pos= j+pwide*i
        if img[pos] == 0:
            print('X', end='')
        else:
            print(' ', end='')
    print()    