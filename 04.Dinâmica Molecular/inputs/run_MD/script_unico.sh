#!/bin/bash

if [ -r /usr/share/modules/init/bash ]; then
    source /usr/share/modules/init/bash
fi

module load amber/AT19A18

pmemd.cuda -O -i min1.in  -p 5GGS_capeado_solvated.prmtop -o min1.out -c 5GGS_capeado_solvated.rst7 -x min1.nc -r min1.rst  -ref 5GGS_capeado_solvated.rst7                     
pmemd.cuda -O -i min2.in  -p 5GGS_capeado_solvated.prmtop -o min2.out -c min1.rst -r min2.rst -ref min1.rst              
pmemd.cuda -O -i heat.in  -p 5GGS_capeado_solvated.prmtop -o heat.out -c min2.rst -r heat.rst -x heat.nc -ref min2.rst             
pmemd.cuda -O -i dens.in  -p 5GGS_capeado_solvated.prmtop -o dens.out -c heat.rst -r dens.rst -x dens.nc -ref heat.rst                 
pmemd.cuda -O -i equ.in   -p 5GGS_capeado_solvated.prmtop -o equ.out  -c dens.rst -r equ.rst  -x equ.nc  -ref dens.rst    

echo "Terminou a Equilibração"

echo "vai começar a produção"
pmemd.cuda -O -i mdPROD.in -p 5GGS_capeado_solvated.prmtop -o mdProd1.out -c equ.rst -r mdProd1.rst -x mdProd1.nc

echo "Terminou!"
