close all
clear all
clc

% Inserimento dati

E1=12; J1=5; J2=3;  
R1=3; R2=10; R3=4; R4=5; R5=2;

% Matrice

A=[... 
0 0 1 1 0
0 0 0 -1 1
1 0 0 -R3 -R4
1 0 -R1 0 0
0 1 0 0 +R4]

B=[J1; -J2; R2*J1; R2*J1; 0]

[X]=risoluzione_matrici(A,B)

