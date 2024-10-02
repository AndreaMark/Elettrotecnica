clear all
close all
clc

% inserimento dati 

w= 10;

r1 = 1; r2 = 1; r3 = 1; r4 = 1; r5 = 1; r6 = 1; l2 = 0.1; c1 = 1; c3 = 1; c4 = 1; 

zr1 = r1; zr2 = r2; zr3 = r3; zr4 = r4; zr5 = r5; zr6 = r6; zc1 = -j/(w*c1); zc3 = -j/(w*c3); zc4 = -j/(w*c4); zl2 = j*w*l2; 

% pre transitorio 1 grandezze fasoriali 

i2 = sqrt(2)*exp(j*0); 
v1 = 3*exp(j*(pi/2 + pi/6));

zs = zr6 + zr2 + zl2;

% Matrice del metodo dei nodi

A = [...
    -(1/zc1 + 1/zr5) 0 1/zc1 1/zr5
    0 -(1/zr3 + 1/zc4) 1/zc4 0
    1/zc1 1/zc4 -(1/zc4 + 1/zr2 + 1/zc1) 0
    1/zr5 0 0 -(1/zr5 + 1/zc3 + 1/zs)];

B = [i2; -i2; 0; v1/zs];

X = A\B;

va = X(1); vb = X(2); vc = X(3); vd =X(4);

% correnti a partire dai potenziali nodali va vb vc vd

ic3 = -vd/zc3;
iv = (vd + v1)/zs;
ir3 = -vb/zr3;
ir2 = -vc/zr2;
ic4 = (vb - vc)/zc4; 
ic1 = (vc - va)/zc1;
ir5 = (va - vd)/zr5;

vi2 = vb - va + i2*zr2;

% potenze utilizzatori

pr4 = zr4*abs(iv)^2;
pr6 = zr6*abs(iv)^2;
pl2 = zl2*abs(iv)^2;
pr5 = zr5*abs(ir5)^2;
pc1 = zc1*abs(ic1)^2;
pr1 = zr1*abs(i2)^2;
pc4 = zc4*abs(ic4)^2;
pr2 = zr2*abs(ir2)^2;
pr3 = zr3*abs(ir3)^2;
pc3 = zc3*abs(ic3)^2;

% potenze generatori

pi2 = vi2*conj(i2);
pv1 = v1*conj(iv); 

pu = 1/2*[pr4+pr6+pl2+pr5+pc1+pr1+pc4+pr2+pr3+pc3]
pg = 1/2*[pi2+pv1]

% calcolo delle variabili d'interesse e della continutà

il2 = iv 

maxil2 = abs(il2)
phiil2 = angle(il2)

il2a0meno = maxil2*sin(10*0 + phiil2)

vc3 = zc3*ic3
maxvc3 = abs(vc3)
phivc3 = angle(vc3)

vc3a0meno = maxvc3*sin(10*0 + phivc3)

% transitorio 1 circuito 1
req = r6;

tao1 = req*c3

% post transitorio 1 circuito 1, grandezze fasoriali

v0 = i2*zr6; zeq = req;

ip = v0/(zc3 + zeq);

vc3p1 = ip*zc3

maxvc3p1 = abs(vc3p1)
phivcep1 = angle(vc3p1)

k = vc3a0meno - maxvc3p1*sin(10*0 + phivcep1)

% transotorio 1 circuito 2 

v1p = 1;

tao2 = l2/r4

% post transitorio 1 ciruito 2

il2p = v1p/r4

k = il2a0meno - il2p

% continuità

il2a1meno = il2p

% transotorio 2 e post transotorio 2 circuito 2

tao3 = l2/r4

k = il2a1meno 




 