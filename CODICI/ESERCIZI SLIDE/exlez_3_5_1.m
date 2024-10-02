close all
clear all
clc
tic
% Inserimento dati in forma fasoriale 
 
     % Generatori
     E1=100*exp(j*0); E2=50*exp(j*pi/2); 
     % Impedenze
     ZR1=10; ZR2=3; Z2=j*4; Z3=-j*5;

% Matrice metodo delle maglie

A=[... 
-(ZR1+Z3) Z3
Z3 -(ZR2+Z3+Z2)];

B=[-E1; -E2];

[X]=risoluzione_matrici(A,B)

% Fasori delle correnti a partire 
% dalle correnti di maglia J1=X(1) e VJ2=X(2)

I1 = X(1);
I2 = -X(2);
I3 = X(1)-X(2);


I = [I1; I2; I3]

% Calcolo delle potenze complesse e verifica del teorema di Boucherot

    P_g = 0.5*(E1*conj(I1) + -E2*conj(I2))
    P_u = 0.5*(ZR1*(abs(I1))^2 + ZR2*(abs(I2))^2 + Z2*(abs(I2))^2 + Z3*(abs(I3))^2)

    % Verifica del teorema di Boucherot
    
    VERIFICA = P_g-P_u
    
    if P_g == P_u
        fprintf('IL TEOREMA DI BOUCHEROT E'' VERIFICATO')
    else 
        fprintf('sei un coglione iscriviti a sociologia')
    end
    
% Calcolo il fasore della tensione che è interessata dal wattmetro VCD

VCD = ZR1*I1 - Z2*I2;

% Calcolo i valori efficaci di tensionsione VCD e corrente I3 misurati dal
% wattmetro

I3eff = abs(I3)/sqrt(2); VCDeff = abs(VCD)/sqrt(2);

% Calcolo gli angoli tra la tensione e la corrente misurati
% dal wattmetro per trovare lo sfasamento phi

phiI3=angle(I3); phiVCD=angle(VCD); phi=(phiVCD+phiI3);

% Allora il valore indicato dal wattmetro sarà

W = (I3eff*VCDeff)*cos(phi)
toc    
