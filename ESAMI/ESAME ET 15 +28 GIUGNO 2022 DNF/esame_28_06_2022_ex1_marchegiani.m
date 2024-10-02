close all
clear all
clc

% inserimento dati
w = 10;
r1 = 2; r5 = 2; r6 = 2; r8 = 2;
zr1 = r1; zr5 = r5; zr6 = r6; zr8 = r8; 

r4 = 4*0.5; r3 = 4*0.5; zr4 = r4; zr3 = r3;

c1 = 1; zc1 = -j/(w*c1);

l5 = 5; zl5 = j*w*l5;

% pre trasitorio, grndezze fasoriali

i1 = 5*sqrt(2)*exp(j*pi/2);
v2 = 10*sqrt(2)*exp(j*(pi/3 + pi/2));
i3 = -2*exp(j*(pi/2 - pi/6));

% matrice del metodo delle maglie 

j4 = i3;

A = [...
    -(zr4 + zc1) -zc1 0 1 0
    -zc1 -(zc1 + zr6 + zr8) zr6 1 0
    0 zr6 -(zl5 + zr5 + zr4 + zr6) 0 0
    0 0 zr4 0 1
    1 1 0 0 0];

B = [0; v2; -v2 - j4*zr4; j4*(zr4+zr3); i1];

X = A\B; 

j1 = X(1); j2 = X(2); j3 = X(3); vi1 = X(4); vi3 = X(5);

% correnti di lato a partire da quelle di maglia 

ir1 = j1; ir8 = j2; il5 = j3; 
iv = j3 - j2; ir5 = j3; ir4 = j4 - j3;

% verifica boucherot

pu = 1/2*[zr1*abs(ir1)^2 + zc1*abs(i1)^2 + zr8*abs(ir8)^2 + zr6*abs(iv)^2 + zl5*abs(il5)^2 + zr5*abs(ir5)^2 + zr4*abs(ir4)^2 + zr3*abs(i3)^2]

pg = 1/2*[vi1*conj(i1) + v2*conj(iv) + vi3*conj(i3)]


% calcolo delle grandezze d'interesse 

vl5 = zl5*il5

maxvl5 = abs(vl5)
phivl5 = angle(vl5)

maxil5 = abs(il5)
phiil5 = angle(il5)
il5a1meno = maxil5*sin(10*1 + phiil5)

vl5a1meno= maxvl5*sin(10*1 + phiil5)

vc1 = zc1*i1

maxvc1 = abs(vc1)
phivc1 = angle(vc1)

vc1a1meno = maxvc1*sin(10*1 + phivc1)

% transotorio  circuito 1 

i1p = 1*exp(j*pi/6);
i3p = 2*sin(-j*pi/4);
v2p = 7*exp(-j*pi/3);

vc1t = zr1*i1p

maxvc1t = abs(vc1t)
phivc1t = angle(vc1t)

% transitorio circuito 2

req = r6 + r5 + r4;

tao = l5/req 

% post transotorio circuito 2
zeq = req;

icc1 = v2p/(zr6 + zr5 + zr4);

icc2 = i3p*zr4/(zr4 + zr5 + zr6);

icc = icc1 + icc2;
il5p = icc*zeq/(zeq + zl5)

maxil5p = abs(il5p)
phiil5p = angle(il5p)

k = il5a1meno - maxil5p*sin(10*1 + phiil5p)

vl5a1piu =k/tao* exp((1-1)/tao) - 10*maxil5p*cos(10*1 + k)

% PUNTO B

zeqb = [(zr1+zr8)*(zr5 + zr4 + zl5)]/(zr1+zr8+zr5 + zr4 + zl5)

icc1b = iv; 

icc2b = i1*zr1/(zr1 + zr8);

icc3b = i3*zr4/(zr4 + zl5 + zr5); 

iccb = icc1b + icc2b + icc3b

ir6b = iccb*zeqb/(zeq+zr6)

pr6b = zr6*abs(ir6b)^2

pr6 = zr6*abs(iv)^2

