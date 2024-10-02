close all
clear all
clc

% inserimento dati

W1 = 720; W2 = 1500; qv = -470; phiv = acos(0.57); V = 83; f = 50; w = 2*pi*f; za = 3+j; zb = 2-4*j; zc = 5+j; zd = 3-3*j; ze = 1-3*j;

% sezione di valle

iv = abs(qv)/(sqrt(3)*V*sin(phiv)); 
pv = sqrt(3)*V*iv*cos(phiv);

ev = V/sqrt(3);
% carico za

ia = iv;

pa = 3*real(za*ia^2); qa = 3*imag(za*ia^2);

% conservazione delle potenze in l 

il = ia, 

pl = pv + pa; ql = qv + qa, al = sqrt(pl^2 + ql^2); el = al/(3*il); phil = atan(ql/pl); vl = sqrt(3)*el;

PFl = cos(phil)

% sezione rl

prl = W1 + W2; qrl = sqrt(3)*(W2-W1); arl = sqrt(prl^2 + qrl^2); erl = ev; irl = arl/(3*erl);

PRL = prl + j*qrl;

zrl = PRL/(3*irl^2)

L = imag(zrl)/(w)

% conservazione delle potenze in m 

pm = pl + prl; qm = ql + qrl; am = sqrt(pm^2 +qm^2); em = ev; vm = V; im = am/(3*em); phim = atan(qm/pm);

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

% carichi zb, zc, zd, ze

izb = v23/zb
izc = e1/zc
izd = e2/zd
ize = e3/ze
in = izc + izd + ize

Wn = real(-in*-v23)
i1 = i1m + izc
i2 = i2m + izd + izb
i3 = i3m + ize - izb 

v = abs(v12)
a1 = abs(i3)

phiw = pi + 4*pi/3 + pi/6 + phil

W = il*vl*cos(phiw)

% verifico con boucherot il trifase 

pu = pm+j*qm + zb*abs(izb)^2 + zc*abs(izc)^2 + zd*abs(izd)^2 + ze*abs(ize)^2

pg = e1*conj(i1) + e2*conj(i2) + e3*conj(i3)


