clear all
close all
clc

%%%% L'HAI GIà FATTO COL METODO DELLE MAGLIE COME SIMULAZIONE ESAME IL
%%%% 31/0/2022. MILITATO A VERIFICARE BOUCHEROT.

tic
% Inserimento dati 

w = 10;

r2 = 1; r3 = 5; r4 = 1; r5 = 1; r6 = 1; l1 = 0.1; l3 = 0.1; c2 = 0.1;
zr2 = r2; zr3 = r3; zr4 = r4; zr5 = r5; zr6 = r6; zl1 = j*w*l1; zl3 = j*w*l3; zc2 = -j/(w*c2);

% pre transitorio TUTTE LE GRANDEZZE SI INTENDONO FASORIALI

i2 = 2*sqrt(2)*exp(j*(pi/2-pi/3)); v = 6*sqrt(2)*exp(-j*pi/3);

zrp = (zr2*zr5)/(zr2+zr5); 

% matrice dei potenziali nodali

A = [...
-(1/zr3 + 1/zl1 + 1/zr4) 1/zr3 1/zr4 0
-1/zr3 (1/zr3 + 1/zc2) 0 0 
1/zr4 0 -(1/zr4 + 1/zl3) 1/zl3
0 0 1/zl3 -(1/zl3 + 1/zrp + 1/zr6)];

B = [0; i2; i2; v/zr6];

X = A\B;

va = X(1); vb = X(2); vc = X(3); vd = X(4);

% correnti a partire dai potenziali nodali

ic2 = vb/zc2;
il1 = -va/zl1;
irp = -vd/zrp;
iv = (vd+v)/zr6;
ir3 = (vb-va)/zr3;
ir4 = (va-vc)/zr4; 
il3 = (vc-vd)/zl3;

% tensione sul generatore di corrente 

vi2 = vb - vc;

% Conservazione delle potenze

pl1 = zl1*abs(il1)^2;
pr3 = zr3*abs(ir3)^2;
pr4 = zr4*abs(ir4)^2;
pl3 = zl3*abs(il3)^2;
prp = zrp*abs(irp)^2;
pc2 = zc2*abs(ic2)^2;
pr6 = zr6*abs(iv)^2;

pi2 = vi2*conj(i2);
pv = v*conj(iv);

pu = 1/2*[pl1+pr3+pr4+pl3+prp+pc2+pr6]

pg = 1/2*[pi2+pv]


