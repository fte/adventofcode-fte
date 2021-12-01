#!/usr/bin/env python3

import sys

with open('input1a.txt') as f:
    aProfondeurs = f.read().splitlines()

iMesuresCroissantes = -1
iMesurePrecedente = 0
for profondeur in aProfondeurs:
    if int(profondeur) > int(iMesurePrecedente):
        iMesuresCroissantes += 1 
    iMesurePrecedente = profondeur

print(iMesuresCroissantes)