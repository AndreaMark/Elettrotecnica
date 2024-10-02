% inserimeto dati
w = 10;
r1 = 1; r2 =1; r3= 1; r4 = 1; r5 = 1; c2 = 0.2; c3 = 0.2; l = 0.3;

zr1 = r1; zr2 = r2; zr3 = r3; zr4 = r4; zr5 = r5; zc2 = -j/(w*c2); zc3 = -j*(w*c3); zl = j*w*l; 

% pre trasnitorio, dominio dei fasori

v1 = v3 = 2*sqrt(2)*exp(j*(-pi/3)); u2 = 4*exp(j*pi/4); 

% Matrice del metodo delle correnti di maglia 
A = [...
-zr3 + zc3 + zr4) zr3 zr4 1 
zr3 -(zr3 + zr2 + zc2) zc2 1
zr4 zc2 -(zr4 + zc2 + zr5) 0
0 1 -1 0];

B =[-v3; 0; 0; i2]

X = A\B; 

j1 = X(1); j2 = X(2); j3 = X(3); vi2 = X(4);

% correnti a partire dalle correnti di maglia

iv3 = j1; ir2 = j2; ir5 = j3; ir4 = j1-j3; ic2 = j3-j2

% Potenza utulizzatori 

pc3 = zc3*abs(iv3)^2; 
pr3 = zr3*abs(i2)^2;
pr2 = zr2*abs(ir2)^2; 
pr4 = zr4*abs(ir4)^2; 
pc2 = zc2*abs(ic2)^2; 
pr5 = zr5*abs(ir5)^2; 

% potenza generatori

pv3 = v3*conj(iv3);
pi2 = vi2*conj(i2);

% conservazione delle potenze con boucherot

pg = 1/2*[pc3 + pr3+ pr2 + pr4 + pc2 + pr5];

pu = 1/2*[pv3 + pi2];

Verifica = pg - pu


