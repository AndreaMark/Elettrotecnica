clear all
close all
clc

% inserimento dati

W1 = 500; W2 = 900; V = 82; P = 1200; phiv = asin(0.55); za = 3-j; zb = 1+2*j; z13 = 3-2*j; f = 50; w = 2*pi*f; PFdes = 0.9; phides = acos(0.9); 

% Carico a valle

q = P*tan(phiv); e = V/sqrt(3); av = sqrt(P^2 + q^2); 

% carico zt

pt = W1 + W2; qt = sqrt(3)*(W2 - W1); 

zt = (3*V^2)/conj(pt + j*qt)

% Conservazione delle potenze in y 

qy = q + qt

py = P + pt; ay = sqrt(qy^2 + py^2); ey = e; 

iy = ay/(3*ey)

% rifaso? 

PFy = cos(atan(qy/py))

% rifaso

qdes = -qy + py*tan(phides)

c = abs(qdes)/(3*w*ey^2)

arif = sqrt(py^2 + qdes^2);

irif = arif/(3*ey)

% carico za 

pa = 3*real((ey^2)/conj(za)); qa = 3*imag((ey^2)/conj(za));

% conservazione delle potenze in l

pl = py + pa; ql = qdes + qa; al = sqrt(ql^2 + pl^2); el = ey; il = al/(3*el);

% carico zb in serie

pb = 3*real(zb*il^2); qb = 3*imag(zb*il^2);


% conservazione delle potenze in m 

pm = pb + pl; qm = qb + ql; am = sqrt(pm^2 + qm^2); im = il; em = am/(3*im); vm = sqrt(3)*em; phim = atan(qm/pm); 

e1m = em; 
e2m = e1m*exp(-j*2*pi/3);
e3m = e1m*exp(j*2*pi/3);

i1m = im*exp(-j*phim); 
i2m = i1m*exp(-j*2*pi/3);
i3m = i1m*exp(j*2*pi/3);

v12m = vm*exp(j*pi/6);
v23m = v12m*exp(-j*2*pi/3);
v31m = v12m*exp(j*2*pi/3);

W = real(v12m*conj(i1m))

% carico z13

iz13 = -v31m/z13

i1 = iz13 + i1m
A1 = abs(i1)

i2 = i2m
A2 = abs(i2)

i3 = -iz13 + i3m

v = abs(v31m)

% boucherot

pu = pm +j*qm + z13*abs(iz13)^2

pg = e1m*conj(i1) + e2m*conj(i2) + e3m*conj(i3) 


