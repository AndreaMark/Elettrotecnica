close all
clear all
clc

% Inserimento dati in forma fasoriale 
 
     % Generatori
     IG=(2/sqrt(2))*exp(j*5*pi/6); E=(2/sqrt(2))*exp(j*7*pi/4);

     % Impedenze
     f=50; L=10e-6; C=3e-9;
     ZR1=1; ZR3=1; Z2=j*2*pi*f*L; Z3=-j/(2*pi*f*C);

% Matrice metodo dei nodi

A=[... 
-(1/ZR1 +1/Z2 + 1/ZR3) 1/ZR3
1/ZR3 -(1/ZR3 +1/Z3)];

B=[-E/ZR1; IG];

[X]=risoluzione_matrici(A,B)

% Fasori delle correnti a partire dai potenziali nodali V1=X(1) e V2=X(2)

I1 = E/ZR1 - X(1)/ZR1;
I2 = -X(1)/Z2;
I3 = X(1)/ZR3-X(2)/ZR3;
I4 = -X(2)/Z3;

I = [I1; I2; I3; I4]

% Calcolo delle potenze complesse e verifica del teorema di Boucherot

    P_g = 0.5*(E*conj(I1) + -X(2)*conj(IG))
    P_u = 0.5*(ZR1*(abs(I1))^2 + ZR3*(abs(I3))^2 + Z2*(abs(I2))^2 + Z3*(abs(I4))^2)

    % Verifica del teorema di Boucherot
    
    VERIFICA = P_g-P_u
    
    if P_g == P_u
        fprintf('IL TEOREMA DI BOUCHEROT E'' VERIFICATO')
    else 
        fprintf('IL TEOREMA DI BOUCHEROT NON E'' VERIFICATO')
    end
