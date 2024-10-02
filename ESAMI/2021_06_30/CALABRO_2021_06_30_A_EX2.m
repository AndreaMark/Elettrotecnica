clear all
close all
clc

% inssrimento dati

A = 8; z1 = 1+ 2*j; z2 = 2-j; z3 = 1+j; z4 = 3-j; z5 = 1-2*j; Pv = 500; phiv = acos(0.75); f = 50; w = 2*pi*f; phides = acos(0.9); 

% carico a valle 

i = A;

ev = Pv/(3*i*cos(phiv)); qv = 3*ev*i*sin(phiv); vv = sqrt(3)*ev; 

% carico z1

p1 = 3*real(vv^2/(conj(z1))); q1 = 3*imag(vv^2/(conj(z1))); 

% conservazione delle potenze in s

ps = Pv + p1; qs = qv + q1, as = sqrt(ps^2 + qs^2); es = ev; vs = vv; is = as/(3*es), phis = atan(qs/ps); 

% rifaso?

PFS = cos(phis)

% rifaso 

qdes = -qs + ps*tan(phides)

c = abs(qdes)/(3*es^2*w)

arif = sqrt(ps^2 + qdes^2); irif = arif/(3*es),

% carico z2 in ssrie

p2 = 3*real(z2*irif^2); q2 = 3*imag(z2*irif^2);

% lettura dei wattmetri

pk = p2 + ps; qk = q2 + qdes; 

A = [...
    1 1 
    -sqrt(3) sqrt(3)];

B = [pk; qk];

W = A\B

% carico z3

p3 = 3*real(z3*irif^2); q3 = 3*imag(z3*irif^2); 

% conservazione delle potenze in g 

pg = pk + p3; qg = qk + q3; ag = sqrt(pg^2 + qg^2); ig = irif; eg = ag/(3*ig); vg = sqrt(3)*eg; phig = atan(qg/pg); 

% Passaggio ai fasori

e1 = eg;
e2 = e1*exp(-j*2*pi/3);
e3 = e1*exp(j*2*pi/3);

i1g = ig*exp(-j*phig);
i2g = i1g*exp(-j*2*pi/3);
i3g = i1g*exp(j*2*pi/3);

v12 = vg*exp(j*pi/6); 
v23 = v12*exp(-j*2*pi/3);
v31 = v12*exp(j*2*pi/3);

% carico z4, z5

iz4 = v12/z4
iz5 = v23/z5

i1 = i1g + iz4
i2 = i2g + iz5 - iz4
i3 = i3g - iz5

A1 = abs(i1)
A2 = abs(i2)
A3 = abs(i3)

v = abs(v12)

pu = pg + j*qg + z4*abs(iz4)^2 + z5*abs(iz5)^2

pg = e1*conj(i1) + e2*conj(i2) + e3*conj(i3) 



