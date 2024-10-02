close all
clear al
clc

% inserimento dati

I = 7; za = 2-j; zb = 1+2*j; zc = 3-j; zd = 2+j; ze = 2+3*j; p = 350; phi = acos(0.73); f = 50; w = 2*pi*f; phides = acos(0.9); 

% carico a valle 

e = p/(3*I*cos(phi)); v = sqrt(3)*e; qv = 3*e*I*sin(phi); 

% carico za 
pa = 3*real(v^2/conj(za)); qa = 3*imag(v^2/conj(za)); 

% conservazione delle potenze in h

ph = pa + p; qh = qa + qv; ah = sqrt(ph^2 +qh^2); eh = e; ih = ah/(3*eh);

% carico zb 

pb = 3*real(ih^2*zb); qb = 3*imag(ih^2*zb); 

%conservazione delle potenze in y            

py = pb + ph; qy = qb + qh, ay = sqrt(py^2 +qy^2); iy = ih, ey = ay/(3*ih); phiy = atan(qy/py); 

PFy = cos(phiy)

qdes = -qy + py*tan(phides), c = abs(qdes)/(3*ey^2*w), 

arif = sqrt(py^2 +qdes^2); irif = arif/(3*ey), 

% inserzione aaron 

A = [...
    1 1 
    sqrt(3) -sqrt(3)];

B = [py; qdes];

W = A\B

% carico c

pc = 3*real(irif^2*zc); qc = 3*imag(irif^2*zc); 

% conservazione delle potenze in l 

pl = pc + py; ql = qc + qdes; al = sqrt(pl^2 + ql^2); il = irif; el = al/(3*il); vl = sqrt(3)*el; phil = atan(ql/pl); 

% passaggio ai fasori

e1 = el; 
e2 = e1*exp(-j*2*pi/3); 
e3 = e1*exp(j*pi*2/3);

i1l = il*exp(-j*phil); 
il2 = i1l*exp(-j*2*pi/3);
il3 = i1l*exp(j*pi*2/3);

v12 = vl*exp(j*pi/6); 
v23 = v12*exp(-j*2*pi/3);
v31 = v12*exp(j*pi*2/3);

izd = v12/zd
ize = v23/ze

i1 = i1l + izd, A1 = abs(i1),
i2 = il2 + ize - izd, A2 = abs(i2),
i3 = il3 - ize, A3 = abs(i3),

pu = pl+j*ql + zd*abs(izd)^2 + ze*abs(ize)^2

pg = e1*conj(i1) + e2 * conj(i2) + e3*conj(i3)




