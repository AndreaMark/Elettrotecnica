close all
clear all
clc

% Inserimento dati

E1=12; E2=10; 
R1=40; R2=60; R3=20; 

% Matrice

A=[... 
-(R1+R2) R2
R2 -(R2+R3)]

B=[-E1; E2]

[X]=risoluzione_matrici(A,B)

% Correnti a partire DALLE CORRENTI DI MAGLIA

I1 = X(1);
I2 = -X(2);
I3 = X(1)-X(2);

I = [I1; I2; I3]

P_g = E1*I1 + E2*I2
P_u = R1*I1^2 + R3*I2^2 + R2*I3^2 
V_0 = R2*I3
