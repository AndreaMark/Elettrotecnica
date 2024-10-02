close all
clear all
clc

% inserimento dati 
w = 10;
r1 = 1; r2 = 1; r3 = 1; r4 = 1; r5 = 1; r6 = 1; 
zr1 = r1; zr2 = r2; zr3 = r3; zr4 = r4; zr5 = r5; zr6 = r6;

l2 = 0.1; zl2 = j*w*l2;

c1 = 1; c3 = 1; c4 = 1; zc1 = -j/(w*c1); zc3 = -j/(w*c3); zc4 = -j/(w*c4);

% pre trasotorio, grndezze fasoriali

i2 = sqrt(2)*exp(j*0); v1 = 3*exp(j*(pi/6 + pi/2));

zs = zr4 + zr5 + zl2; 

% matrice del meetdo delle maglie 

A = [...
    -(zc1 + zc4 + zr1) zc4 zr1 0 1
    zc4 -(zc4 + zr2 + zr3) zr3 0 0 
    zr1 zr3 -(zr1 + zr3 + zc3 + zr5) zc3 -1
    0 0 zc3 -(zc3 + zs) 0
    1 0 -1 0 0];

B = [0; 0; 0; -v1; i2];

X = A\B; 

j1 = X(1); j2 = X(2); j3 = X(3); j4 = X(4); vi2 = X(5); 

% correnti di lato a partire da quelle di maglia

ir3 = j2 - j3; ic4 = j1 - j2; ic3 = j4 - j3; 
ic1 = j1; ir2 = j2; iv = j4; ir5 = j3; 

% boucherot e conservazione delle potenze 

pu = 1/2*[zc1*abs(ic1)^2 + zr1*abs(i2)^2 + zc4*abs(ic4)^2 + zr3*abs(ir3)^2 + zr2*abs(ir2)^2 + zr5*abs(ir5)^2 + zc3*abs(ic3)^2 + zs*abs(iv)^2]

pg = 1/2*[vi2*conj(i2) + v1*conj(iv)]

% transotorio 1

req = r6; tao1 = req*c3, 

tao2 = l2/r4 

tao3 = l2/r4