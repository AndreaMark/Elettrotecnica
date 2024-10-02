clear all
close all
clc

tic
% Inserimento dati 

w = 10;

r2 = 1; r3 = 5; r4 = 1; r5 = 1; r6 = 1; l1 = 0.1; l3 = 0.1; c2 = 0.1;
zr2 = r2; zr3 = r3; zr4 = r4; zr5 = r5; zr6 = r6; zl1 = j*w*l1; zl3 = j*w*l3; zc2 = -j/(w*c2);

% pre transitorio TUTTE LE GRANDEZZE SI INTENDONO FASORIALI

i2 = 2*sqrt(2)*exp(j*(pi/2-pi/3)); v = 6*sqrt(2)*exp(-j*pi/3);

zrp = (zr2*zr5)/(zr2+zr5); 

% matrice del metodo delle maglie 

A = [...
    -(zl1 + zr3 + zl3 + zrp) zr3 -(zl3 + zrp) zrp 1
    zr3 -(zr3 + zr4) 0 0 -1
    -(zl3 + zrp) 0 -(zl3 + zc2 + zrp) zrp 1
    zrp 0 zrp -(zrp + zr6) 0
    1 -1 1 0 0];

B = [0; 0; 0; v; i2];

X = A\B;

j1 = X(1); j2 = X(2); j3 = X(3); j4 = X(4); vi2 = X(5);

% correnti a partire dalle correnti di maglia 

il1 = -j1; 
ir3 = j1 - j2;
ir4 = -j2; 
il3 = j3 + j1; 
ic2 = j3; 
irp = -j4 + j3 + j1; 
iv = -j4; 

% Potenze utilizzatori 

pl1 = zl1*abs(il1)^2;
pr3 = zr3*abs(ir3)^2;
pr4 = zr4*abs(ir4)^2;
pl3 = zl3*abs(il3)^2;
pc2 = zc2*abs(ic2)^2;
prp = zrp*abs(irp)^2;
pr6 = zr6*abs(iv)^2;

% potenze generatori

pi2 = vi2*conj(i2);
pv = v*conj(iv);

% verifica boucherot

pu = 1/2*[pl1 + pr3 + pr4 + pl3 + pc2 + prp + pr6]
pg = 1/2*[pi2 + pv]

% calcolo delle continuita delle variabili di stato 

vc2 = zc2 * ic2;
maxvc2 = abs(vc2)
phivc2 = angle(vc2)

vc2a1meno = maxvc2*sin(10*1 + phivc2)

maxil1 = abs(il1)
phiil1 = angle(il1)
il1a1meno = maxil1*sin(10*1 + phiil1)

maxir3 = abs(ir3)
phiir3 = angle(ir3)
ir3a1 = maxir3*sin(10*1 + phiir3)

% transitorio con LKT ed LKC dominio del tempo

tao = r3*c2 

% post transitorio dominio fasori

i2post = 2*exp(j*pi/3);

ic2post = i2post*(zr3/(zr3 + zc2));

vc2post = zc2*ic2post; 

maxvc2post = abs(vc2post)
phivc2post = angle(vc2post)

k = vc2a1meno - maxvc2post*sin(10*1 + phivc2post)

% calcolo di ir3 post trasitorio dominio del tempo 

kir3post = -k/r3
maxir3post = -maxvc2post/r3

ir3a1post = kir3post + maxir3post*sin(10*1 + phivc2post)
toc
