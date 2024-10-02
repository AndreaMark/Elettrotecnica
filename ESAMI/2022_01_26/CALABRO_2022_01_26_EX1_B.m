close all
clear all
clc

% inserimento dati 

w = 10;

r1 = 1; r2 = 1; r3 = 1; r4 = 1; r5 = 1; r6 = 1; r10 = 1; 
zr1 = r1; zr2 = r2; zr3 = r3; zr4 = r4; zr5 = r5; zr6 = r6; zr10 = r1; 

c1 = 1; c2 = 1; zc1 = -j/(w*c1); zc2 = -j/(w*c2);

l7 = 1; zl7 = j*w*l7;

% pre transottorio, grndezze fasoriali

v1 = 4*sqrt(2)*exp(j*pi/4); i2 = 5*exp(j*(pi/2 - pi/4));

zs1 = zr5 + zl7; zs2 = zr4 + zc2 + zr2;

% matrice del meteodo dei nodi

A = [...
    (1/zs1 + 1/zr4) -1/zs1 0 
    1/zs1 -(1/zs1 + 1/zc1) 1/zc1
    0 1/zc1 -(1/zs2 + 1/zr3 + 1/zc1)];

B = [i2; i2; v1/zr3];

X = A\B; 

va = X(1); vb = X(2); vc = X(3); 

% correnti a partire dai potenziali nodali 

il7 = (va - vb)/zs1;
ir4 = va/zr4;
ic1 = (vc - vb)/zc1;
iv = (vc + v1)/zr3;
izs = -vc/zs2;

vi2 = va - vb;

% potenze e boucherot

pr5 = zr5*abs(il7)^2;
pl7 = zl7*abs(il7)^2;
pr4 = zr4*abs(ir4)^2;
pc1 = zc1*abs(ic1)^2;
pr3 = zr3*abs(iv)^2;
pr1 = zr1*abs(izs)^2;
pc2 = zc2*abs(izs)^2;
pr2 = zr2*abs(izs)^2;

pi2 = vi2*conj(i2); 
pv1 = v1*conj(iv);

pg = 1/2*[pr5 + pl7 + pr4 + pc1 + pr3 + pr1 + pc2 + pr2]

pu = 1/2*[pi2 + pv1]
