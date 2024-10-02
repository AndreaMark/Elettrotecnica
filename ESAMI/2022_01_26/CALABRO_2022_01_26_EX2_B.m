close all
clear all
clc

% insewrimento dati 

W1 = 300; W2 = 850; V = 75; P = 1450; phiv = asin(0.72); z1 = 5+2*j; z2 = 1+2*j; z13 = 3-2*j; f = 50; w = 2*pi*f; phides = acos(0.9); 

% cario a valle 
i = P/(sqrt(3)*V*cos(phiv)); Q = sqrt(3)*V*i*sin(phiv); 

% carico zt
pt = W1 + W2; qt = sqrt(3)*(W2-W1); Pcompl = pt + j*qt; zt = 3*V^2/conj(Pcompl), 

% conservazione delle potenze in s

qs = Q + qt; ps = P + pt; as = sqrt(ps^2 + qs^2); es = V/sqrt(3); is = as/(3*es);

% carico z1 

p1 = 3*real(es^2/conj(z1)); q1 = 3*imag(es^2/conj(z1)); 

% conservazione delle potenze in k 

pk = p1 + ps; qk = q1 + qs, ak = sqrt(pk^2 +qk^2); ek = es; ik = ak/(3*ek), phik = atan(qk/pk); PFk = cos(phik), 

% rifaso

qdes = -qk + pk*tan(phides)

c = abs(qdes)/(3*ek^2*w)

arif = sqrt(pk^2 + qdes^2); irif = arif/(3*ek) 

% carico z2 

p2 = 3*real(z2*irif^2); q2 = 3*imag(z2*irif^2); 

% conservazione dele potenze in t 

pt = pk + p2; qt = qk + qdes; at = sqrt(pt^2 +qt^2); it = irif; et = at/(3*it); phit = atan(qt/pt); 

% passaggio ai fasori

e1 = et;
e2 = e1*exp(-j*2*pi/3);
e3 = e1*exp(j*2*pi/3);

it1 = it*exp(-j*phit);
it2 = it1*exp(-j*2*pi/3);
it3 = it1*exp(j*2*pi/3);

v12 = sqrt(3)*et*exp(j*pi/6);
v23 = v12*exp(-j*2*pi/3);
v31 = v12*exp(j*2*pi/3);

W = real(v12*conj(it1))

iz13 = -v31/z13

i1 = it1 + iz13
A1 = abs(i1)
i2 = it2
A2 = abs(i2)
i3 = it3 - iz13

v = abs(v23)

pu = pt + j*qt + z13*abs(iz13)^2

pg = e1*conj(i1) + e2*conj(i2) + e3*conj(i3)





