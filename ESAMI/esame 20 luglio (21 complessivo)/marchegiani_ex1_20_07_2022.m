clear all
close all
clc

% inserimento dati

w= 10; 

r1 = 5; r3 = 5; r2 = 1; r4 = 1; r7 = 1; c1 = 0.1; c6 = 0.3; l5 = 0.1; r8 = 10; r9 = 10; r10 = 10; 

zr1 = r1; zr3 = r3; zr2 = r2; zr4 = r4; zr7 = r7; zc1 = -j/(w*c1); zc6 = -j/(w*c6); zr8 = r8; zr9 = r9; zr10 = r10; zl5 = j*w*l5;

% pre traansotorio 1, grandezze fasoriali


v1 = 3*exp(j*(pi/2 + pi/4)); i2 = 4*exp(j*(pi/2 - 2*pi/4)); 

% matrice del metodo delle correnti di maglia 

A = [...
    -(zr4 + zl5 + zr3) zr4 -zr3 0
    -zr4 zr4 0 1
    zr4 -(zr4 + zc6 + zr7 + zc1) -zc1 0
    -zr3 -zc1 -(zc1 + zr1 + zr3) 0];

j2 = i2; 

B = [j2*zr4; j2*(zr4 + zr2); -(v1+j2*(zr4)); -v1];

X = A\B;

j1 = X(1); j3 = X(2); j4 = X(3); v2 = X(4); 

% correnti di lato a partire da quelle di maglia 

il5 = j1; ir1 = j4; irc = j3; ir4 = j3 - j2 - j1; i1 = j3 + j4; ir3 = j4 - j1; 

% verifica di boucherot

pu = (1/2)*[zr1*abs(ir1)^2 + zr7*abs(irc)^2 + zc6*abs(irc)^2 + zr2*abs(i2)^2 + zr3*abs(ir3)^2 + zl5*abs(il5)^2 + zr4*abs(ir4)^2 + zc1*abs(i1)^2]

pg = (1/2)*[v2*conj(i2) + v1*conj(i1)]

% calcolo della continuità e delle varaiabili d'interesse 

ic1 = i1
maxic1= abs(ic1)
phiic1 = angle(ic1)

ic1a0meno = maxic1*sin(w*0 + phiic1)

vc1 = i1*zc1

maxvc1 = abs(vc1)
phivc1 = angle(vc1)

vc1a0meno = maxvc1*sin(w*0 + phivc1)

% transitorio 1 

req = r3 + r1; 

tao1 = c1*req

% s0luzione a regime 1

v11 = 2*sqrt(2)*exp(j*(pi/2 + pi/6)); i21 = 5*sqrt(2)*exp(j*0); 

v01 = v11; v02 = i21*zr2; zeq = req; v0 = v01 + v02; 

vcp = v0*(zc1/(zc1 + zeq))

maxcvcp = abs(vcp)
phivcp = angle(vcp)

k = vc1a0meno - maxcvcp*sin(w*0 + phivcp)

icct = il5 + i21

maxicct = abs(icct)
phiicct = angle(icct)

iccta5meno = maxicct*sin(w*5 + phiicct)

% continutità in 5 

vc1a5meno = maxcvcp*sin(w*5 + phivcp)


% pre + transitorio 2 

v12 = 6;

rp = r3*r9/(r3 + r9); 
rs = rp + r1; 

req1 = r10*rs/(r10 + rs);

tao2 = req1*c1

k2 = vc1a5meno - v12

% PUNTO 2

zs = zl5 + zl5 + zr7; zp = zs*zr1/(zs+zr1); zeq2 = zp + zs

v012 = v1; 

zs2 = zr2 + zr3 + zr1 + zr7 + zl5; zeq3 = zl5*zs2/(zl5+zs2); 

v022 = zeq3*i2; V02 = v022 + v012

zeq4 = zeq2 + zc1; I2 = V02/zeq4

pc1 = zc1*abs(I2)^2



