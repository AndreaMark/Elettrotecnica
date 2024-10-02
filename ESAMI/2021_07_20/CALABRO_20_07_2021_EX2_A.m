close all
clear all
clc

% INSERIMENO DATI

V = 50; z1 = 3+j; z2 = 2-j; z3 = 2+j; z4 = 1-3*j; z5 = 2-j; z6 = 1+2*j; z7 = 3-j; f = 50; w = 2*pi*f; phides = acos(0.9);
W1 = 200; W2 = 500; 

% carico a valle

pv = W1 + W2; qv = sqrt(3)*(W2-W1), av = sqrt(pv^2 + qv^2); iv = av/(sqrt(3)*V), 

% rifaso? 

phid = atan(qv/pv); PFd = cos(phid), 

% rifaso

qdes = -qv + pv*tan(phides), c = abs(qdes)/(sqrt(3)*V^2*w), 

arif = sqrt(pv^2 + qdes^2); irif = arif/(sqrt(3)*V),

% carico z1

p1 = 3*real(z1*irif^2); q1 = 3*imag(z1*irif^2); 

% conservazione delle potenze in k 

pk = pv + p1; qk = qdes + q1; ak = sqrt(pk^2 +qk^2); ik = irif; ek = ak/(3*ik); vk = sqrt(3)*ek;

% carico z2

p2 = 3*real(vk^2/conj(z2)); q2 = 3*imag(vk^2/conj(z2)); a2 = sqrt(p2^2 + q2^2);

A3 = a2/(3*vk)

% conservazione delle potenze in g

pg = pk + p2; qg = qk + q2; ag = sqrt(pg^2 +qg^2); eg = ek; ig = ag/(3*eg);

% carico z3

p3 = 3*real(z3*ig^2); q3 = 3*imag(z3*ig^2);

% conservazione delle potenze in f

pf = pg + p3; qf = qg + q3; af = sqrt(pf^2 + qf^2); If = ig; ef = af/(3*If); phif = atan(qf/pf);

% passaggio ai fasori

e1 = ef;
e2 = e1*exp(-j*2*pi/3);
e3 = e1*exp(j*2*pi/3);

if1 = If*exp(-j*phif);
if2 = if1*exp(-j*2*pi/3);
if3 = if1*exp(j*2*pi/3);

v12 = sqrt(3)*e1*exp(j*pi/6);
v23 = v12*exp(-j*2*pi/3);
v31 = v12*exp(j*2*pi/3);

% carichi z4 z5 z6 z7 
iz4 = v12/z4
iz5 = e1/z5
iz6 = e2/z6
iz7 = e3/z7

in = iz5 + iz6 + iz7

W = real(-e3*-conj(in))

i1 = if1 + iz5 + iz4
A1 = abs(i1)

i2 = if2+iz6-iz4
A2 = abs(i2)

i3 = if3 + iz7

pu = pf + j*qf + z4*abs(iz4)^2 + z5*abs(iz5)^2 + z6*abs(iz6)^2 + z7*abs(iz7)^2

pG = e1*conj(i1) + e2*conj(i2) + e3*conj(i3)



