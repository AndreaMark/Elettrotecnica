close all
clear all
clc

% inserimento dati

amp = 8; za = 2-j; zb = 2+j; zc = 1-2*j; zr = 2-j; zs = 2+3*j; zt = 3+j; f = 50; w = 2*pi*f; phides = acos(0.9);

% carico a valle 
pt = 3*real(zt*amp^2), qt = 3*imag(zt*amp^2); 

im = sqrt(3)*amp; 

% carico zs

ps = 3*real(im^2*zs); qs = 3*imag(im^2*zs); 

% conservazone delle potenze in d

pd = ps + pt; qd = qs + qt, ad = sqrt(pd^2 + qd^2); id = im, ed = ad/(3*id); vd = sqrt(3)*ed; phid = atan(qd/pd); 

PFd = cos(phid)


qdes = -qd + pd*tan(phides), c = abs(qdes)/(3*ed^2*w), 

arif = sqrt(pd^2 + qdes^2); irif = arif/(3*ed)

% carico zr 

pr = 3*real(ed^2/conj(zr)); qr = 3*imag(ed^2/conj(zr)); 

% sezione t, conservazione delle potenze

pT = pr + pd; qT = qr + qd; aT = sqrt(pT^2 + qT^2); eT = ed, vT = vd; iT = aT/(3*eT); phiT = atan(qT/pT); 

e1 = eT; 
e2 = e1*exp(-j*2*pi/3);
e3 = e1*exp(j*2*pi/3);

i1T = iT*exp(-j*phiT);
i2T = i1T*exp(-j*2*pi/3);
i3T = i1T*exp(j*2*pi/3);

v12 = vT*exp(j*pi/6); 
v23 = v12*exp(-j*2*pi/3);
v31 = v12*exp(j*2*pi/3);

W = real(-v31*conj(i2T))


% fasore spostamento del centro stella

v0primo0 = (e1/za + e2/zb + e3/zc)/(1/za + 1/zc + 1/zb)

v10primo = e1 - v0primo0
v20primo = e2 - v0primo0
v30primo = e3 - v0primo0

iza = v10primo/za
izb = v20primo/zb
izc = v30primo/zc

i1 = i1T + iza, A1 = abs(i1),
i2 = i2T + izb, A2 = abs(i2),
i3 = i3T + izc, A3 = abs(i3),

V = abs(v31)

pu = pT+ j*qT + za*abs(iza)^2 + zb*abs(izb)^2 + zc*abs(izc)^2

pg = e1*conj(i1) + e2*conj(i2) + e3*conj(i3)


