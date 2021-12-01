#!/usr/bin/env python3

import sys

with open('input1a.txt') as f:
    aStrProfondeurs = f.read().splitlines()

aProfondeurs = [int(x) for x in aStrProfondeurs]
iMesuresCroissantes = 0
# print(aProfondeurs)
for i in range(len(aProfondeurs)):
    # print(aProfondeurs[i])
    if i >= 3 and aProfondeurs[i] + aProfondeurs[i-1] + aProfondeurs[i-2] > aProfondeurs[i-1] + aProfondeurs[i-2] + aProfondeurs[i-3]:
        iMesuresCroissantes += 1

print(iMesuresCroissantes)
