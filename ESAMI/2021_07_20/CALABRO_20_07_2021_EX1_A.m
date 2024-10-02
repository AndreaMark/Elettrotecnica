close all
clear all
clc

% inserimento dati

w= 10;

r1 = 1; r2 = 4; r3 = 1; r4 = 1; r5 = 1; r6 = 1; 
zr1 = r1; zr2 = r2; zr3 = r3; zr4 = r4; zr5 = r5; zr6 = r6; 

l1 = 1; zl1 = j*l1*w; 

c3 = 1; zc3 = -j/(w*c3);

% pre transitorio 1, grandezze fasoriali 

i2 = (6/2)*exp(j*(pi/2 - pi/6 - pi)); 
v1 = sqrt(2)*exp(j*pi/6); 

j4 = i2;
% matrice delle correnti di maglia 

A = [...
    -(zc3 + zr1 + zr3) zr1 zr3 0
    zr1 -(zr1 + zr5 + zl1) zl1 0
    zr3 zl1 -(zr3 + zl1 + zr4) 0
    -zr3 -zl1 (zl1 + zr3) 1];

C = cond(A)

B = [j4*zr3; -v1+(j4*zl1); -j4*(zl1+zr3); j4*(zr2+zr3+zl1)];

X = A\B;

j1 = X(1); j2 = X(2); j3 = X(3); vi2 = X(4); 

% correnti di lato  partiere da uelle di maglia 

ic3 = j1; iv = j2; ir4 = j3; 

ir1 = j2-j1; il1 = j2+j4-j3; ir3 = j1+j4-j3; 

% potenze 

pc3 = zc3*abs(ic3)^2;
pr5 = zr5*abs(iv)^2;
pr4 = zr4*abs(ir4)^2;
pr2 = zr2*abs(i2)^2;
pr1 = zr1*abs(ir1)^2;
pl1 = zl1*abs(il1)^2;
pr3 = zr3*abs(ir3)^2;

pv1 = v1*conj(iv);
pi2 = vi2*conj(i2); 

pu = 1/2*[pc3 + pr5 + pr4 + pr2 + pr1 + pl1 + pr3]
pg = 1/2*[pv1 + pi2]
