clear all
close all
clc

% inserimento dati  amp = 5; pzt = 460; xt

pv = 530; phiv = acos(0.72); amp = 5; pzt = 460; xt = -1.5; za = 3+5*j; zb = 3-2*j; zc = 2+2*j; zd = 1-2*j; w = 2*pi*50; 

% carico a valle 

qv = pv*tan(phiv); 

% carico zt

qzt = 3*amp*xt

pcomplzt = pzt + j*qzt; Rt = real(pcomplzt/(3*amp^2))

azt = sqrt(pzt^2 + qzt^2);

ezt = azt/(3*amp);

% conservazione delle potenze in t

pt = pzt + pv; qt = qzt + qv; at = sqrt(pt^2 +qt^2); et = ezt; vt = sqrt(3)*et; it = at/(3*et); 

% carico za in serie

pa = 3*real(za*it^2); qa = 3*imag(za*it^2); 

% conservazione delle potenze in o

po = pa + pt; qo = qa + qt, ao = sqrt(po^2 + qo^2); io = it; eo = ao/(3*io); vo = sqrt(3)*eo; phio = atan(qo/po); pf0 = cos(phio)

% è necessario rifasare: 

qdes = -qo +po*tan(acos(0.9))

c = abs(qdes)/(3*w*eo^2)

arif = sqrt(po + qdes^2); irif = arif/(3*eo)

% cario zb in parallelo a triangolo 

pzb = 3*real(vo^2/conj(zb)); qzb = 3*imag(vo^2/conj(zb)); 

% conservazione delle potenze in g e lettura dei wattmetri

pg = po + pzb; qg = qdes + qzb; 

A = [...
    1 1 
    -sqrt(3) sqrt(3)]; 

B = [pg; qg]; 

W = A\B 

ag = sqrt(pg^2 + qg^2); eg = eo; ig = ag/(3*eg); 

% carico zc in serie 

pzc = 3*real(zc*ig^2); qzc = 3*imag(zc*ig^2); 

% conservazione delle potenze in d

pd = pg + pzc; qd = qg + qzc; ad = sqrt(pd^2 + qd^2); id = ig; ed = ad/(3*id); vd = sqrt(3)*ed; phid = atan(qd/pd); 

% passaggio ai fasori

e1 = ed; 
e2 = e1*exp(-j*2*pi/3); 
e3 = e1*exp(j*2*pi/3);

i1d = id*exp(-j*phid); 
i2d = i1d*exp(-j*2*pi/3); 
i3d = i1d*exp(j*2*pi/3);

v12 = vd*exp(j*pi/6); 
v23 = v12*exp(-j*2*pi/3); 
v31 = v12*exp(j*2*pi/3);

izd1 = v12/zd, izd2 = v23/zd, 

i1 = i1d + izd1, i2 = i2d + izd2 - izd1, i3 = i3d - izd2, 

A1 = abs(i1), v = abs(v31)

