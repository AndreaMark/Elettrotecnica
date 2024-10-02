close all
clear all
clc

% insermento dati
w = 10;
r1 = 1; r4 = 1; r5 = 1; r6 = 1;
zr1 = r1; zr4 = r4; zr5 = r5; zr6 = r6;

r2 = 2; r3 = 2; zr2 = r2; zr3 = r3;

l1 = 1; l4 = 1; zl1 = j*w*l1; zl4 = j*l4*w;

c3 = 1; c2 = 1; zc3 = -j/(w*c3); zc2 = -j/(w*c2);

% pretransitorio, grndezze fasooriali 

i2 = exp(j*pi/2); v1 = 2*exp(j*0); 

zrp = (zr2^-1 + zr3^-1)^-1; zs = zl1 + zr1;

% matrice del potenziali nodali

A = [...
   -(1/zrp + 1/zc3 + 1/zs + 1/zr6) 1/zr6 1/zc3
   1/zr6 -(1/zr6 + 1/zc2) 0
   -1/zc3 0 (1/zl4 + 1/zc3)];

B = [v1/zs; i2; i2];

X = A\B;

va = X(1); vb = X(2); vc = X(3); 

% correnti a artire dali potenxziali nodali 

iv = (va+v1)/zs; 
irp = -va/zrp; 
ic2 = -vb/zc2;
il4 = vc/zl4; 
ir6 = (va-vb)/zr6; 
ic3 = (vc-va)/zc3; 

vi2 = vc - vb;

% potenze e verifica di boucherot 

pu = 1/2*[zs*abs(iv)^2 + zrp*abs(irp)^2 + zc2*abs(ic2)^2 + zr6*abs(ir6)^2 + zc3*abs(ic3)^2 + zl4*abs(il4)^2]

pg = 1/2*[v1*conj(iv) + vi2*conj(i2)]

% transitorio

rst = r4 + r3 + r5; rpt = (rst*r2)/(rst + r2); rst2  = rpt + r4; 

tao = l1/rst2 