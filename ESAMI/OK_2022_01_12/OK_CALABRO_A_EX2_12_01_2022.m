clear all
close all
clc

% inserimento dati

p = 9000; za = 2-j; zb = 1+3*j; zc = 1+2*j; zd = 2-3*j; ze = 4+j; zf = 3-j; f = 50; w = 2*pi*f; PFdes = 0.9; phides = acos(0.9); 

% carico a valle

iv = sqrt(p/(3*real(za))); 
qv = 3*imag(za*iv^2); av = sqrt(p^2 + qv^2); ev = av/(3*iv); vv = sqrt(3)*ev;

% carico zb 

pb = 3*real(ev^2/conj(zb)); qb = 3*imag(ev^2/conj(zb)); 

% conservazione delle potenze in L

pl = p + pb; ql = qv + qb; al = sqrt(pl^2 + ql^2); il = al/(3*ev); 

% carico zc

pc = 3*real(zc*il^2); qc = 3*imag(zc*il^2); 

% conservazione delle potenze in m

pm = pl + pc; qm = ql + qc, am = sqrt(qm^2+pm^2); , im = il, 

em = am/(3*im); vm = sqrt(3)*em;

% rifaso?

PFm = cos(atan(qm/pm)) 

if PFm < PFdes & qm > 0
    fprintf('e'' necessario rifasare \n')
else 
    fprintf('non e'' necessario rifasare \n')
end 


% è necessario rifasare

qdes = -qm + pm*tan(phides) 

c = abs(qdes)/(3*em^2*w)

% calcolo le nuove grandezze post rifasamento 

arif = sqrt(pm^2 + qdes^2); irif = arif/(3*em), phirif = atan(qdes/pm);

if qdes < qm & irif < im
    fprintf('il rifasamento ha funzionato \n')
else 
    fprintf('il rifasamento non ha funzionato \n')
end

% passaggio ai fasori le grandezze da adesso im poi si intendono fasoriali
e1m = em;
e2m = e1m*exp(-j*2*pi/3);
e3m = e1m*exp(j*2*pi/3); 

i1m = irif*exp(-j*phirif);
i2m = i1m*exp(-j*2*pi/3);
i3m = i1m*exp(j*2*pi/3);

v12m = vm*exp(j*pi/6);
v23m = v12m*exp(-j*2*pi/3);
v13m = v12m*exp(j*2*pi/3);

W = real(-v23m*conj(i3m))

% fasore spostamento centro stella

v0primo0 = (e1m/zd + e2m/ze + e3m/zf)/(1/zd + 1/ze + 1/zf);

v10primo = e1m - v0primo0;
v20primo = e2m - v0primo0;
v30primo = e3m - v0primo0;

izd = v10primo/zd
ize = v20primo/ze
izf = v30primo/zf

pzd = zd*abs(izd)^2;
pze = ze*abs(ize)^2;
pzf = zf*abs(izf)^2;

i1 = i1m + izd
i2 = i2m + ize
A2 = abs(i2)
i3 = i3m + izf
A3 = abs(i3)

v = abs(v12m)

% boucherot 

pu = pm + j*qdes + pzd + pze + pzf

pg = e1m*conj(i1) + e2m*conj(i2) + e3m*conj(i3)

