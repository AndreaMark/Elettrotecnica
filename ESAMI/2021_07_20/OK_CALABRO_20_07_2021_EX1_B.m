clear all
close all
clc

% Inserimento dati RIF SIN E VAL EFFICACI 
% IL TRASFOMATORE HA GIA' TRASFOMATO IL CRICUITO
w = 10;

L1 = 1; C3 = 1;

ZR1 = 1; ZR3 = 1; ZR4 = 1; ZR5 = 1; ZR6 = 1; ZR2 = 4; 

ZL1 = j*(L1*w); ZC3 = -j/(C3*w);
    % Pre transitorio 
    
    V1 = [sqrt(2)/sqrt(2)]*exp(j*pi/6); 
    I2 = [3/sqrt(2)]*exp(j*(pi/2 - pi - pi/6));
    
    % Post transitorio 1
    % V1 rimane lo stesso di prima
    
% Matrice dei potenziali nodali 

A = [...
    -(1/ZR1 + 1/ZR3 + 1/ZL1) 1/ZR3 1/ZR1
    -1/ZR3 (1/ZC3 + 1/ZR3 + 1/ZR4) -1/ZC3
    1/ZR1  1/ZC3 -(1/ZR5 + 1/ZC3 + 1/ZR1)];
    
B = [0; I2; -V1/ZR5];

X = A\B;

VB = X(1); VC = X(2); VD = X(3); 

% Correnti a partire dai potenziali nodali 

IR5 = (-VD+V1)/ZR5;
IL1 = VB/ZL1;
IR4 = VC/ZR4; 
IC3 = (VC-VD)/ZC3; %perche il meno per forza!?
IR1 = (VD-VB)/ZR1;
IR3 = (VC-VB)/ZR3;

[IR5; IL1; IR4; IC3; IR1; IR3]

% Tensione sul generatore di corrente 

V2 = VC + I2*ZR2;

% Verifica attraverso Boucherot 

%Utilizzatori
PC3 = ZC3*abs(IC3)^2;
PR1 = ZR1*abs(IR1)^2;
PR5 = ZR5*abs(IR5)^2;
PL1 = ZL1*abs(IL1)^2;
PR3 = ZR3*abs(IR3)^2;
PR4 = ZR4*abs(IR4)^2;
PR2 = ZR2*abs(I2)^2;

% Generatori

PV1 = V1*conj(IR5); 
PI2 = V2*conj(I2);

% Boucherot 

Pu = PC3 + PR1 + PR5 + PL1 + PR3 + PR4 + PR2

Pg = PV1 + PI2 
    
if round(Pu) == round(Pg)
    fprintf('BOUCHEROT E'' VERIFICATO \n')
end

% Continuità e funzioni di stato sinusoidali

VC3fasore = IC3*ZC3
VC3max = sqrt(2)*abs(VC3fasore);
phiVC3 = angle(VC3fasore);

VC3a0meno = VC3max*sin(w*0 + phiVC3)

IL1fasore = IL1;

IL1max = sqrt(2)*abs(IL1fasore);
phiIL1 = angle(IL1fasore);

IL1a0meno = IL1max*sin(w*0 + phiIL1)

% Transitorio 1

tao1 = L1*(1/(ZR3+ZR4) + 1/(ZR1+ZR5));

% Post Transitorio 1

ZEQ = [(ZL1*(ZR3+ZR4))/(ZR3+ZR4+ZL1)] + ZR1 + ZR5;

I1fasore = V1/ZEQ;

IL1fasore = I1fasore*[(ZR3+ZR4)/(ZR3+ZR4+ZL1)];

maxIL1POST1 = sqrt(2)*abs(IL1fasore);
phiIL1POST1 = angle(IL1fasore)

% Faccio valere la continuità

k = IL1a0meno - maxIL1POST1*sin(10*0 + phiIL1POST1)


% Pre transitorio 2 = Post transitorio 1

   % Continuità
   
   IL1a1meno = k*exp(-1/tao1) + maxIL1POST1*sin(10*1 + phiIL1POST1)
   
% Transitorio 2 con Thevenin

V1_2 = 0.8;

RSX = (ZR5*ZR6)/(ZR5+ZR6) + ZR1;

RDX = ZR3 + ZR4;

REQ = (RSX*RDX)/(RSX+RDX);

RP = (ZR5*ZR6)/(ZR5+ZR6);

I1 = V1_2/(ZR1+RP+ZR3+ZR4);

V0 = -I1*(ZR1+RP) + V1_2

tao2 = L1/REQ

% Post transitorio 2

IL1post1 = V0/REQ

   
