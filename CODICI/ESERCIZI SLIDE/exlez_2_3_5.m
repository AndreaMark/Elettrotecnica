close all
clear all
clc

% Inserimento dati

J1=6; J2=3; 
R1=100; R2=50; R3=20; R4=40;

% Matrice

A=[... 
-(1/R1 + 1/R2 + 1/R3) 1/R3
1/R3 -(1/R4 + 1/R3)]

B=[J1; -(J1+J2)]

[X]=risoluzione_matrici(A,B)

% Correnti a partire DALLE CORRENTI DI MAGLIA

I1 = X(1)/R1;
I2 = -X(1)/R2;
I3 = X(1)/R3-X(2)/R3;
I4 = X(2)/R4;

I = [I1; I2; I3; I4]

P_g = -J1*R3*I3 + J2*R4*I4
P_u = R1*I1^2 + R2*I2^2 + R3*I3^2 + R4*I4^2

