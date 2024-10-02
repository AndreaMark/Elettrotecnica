close all
clear all
clc

tic

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
     
% Pongo

ZRC = ZR1 + ZC1;
     
% Matrice metodo dei nodi

A=[... 
-(1/ZL3+1/ZRC) 1/ZRC
1/ZRC -(1/ZRC+1/ZR3+1/ZR2+1/ZL2)];

B=[-I1; -V2/ZR3];

X = A\B;

% Fasori delle correnti a partire dai potenziali nodali

VA = X(1); VB = X(2);

IL3 = VA/ZL3; 
IRC = (VA-VB)/ZRC;
IL2 = VB/ZL2;
IR2 = VB/ZR2; 
IR3 = (V2-VB)/ZR3;

% La caduta di tensione sul generatore di corrente I1 è:

VI1 = VA + I1*ZC4; %!!!

% Calcolo delle potenze complesse e verifica del teorema di Boucherot

      % UTILIZZATORI
      PL3 = ZL3*(abs(IL3))^2;
      PC4 = ZC4*(abs(I1))^2;
      PR1 = ZR1*(abs(IRC))^2;
      PC1 = ZC1*(abs(IRC))^2;
      PL2 = ZL2*(abs(IL2))^2;
      PR2 = ZR2*(abs(IR2))^2;
      PR3 = ZR3*(abs(IR3))^2;

      P_u = 0.5*[PL3 + PC4 + PR1 + PC1 + PL2 + PR2 + PR3]

      % GENERATORI
      PI1 = VI1*conj(I1);
      PV2 = V2*conj(IR3);

      P_g = 0.5*[PI1 + PV2]

 % Verifica del teorema di Boucherot
    
    VERIFICA = P_g-P_u
    
    if round(P_g) == round(P_u)
        fprintf('IL TEOREMA DI BOUCHEROT E'' VERIFICATO \n')
    else 
        fprintf('SEI UN COGLIONE ISCRIVITI A LETTERE \n')
    end   
    
% Calcolo delle richieste iL2(t), vC1(t), iR1(t) PRE TRANSITORIO

maxIL2pre = abs(IL2)
phiIL2pre = angle(IL2)

VC1pre = IRC*ZC1;
maxVC1pre = abs(VC1pre)
phiVC1pre = angle(VC1pre)

maxIR1pre = abs(IRC)
phiIRpre1 = angle(IRC)
 

% Calcolo della continuità 

IL2_1meno = maxIL2pre*sin(w*1 + phiIL2pre)
VC1_1meno = maxVC1pre*sin(w*1 + phiVC1pre)
IR1_1meno = maxIR1pre*sin(w*1 + phiIRpre1)

% Transitorio con Norton 

Req = R2 + R3;

tao = L2/Req

ICCfasore = 8*sqrt(2)*exp(j*pi/6);

% Soluzione a regime 

Zeq = Req;

IZL2fasore = ICCfasore*(Zeq/(ZL2+Zeq));

maxIL2post = abs(IZL2fasore)
phiIL2post = angle(IZL2fasore)

% Calcolo la costante di integrazione K
K = IL2_1meno - maxIL2post*sin(w*1 + phiIL2post)


% Pretransitorio
t1 = linspace(-10*tao, 1);
IL2pre = maxIL2pre*sin(w*t1 + phiIL2pre);

%postransitorio
t2 = linspace(1, 10*tao);
IL2pos = K*exp((1-t2)/tao) + maxIL2post*sin(w*t2 + phiIL2post);

figure
y1 = IL2pre;
y2 = IL2pos;
t = [t1, t2];
y = [y1, y2];
plot(t, y, 'bo-');

ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
axis auto
grid on 

% Allarga immagine a schermo intero

set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

close gcf

toc