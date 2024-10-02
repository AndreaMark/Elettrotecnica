close all
clear all
clc

tic
% Inserimento dati in forma fasoriale 
 
     % Generatori
     E1=100*exp(j*0); E2=200*exp(j*pi/2); E3=(100/sqrt(2))*exp(j*(3*pi/4));
   
     % Resistenze 
     
     R2=6; R4=6; R7=6; 
     
     % Reattanze
     
     X1=3; X3=3; X5=3; X6=3; X7=3; X8=3;
     
     % Impedenze 
     
     Z1=j*X1; Z3=-j*X3; Z5=-j*X5; Z6=j*X6; Z7=-j*X7; Z8=-j*X8; 

% Matrice dei potenziali nodali

A=[... 
-(1/Z1+1/R4+1/(R7+Z7)) 1/Z1 0 1/(Z7+R7)
1/Z1 -(1/Z1+1/Z5+1/R2) 1/R2 0 
0 1/R2 -(1/R2 + 1/Z6 + 1/Z3) 1/Z3
-1/(Z7+R7) 0 -1/Z3 (1/Z3 + 1/Z8 + 1/(Z7+R7))];

B=[E1/Z1; -(E1/Z1+E2/R2); E2/R2-E3/Z3; -E3/Z3];

[X]=risoluzione_matrici(A,B)

% Fasori delle correnti a partire 
% dai potensiali nodali 
% VA=X(1), VB=X(2), VC=X(3), VD=X(4)

I1 = X(1)/Z1 - X(2)/Z1 + E1/Z1;
I2 = X(2)/R2 - X(3)/R2 - E2/R2;
I3 = X(4)/Z3 - X(3)/Z3 + E3/Z3;
I4 = X(1)/R4;
I5 = -X(2)/Z5;
I6 = -X(3)/Z6;
I7 = -X(1)/(R7+Z7) + X(4)/(R7+Z7); 
I8 = X(4)/Z8;


I = [I1; I2; I3; I4; I5; I6; I7; I8]

% Calcolo delle potenze complesse e verifica del teorema di Boucherot

    P_g = E1*conj(I1) - E2*conj(I2) + E3*conj(I3)
    P_u = Z1*(abs(I1))^2 + R2*(abs(I2))^2 + R4*(abs(I4))^2 + Z5*(abs(I5))^2 + Z6*(abs(I6))^2 + Z7*(abs(I7))^2 + R7*(abs(I7))^2 + Z3*(abs(I3))^2 + Z8*(abs(I8))^2

    % Verifica del teorema di Boucherot
    
     % Verifica del teorema di Boucherot
    
    VERIFICA = P_g-P_u
    
    if round(P_g) == round(P_u)
        fprintf('IL TEOREMA DI BOUCHEROT E'' VERIFICATO \n')
    else 
        fprintf('sei un coglione iscriviti a sociologia \n')
    end   
 
 toc 