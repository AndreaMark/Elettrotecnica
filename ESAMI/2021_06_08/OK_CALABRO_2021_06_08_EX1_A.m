clear all
close all
clc

% inserimento dati
w=10;
r1 = 1; r4 = 1; r5 = 1; r6 = 1; r2 = 2; r3 = 2; l1 = 1; l4 = 1; c2 = 1; c3 = 1;

zr1 = r1; zr2 = r2; zr3 = r3; zr4 = r4; zr5 = r5; zr6 = r6; 

zl1 = j*w*l1; zl4 = j*w*l4; zc2 = -j/(w*c2); zc3 = -j/(w*c3);

% pre transitorio GRANDEZZE FASORIALI

i2 = exp(j*pi/2); v1 = 2*exp(j*0); 

zrp = (zr2*zr3)/(zr2+zr3); 


% Matrice del moetodo delle correnti di maglia

A = [...
    -(zr1 + zrp + zl1) zrp -zrp 0 0
    zrp -(zrp + zc2 + zr6) (zrp + zr6) zr6 0
    -zrp (zrp + zr6) -(zl4 + zrp +zr6) -zr6  1
    0 zr6 -zr6 -(zr6 + zc3) 1
    0 0 1 1 0];

B = [-v1; 0; 0; 0; i2];

X = A\B;

j1 = X(1); j2 = X(2); j3 = X(3); j4 = X(4); vi2 = X(5);

% correnti a partire dalle correnti di maglia

iv = j1;
irp = j1 - j2 + j3;
ic2 = j2;
il4 = j3;
ir6 = j2 - j3 - j4;
ic3 = j4;

% Potenze utilizzatori

pr1 = zr1*abs(iv)^2;
pl1 = zl1*abs(iv)^2;
prp = zrp*abs(irp)^2;
pr6 = zr6*abs(ir6)^2;
pc2 = zc2*abs(ic2)^2;
pl4 = zl4*abs(il4)^2;
pc3 = zc3*abs(ic3)^2;

% potenze generatori

pv1 = v1*conj(iv);
pi2 = vi2*conj(i2);

% verifica boucherot

pu = 1/2*[pr1 + pl1 + prp + pr6 + pc2 + pl4 + pc3]
pg = 1/2*[pv1 + pi2]

% calcolo e continutà delle variabili di stato richieste

il1 = iv; 

maxil1 = abs(il1)
phiil1 = angle(il1)

il1a0meno = maxil1*sin(10*0 + phiil1)

% transitorio DOMINIO DEL TEMPO

rs = r3 + r4 + r5; rp = (rs*r2)/(rs+r2);

tao = l1/(rp + r1)

% post transitorio DOMINIO DEI FASORI

v1post = 3*exp(j*(pi/2+pi/3)); zrp = rp; 

il1p = v1post/(zl1 + zr1 + zrp); 

maxil1post = abs(il1p)
phiil1post = angle(il1p)

% faccio valere la continutà

k = il1a0meno - maxil1post*sin(10*0 + phiil1post)

% circuto resistivo associato e norton dominio del tempo

req = r2 + r4 + r3; 

ricc1 = (r2/(r2+r4+r3))

rnorton = req/(req + r5)

rir5 = ricc1*rnorton

kir5 = k*rir5

maxir5 = maxil1post*rir5

ir5a0 = kir5 + maxir5*sin(10*0 + phiil1post)





