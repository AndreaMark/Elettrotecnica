clear all
close all
clc


% inserimento dati

w=10;

r1 = 1; r2 = 1; r3 = 1; r4 = 1; r5 = 1; r6 = 1; r10 = 1; c1 = 1; c2 = 1; l7 = 1;

zr1 = r1; zr2 = r2; zr3 = r3; zr4 = r4; zr5 = r5; zr6 = r6; zr10 = r10; zc1 = -j/(w*c1); zc2 = -j/(w*c2); zl7 = j*w*l7; 

% pre transittorio, grandezze fasoriali 

v1 = 4*sqrt(2)*exp(j*pi/4); i2 = 5*exp(j*(pi/2 -pi/4)); 

% MAtrice del metodo delle maglie 

A = [...
    -(zl7 + zr5) 0 0 1
    0 -(zr4 + zc1 + zr3) zr3 1 
    0 zr3 -(zr3 + zr1 + zc2 + zr2) 0
    1 1 0 0];

B = [0; v1; -v1; i2];

X = A\B; 

j1 = X(1); j2 = X(2); j3 = X(3); vi2 = X(4);

% Correnti di lato a partire dalle correnti di maglia 

il7 = j1; ir4 = j2; ic1 =  j2  ; iv = j3 - j2; ir1 = j3; 

% potenze utilizzatori

pz5 = zr5*abs(il7)^2;
pl7 = zl7*abs(il7)^2;
pr4 = zr4*abs(ir4)^2;
pc1 = zc1*abs(ic1)^2;
pr3 = zr3*abs(iv)^2;
pr1 = zr1*abs(ir1)^2;
pc2 = zc2*abs(ir1)^2;
pr2 = zr2*abs(ir1)^2;

% potenze generatori

pi2 = vi2*conj(i2); 
pv1 = v1*conj(iv);

% verigica boucherot 

pu = 1/2*[pz5 + pl7 + pr4 + pc1 + pr3 + pr1 + pc2 + pr2]

pg = 1/2*[pi2 + pv1]

verifica = pg-pu

% calcolo delle grandezze d'interesse e della continutà

vc2 = ir1*zc2; 

maxvc2 = abs(vc2)
phivc2 = angle(vc2)

vc2a0meno = maxvc2*sin(10*0 + phivc2)

maxil7 = abs(il7)
phiil7 = angle (il7)

il7a0meno = maxil7*sin(10*0 + phiil7)

% transitori

taoL = l7/r5

taoC = (r1+r3+1)/(r1*r2 + r2*r3 + r1 +1)


% post transitorio circuito 1 grandezze fasoriali

i2p = 6*exp(j*(pi/2 - pi/6)); 

il7p = i2*(zr6/(zr6+zr5+zl7));

maxil7p = abs(il7p)
phiil7p = angle(il7p)

k1 = il7a0meno - maxil7p*sin(10*0 + phiil7p)

% post transitorio circuito 2; grandezze fasoriali 

v1p = 5*sqrt(2)*exp(j*pi/6);

iv = v1p/(zr1 + zr3);

ip2 = iv*zr10/(zr10 + zc2 + zr2);

vc2p = zc2*ip2;

maxvc2p = abs(vc2p)
phivc2p = angle(vc2p)

k2 = vc2a0meno - maxvc2p*sin(10*0 + phivc2p)



