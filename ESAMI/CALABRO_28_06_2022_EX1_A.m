clear all
close all
clc

% inserimento dati 
w = 10;

r1 = 2; r5 = 2; r6 = 2; r8 = 2; 
zr1 = r1; zr5 = r5; zr6 = r6; zr8 = r8; 

r4 = 4*0.5; r3 = 4*0.5;
zr4 = r4; zr3 = r3; 

c1 = 1; l5 = 5; zc1 = -j/(w*c1); zl5 = j*w*l5; 

% pre transotorio, gradezze fasoriali 

i1 = 5*sqrt(2)*exp(j*pi/2); 
v2 = 10*sqrt(2)*exp(j*(pi/3 + pi/2));
i3 = -(4/2)*exp(j*(pi/2 - pi/6)); 

% matrice del metodo delle maglie 

A = [...
    zr1 0 1 0
    -(zr1 + zr8 + zr6) zr3 0 0
    zr6 -(zr6 + zr5 + zr4 + zl5) 0 0
    0 zr4 0 1];
 
j1 = i1; j4 = i3; 

B = [j1*(zr1 + zc1); v2 - j1*zr1; -(v2+j4*zr4); j4*(zr3 + zr4)];

X = A\B; 

j2 = X(1); j3 = X(2); v1 = X(3); v3 = X(4); 

% correnti di lato a partire da quele di maglia 

ir1 = j2 - j1; ir8 = j2; iv = j3-j2; ir5 = j3; il5 = j3; ir4 = j4 - j3; 

% verifico boucherot 

pu = 1/2*[zr1*abs(ir1)^2 + zc1*abs(i1)^2 + zr8*abs(ir8)^2 + zr6*abs(iv)^2 + zl5*abs(il5)^2  + zr5*abs(ir5)^2 + zr4*abs(ir4)^2 + zr3*abs(i3)^2]

pg = 1/2*[v1*conj(i1) + v3*conj(i3) + v2*conj(iv)]

% contonuità e variabili richieste 

maxil5 = abs(il5)
phiil5 = angle (il5)
il5a1meno = maxil5*sin(w*1 + phiil5)

vl = zl5*il5
maxvl = abs(vl)
phivl = angle(vl)

vla1meno = maxvl*sin(w*1 + phivl)

vc = zc1*i1
maxvc = abs(vc)
phivc = angle(vc)
vca1meno = maxvc*sin(w*1 + phivc)

% transitorio 

i1p = exp(j*pi/6); 
i3p = -exp(-j*pi/4);
v2p = 7*exp(j*pi/3);

% transitorio circuito 1

c = vca1meno + (1/10)*sin(w*1 + pi/6 + pi/2)

% transitorio circuito 2

req = zr6 + zr5 + zr4; 

tao = l5/req

% post transitorio circuito 2

zreq = req;
zeq1 = zreq + zl5;

vl51 = zr4*i3p; vl52 = v2p;

v0 = vl51 + vl52;

I = v0/zeq1 

maxI = abs(I)
phiI = angle(I)

k = il5a1meno - maxI*sin(w*1 + phiI)

k/tao, 10*maxI, 

vla1piu = k/tao + 10*maxI*cos(w*1 + phiI)

t1=-10:0.01:1;
t2=1:0.01:10;

iltpre = maxil5*sin(w*t1 + phiil5);
iltpost = k*exp((1-t2)/tao) + maxI*sin(w*t2 + phiI);

figure(1)
plot(t1, iltpre)
grid on 
hold on 
title ("il5(t)")
plot(t2, iltpost)


vlpre = maxvl*sin(w*t1 + phivl);
vlpost = -(k/tao)*exp((1-t2)/tao) + 10*maxI*sin(w*t2 + phiI + pi/2);


figure(2)
plot(t1, vlpre)
grid on 
hold on 
title ("vl(t)")
plot(t2, vlpost)
plot(t2, -(k/tao)*exp((1-t2)/tao), '--')


vcpre = maxvc*sin(w*t1 + phivc);
vcpost = -(1/10)*cos(w*t2 + pi/6) -0.4310;


figure(3)
plot(t1, vcpre)
grid on 
hold on 
title ("vc(t)")
plot(t2, vcpost)

close all

% punto 2

zsx = zr8 + zr1; zdx = zr5 + zr4 + zl5; zeq = (zsx*zdx)/(zsx+zdx)

icc1 = -i1*(zr1/(zr1 + zr8))


icc2 = i3*(zr4/(zr4+zl5+zr5))

zsx3 = zr1 + zr8; zdx3 = zr5 + zr4 + zl5; 
zeq3 = (zsx3*zdx3)/(zdx3+zsx3);

icc3 = v2/zeq3

i0 = icc1 + icc2 + icc3;

iv

ir6b = i0*(zeq/(zeq + zr6))

pr6 = (1/2)*zr6*abs(ir6b)^2 

(1/2)*zr6*abs(iv)^2

