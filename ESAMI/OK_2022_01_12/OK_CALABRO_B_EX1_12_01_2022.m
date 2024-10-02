close all
clear all
clc

% RIF SIN E VAL MASSIMI

% Inserimento dati PRE TRANSITORIO in forma fasoriale (V2 già
% trasfomato)
w = 10;

     % Generatori
     V2=2*3*exp(j*(-pi/3 + pi/2)); I1=5*exp(j*pi/3); 
   
     % Resistenze 
     
     R1=1; R2=1; R3=1;
     
     % Capacità
     
     C1=2; C4=0.5;
     
     % Induttori
     
     L2=1.5; L3=0.5;
     
     % Reattanze
     
     XC1=w*C1; XC4=w*C4; XL2=w*L2; XL3=w*L3;
     
     % Impedenze (trasformo ZR3)
     
     ZR1=R1; ZR2=R2; ZR3=4*R3; ZC1=-j/XC1; ZC4= -j/XC4; ZL2=j*XL2; ZL3=j*XL3;
     
     
  J1 = I1; 
  
  % Matrice del metodo delle maglie
  
  A = [...
      ZL3 0 0 1
      -(ZL3 + ZR1 + ZC1 + ZR2) ZR2 -ZR2 0 
      ZR2 -(ZL2 + ZR2) ZR2 0
      -ZR2 ZR2 -(ZR2 + ZR3) 0];
  
  B = [J1*(ZC4 + ZL3); -J1*ZL3; 0; -V2];
  
  X = A\B;
  
  J2 = X(1); J3 = X(2); J4 = X(3); V1 = X(4);
  
  % Correnti di lato a partire dalle correnti di maglia
  
  IL3 = J1 - J2; IC1 = J2; IL2 = J3; IR2 = J2 - J3 + J4; IV = J4;
  
  % CONSERVAZIONE DELLE POTENZE
  
  PL3 = ZL3*abs(IL3)^2;
  PC4 = ZC4*abs(I1)^2;
  PR1 = ZR1*abs(IC1)^2;  
  PC1 = ZC1*abs(IC1)^2;
  PL2 = ZL2*abs(IL2)^2;
  PR2 = ZR2*abs(IR2)^2;
  PR3 = ZR3*abs(IV)^2;
  
  PI1 = V1*conj(I1);
  PV2 = V2*conj(IV);
  
  % BOUCHEROT
  
  PU = 1/2*[PL3 + PC4 + PR1 + PC1 + PL2 + PR2 + PR3]
  
  PG = 1/2*[PI1 + PV2]