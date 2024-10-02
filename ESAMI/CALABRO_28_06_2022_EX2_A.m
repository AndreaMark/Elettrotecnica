clear all
close all
clc

% inserimento dati

w1 = 720; w2 = 1500; qv = -470; phiv = acos(0.57); V = 83; w = 2*pi*50; za = 3+i; zb = 2-4*i; zc = 5+i; zd = 3-3*i; ze = 1-3*i; 

% carico a valle

iv = abs(qv)/(sqrt(3)*V*sin(phiv))
, pv = sqrt(3)*V*iv*cos(phiv), %ev = V/sqrt(3)

av = sqrt(qv^2 + pv^2); ev = av/(3*iv)

% carico za 

ia = iv; pa = 3*real(za*ia^2); qa = 3*imag(za*ia^2); 

% conservazione delle potenze in l

pl = pv + pa; ql = qv + qa, 

% devo rifasare?
% non devo rifasare

al = sqrt(ql^2 + pl^2); il = ia; el = al/(3*il); vl = sqrt(3)*el; phil = atan(ql/pl);

phiw = pi + 4*pi/3 + pi/6 + phil 

W = il*vl*cos(phiw)

% carico rl

erl = ev, prl = w1 + w2; qrl = sqrt(3)*(w2 - w1); 

arl = sqrt(prl^2 + qrl^2); irl = arl/(3*erl);

zrl = (prl + j*qrl)/(3*irl^2)

L = imag(zrl)/w, R = real(zrl)

% conservazione delle potenze in m 

pm = pl + prl; qm =  ql + qrl; am = sqrt(pm^2 + qm^2); em = ev; im = am/(3*em); vm = V; phim = atan(qm/pm);

% passaggio ai fasori

e1 = em;
e2 = e1*exp(-j*2*pi/3);
e3 = e1*exp(j*2*pi/3);

i1m = im*exp(-j*phim);
i2m = i1m*exp(-j*2*pi/3);
i3m = i1m*exp(j*2*pi/3);

v12 = vm*exp(j*pi/6);
v23 = v12*exp(-j*2*pi/3);
v31 = v12*exp(j*2*pi/3);

izb = v23/zb
izc = e1/zc
izd = e2/zd
ize = e3/ze

in = izd + izc + ize

i1 = i1m + izc
i2 = i2m + izd + izb
i3 = i3m + ize - izb

WN = real(-conj(in)*-v23)

v = abs(v12)
a1 = abs(i3)

pu = pm + j*qm + zb*abs(izb)^2 + zc*abs(izc)^2 + zd*abs(izd)^2 + ze*abs(ize)^2

pg = e1*conj(i1) + e2*conj(i2) + e3*conj(i3)

 


