clear all
close all
clc

% inserimento dati 
w = 10;

r1 = 1; r2 = 1; r3 = 1; r4 = 1; r5 = 1; 

zr1 = r1; zr2 = r2; zr3 = r3; zr4 = r4; zr5 = r5;

c2 = 0.2; c3 = 0.2; zc2 = -j/(w*c2); zc3 = -j/(w*c3);

l = 0.3; zl = j*w*l; 

% pre transitorio 1 

v1 = 4; v3 = 2*sqrt(2)*exp(-j*pi/3); i2 = 4*exp(j*pi/4); 

% matrice del metodo delle maglie circuito 1

A = [...
    -(zr5 + zr4 + zc2) zr5 0
    zc2 zr2 1
    zr5 -(zc3 + zr2 + zr5) 0];

j2 = i2; 

B = [-j2*zc2; j2*(zr3 + zr2 + zc2); -j2*zr2 - v3];

X = A\B; 

j1 = X(1); j3 = X(2); v2 = X(3); 

% correnti di lato a partire da quelle di maglia circuito 1

i3 = j3; 
ir4 = j1; 
ir2 = j2 - j3; 
ir5 = j3 - j1; 
ic2 = j2 - j1; 


% verfico boucherot circuito 1 

pu = (1/2)*[zc3*abs(i3)^2 + zr3*abs(i2)^2 + zr2*abs(ir2)^2 + zr5*abs(ir5)^2 + zr4*abs(ir4)^2 + zc2*abs(ic2)^2]

pg = (1/2)*[v3*conj(i3) + v2*conj(i2)]

% circuito 2, corrente e conservazione energia

il1 = v1/r1

pu2 = r1*il1^2 
pg2 = v1*il1

% calcolo delle grandezze d'interesse e continuità

ilpa0meno = il1

v2
maxv2 = abs(v2)
phiv2 = angle(v2)
v2a0meno = maxv2*sin(w*0 + phiv2)

vc2 = zc2*ic2
maxvc2 = abs(vc2)
phivc2 = angle(vc2)
vc2a0meno = maxvc2*sin(w*0 + phivc2)

% transotorio 1 

rp = r1*r2/(r1+r2); rs = r3 + r4 + r5; 

req = rp;

tao1 = l/req

% prima soluzione a regime 

zrp = rp; zeq = req;

v1p = 4*exp(j*(pi/2 - 2*pi/3)); v3p = 0; i2p = 3*sqrt(2)*exp(j*(pi/2 - pi/6));

icc1 = -i2p; icc2 = v1p/zrp; i0 = icc1 + icc2, ilp = i0*(zeq/(zeq+zl))

maxilp = abs(ilp)
phiilp = angle(ilp)
k1 = ilpa0meno - maxilp*sin(w*0 + phiilp)



%tensione sul generatore i2

ilpfas = maxilp*exp(j*phiilp)

iprovv = ilpfas + i2;

maxiprovv = abs(iprovv), phiiprovv = angle(iprovv)
k1*rp, maxiprovv*rp, i2*rs 

vrpprovv = (maxiprovv*rp)*exp(j*phiiprovv);

i2*rs + vrpprovv; abs(i2*rs + vrpprovv), angle(i2*rs + vrpprovv)

% in 0 quanto vale vi2?

vi2a0piu = k1*rp + abs(i2*rs + vrpprovv)*sin(w*0 + angle(i2*rs + vrpprovv))

% continuità nel transtorio 2

vi2a5meno = abs(i2*rs + vrpprovv)*sin(w*5 + angle(i2*rs + vrpprovv))
ilpa5meno = maxilp*sin(w*5 + phiilp)

% transitorio 2 

tao2 = l/rp

k2 = ilpa5meno

k2*rp  



