clear all
close all
clc


% inserimento dati

w1 = 420; w2 = 1000; v=78; z1 = 3-2*j; z2 = 1+2*j; z3 = 4-5*j; z4 = 2-j; z5 = 4+j; w= 2*pi*50;

% carico a valle

pv = w1 + w2; qv = sqrt(3)*(w2-w1), PV = pv+j*qv;
zt=(3*v^2)/conj(PV)

% rifaso in s?

phiv = atan(qv/pv); PFs = cos(phiv), phides = acos(0.9);

qdes = -qv + pv*tan(phides), c = abs(qdes)/(sqrt(3)*w*v^2), 
% carico z1 in parallelo a triangolo, sene la stessa v del carico
% precedente 

p1 = 3*real(v^2/conj(z1)); q1 = 3*imag(v^2/conj(z1));

% conservazione delle potenze in k

pk = p1 + pv; qk = q1 + qdes; ak = sqrt(pk^2 + qk^2); vk = v; ek = vk/sqrt(3); ik = ak/(3*ek); 

% carico z2 in serie 

p2 = 3*real(z2*ik^2); q2 = 3*imag(z2*ik^2); 

% conservazione delle potenze in t

pt = p2 + pk; qt = q2 + qk; at = sqrt(pt^2 + qt^2); it = ik; et = at/(3*it); vt = sqrt(3)*et; phit = atan(qt/pt);

% passaggio ai fasori

e1 = et;
e2 = e1*exp(-j*2*pi/3);
e3 = e1*exp(j*2*pi/3);

i1t = it*exp(-j*phit);
i2t = i1t*exp(-j*2*pi/3);
i3t = i1t*exp(j*2*pi/3);

v12 = vt*exp(j*pi/6);
v23 = v12*exp(-j*2*pi/3);
v31 = v12*exp(j*2*pi/3);

% fasore spostamento del centro stella

v0primo0 = (e1/z3 + e2/z4 + e3/z5)/(1/z3 + 1/z4 + 1/z5)

v10primo = e1 - v0primo0
v20primo = e2 - v0primo0
v30primo = e3 - v0primo0

iz3 = v10primo/z3
iz4 = v20primo/z4
iz5 = v30primo/z5

i1 = i1t + iz3,

i2 = i2t + iz4 

i3 = i3t + iz5

pu = pt + j*qt + z3*abs(iz3)^2 + z4*abs(iz4)^2 + z5*abs(iz5)^2

pg = e1*conj(i1) + e2*conj(i2) + e3*conj(i3)

a2 = abs(i2), v = abs(e1-v0primo0), 