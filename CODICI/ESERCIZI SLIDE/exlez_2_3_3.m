close all
clear all
clc

% Inserimento dati

E1=100; E2=50; E3=-50; E4=150; 
R1=10; R2=10; R3=5; R4=5; R5=2; R6=4; R7=4; R8=1;

% Matrice

A=[... 
-(1/R1+1/R2+1/R5) +1/R5 +1/R1
1/R5 -(1/R5+1/R6+1/R7+1/R4+1/R8) +1/R6
1/R1 1/R6 -(1/R1+1/R3+1/R6)]

B=[E1/R1 - E2/R2; -E4/R4; -(E1/R1 + E3/R3)]

[X]=risoluzione_matrici(A,B)

% Correnti a partire dai potenziali nodali

I1 = X(1)/R1 - X(3)/R1 + E1/R1;
I2 = E2/R2 - X(1)/R2;
I3 = E3/R3 - X(3)/R3;
I4 = X(2)/R4 - E4/R4;
I5 = X(1)/R5 - X(2)/R5;
I6 = X(2)/R6 - X(3)/R6;
I7 = X(2)/R7;
I8 = X(2)/R8;

I = [I1; I2; I3; I4; I5; I6; I7; I8]

P_g = E1*I1 + E2*I2 + E3*I3 - E4*I4
P_u = R1*I1^2 + R2*I2^2 + R3*I3^2 + R4*I4^2 + R5*I5^2 + R6*I6^2 + R7*I7^2 + R8*I8^2 
