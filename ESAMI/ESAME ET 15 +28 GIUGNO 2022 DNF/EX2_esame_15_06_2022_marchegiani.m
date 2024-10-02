close all
clear all
clc

% inserimento dati 

W1 = 420; W2 = 1000; V = 78;; z1 = 3-2*j; z2 = 1+2*j; z3 = 4-5*j; z4 = 2-j; z5 = 4+j; f= 50; 
PFdes = 0.9; phides = acos(0.9); w = 2*pi*f

% carico a valle

p = W1 + W2; q = sqrt(3)*(W2-W1); 

zt = V^2/(conj(p+j*q))

% sezione s
vs = V;
ps = p; qs = q; as = sqrt(ps^2 + qs^2); is = as/(sqrt(3)*vs); es = vs/sqrt(3); 

% rifaso in s?

PFs = cos(atan(qs/ps))

% rifaso 

qdes = -qs + ps*tan(phides);

c = abs(qdes)/(3*es^2*w)

arif = sqrt(ps^2 + qdes^2); 

irif = arif/(3*es)

pz1 = 3*real(vs^2/conj(z1)); qz1 = 3*imag(vs^2/conj(z1));

% Conservazione delle potenze in k 
ek = es;
pk = ps + pz1; qk = qdes + qz1; ak = sqrt(qk^2 + pk^2); ik = ak/(3*es); phik = atan(qk/pk);

% carico z2

pz2 = 3*real(z2*ik^2); qz2 = 3*imag(z2*ik^2); 

% conservazione delle potenze in T
it = ik;
pt = pz2 + pk; qt = qz2 + qk; at = sqrt(pt^2 + qt^2); 

et = at/(3*it); vt = sqrt(3)*et; phit = atan(qt/pt); 

% passaggio ai fasori

e1 = et; 
e2 = e1*exp(-j*2*pi/3);
e3 = e1*exp( 2*pi/2);

i1t = it*exp(j*pi/6);
i2t = i1t*exp(-j*2*pi/3);
i3t = i1t*exp(j*2*pi/3); 

iz3 = e1/z3 
iz4 = e2/z4 
iz5 = e3/z5 

i2 = i2t + iz4
a2 = abs(i2)

vk=vs;
W = vk*ik*cos(-phik - 5*pi/6)



