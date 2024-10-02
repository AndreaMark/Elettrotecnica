% Inserimento dati

J1=1e-3; J2=1e-3; R1=0.3; R2=0.2; R3=0.4; R4=0.5; E=2e-3;

% Creazione matrice
tic
A = [...
0 0 -1 -1 1 0 0
0 0 0 0 0 1 0
0 0 1 1 0 -1 -1
0 0 R1 0 R3 0 0
-1 0 0 0 0 R4 0
1 -1 0 0 -R3 0 0
0 1 0 -R2 0 -R4 0]

B = [-J2; J1+J2; 0; E; -E; 0; 0]

X = A\B

P_g = X(1)*J1 + X(2)*J2 + X(7)*E
P_u = R1*X(3)^2 + R2*X(4)^2 + R3*X(5)^2 + R4*X(6)^2 

PE = X(7)*E
PJ1 = X(1)*J1
PJ2 = X(2)*J2
toc