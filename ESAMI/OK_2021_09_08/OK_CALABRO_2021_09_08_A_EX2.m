close all
clear all
clc

% inserimento dati

p = 1500; phiv = asin(0.53); A = 6; z1 = 2-2*j; z2 = 3+j; z3 = 2-j; z4 =4+j;z5 = 1+3*j; 
W1 = 200; W2= 1100; f=50; PFdes = 0.9; phides = acos(0.9); w = 2*pi*f;

% Carico  valle

qv = p*tan(phiv); 

% carico zt, 

pt = W1 + W2; qt = sqrt(3)*(W2-W1); J = A; 

pcomplessa = pt + j*qt; it = sqrt(3)*J;

zt = pcomplessa/(3*J^2)

at = sqrt(qt^2+pt^2); et = at/(3*it);

% conservazione delle potenze in s

ps = pt + p; qs = qv + qt, as = sqrt(qs^2 + ps^2); is = as/(3*et), phis = atan(qs/ps);

% rifaso?

PFs = cos(phis) 

if PFs < PFdes & qs > 0
    fprintf('e'' necessario rifasare \n')
else
    fprintf('non e'' necessario rifasare \n')
end

% rifasamento

qdes = -qs + ps*tan(phides)

c = abs(qdes)/(3*w*et^2)

arif = sqrt(ps^2 + qdes^2); irif = arif/(3*et),

if qdes < qs & irif < is
    fprintf('il rifasamento ha funzionato \n')
else
    fprintf('il rifasamento NON ha funzionato \n') 
end

% carico z1 

pz1 = 3*real(irif^2*z1); qz1 = 3*imag(irif^2*z1);

% conservazione delle potenze in k

ik = irif;

pk = pz1 + ps; qk = qz1 + qdes; ak = sqrt(pk^2 + qk^2); ek = ak/(3*ik); vk = sqrt(3)*ek;

phik = atan(qk/pk);

phiW = pi/6 + phik;

W = vk*ik*cos(phiW)

% carico z2

pz2 = 3*real(ek^2/conj(z2)); qz2 = 3*imag(ek^2/conj(z2)); 

% conservazione delle potenze in g

pg = pz2 + pk; qg = qz2 + qk; eg = ek; ag = sqrt(pg^2 + qg^2); ig = ag/(3*eg); vg = sqrt(3)*eg; phig = atan(qg/pg); 

% passaggio ai fasori 

e1 = eg;
e2 = e1*exp(-j*pi*2/3);
e3 = e1*exp(j*pi*2/3);

i1g = ig*exp(-j*phig);
i2g = i1g*exp(-j*pi*2/3);
i3g = i1g*exp(j*pi*2/3);

v12 = vg*exp(j*pi/6);
v23 = v12*exp(-j*pi*2/3);
v13 = v12*exp(j*pi*2/3);

% fasore spostamento centro stella

v0primo0 = (e1/z3 + e2/z4 + e3/z5)/(1/z3 + 1/z4 + 1/z5)

v10primo = e1 - v0primo0;
v20primo = e2 - v0primo0;
v30primo = e3 - v0primo0;

iz3 = v10primo/z3,  pz3 = z3*abs(iz3)^2;
iz4 = v20primo/z4,  pz4 = z4*abs(iz4)^2;
iz5 = v30primo/z5,  pz5 = z5*abs(iz5)^2;

i1 = iz3 + i1g
i2 = iz4 + i2g 
A2 = abs(i2)
i3 = iz5 + i3g
A3 = abs(i3)

V1 = abs(v12)

% verifico con boucherot 

pu = pg + j*qg + pz3 + pz4 + pz5

pg = e1*conj(i1) + e2*conj(i2) + e3*conj(i3)


