close all
clear all
clc

tic

% RIF SIN E VAL MASSIMI

% Inserimento dati PRE TRANSITORIO in forma fasoriale 
global w Emax C phi
w=1000; Emax = 10*sqrt(2); phi = pi/4
 
     % Generatori
     E = Emax*exp(j*phi); I=5*exp(j*pi/2); 
   
%    Esinusoidale = Emax*sin(1000t+phi);
%    Isinusoidale = 5*sin(1000t+pi/2);
     % Resistenze 
     
     R1=1; R2=2; R3=3; R4=4; R5=5; R6=6;
     
     % Capacità
     
     C=5e-4;
     
     % Reattanze
     
     XC=w*C;
     
     % Impedenze 
     
     ZC= -j/XC; 
     
J2=I;

% Matrice metodo delle maglie

A=[... 
-(R3+R4+ZC+R5) -(R4+ZC+R5) 0
-(R3+R4+ZC) -(R4+ZC) 1
-(R4+ZC+R5) -(R1+R2+R5+R4+ZC) 0];

B=[-E+J2*(R3+R4+ZC); J2*(R3+R4+ZC); J2*(R4+ZC)];

X=A\B;

% Fasori delle correnti a partire 
% dalle correnti di maglia J1=X(1) e J3=X(2) VJ=X(3) 

IE = X(1);
IC = X(1) + J2 + X(2);
I1 = J2;
I2 = X(2);
I3 = J2 + X(1);
I5 = X(1) + X(2);

[I1; IC; IE; I2; I3; I5];

% Calcolo delle potenze complesse e verifica del teorema di Boucherot

P_g = 0.5*[E*conj(IE) + X(3)*conj(I1)]
P_u = 0.5*[R1*(abs(I2))^2 + R2*(abs(I2))^2 + R3*(abs(I3))^2 + R4*(abs(IC))^2 + ZC*(abs(IC))^2 + R5*(abs(I5))^2]
    
    % Verifica del teorema di Boucherot
    
    VERIFICA = P_g-P_u
    
    if round(P_g) == round(P_u)
        fprintf('IL TEOREMA DI BOUCHEROT E'' VERIFICATO \n')
    else 
        fprintf('SEI UN COGLIONE ISCRIVITI A LETTERE \n')
    end   
    
% Calcolo della VCfasore e VCsinusoidale 

VCfasore = ZC*IC;
 
fprintf('VCsinusoidale = %3.2d sin(wt + %3.2d)\n', abs(VCfasore), angle(VCfasore))

% Calcolo della continuità 

VC0meno = abs(VCfasore)*sin(w*0 + angle(VCfasore));

% TRANSITORIO
% Calcolo del generatore equivalente di Thevenin 
% Sovrapposizione degli effetti 1

VC1fasore = E*(R1/(R1+R3)); % VC1sinusoidale = - Esinusoidale 

% Sovrapposizione degli effetti 2
RP = 2.74;
VC2fasore = RP*I; % VC2sinusoidalepost = ZRP*Isinusoidale

Eeq = VC1fasore + VC2fasore;
Eeqmax = abs(Eeq);
phiEeq = angle(Eeq);

% Soluzione a regime 

global Req

Req = 7.48;

VCfasorepost = Eeq*(ZC/(Req+ZC));

abs(VCfasorepost)
angle(VCfasorepost)

K = VC0meno - abs(VCfasorepost)*sin(w*0 + angle(VCfasorepost)) 


tao = Req*C;

% fprintf('VCsinusoidalepost = %3.2d sin(wt + %3.2d)\n', abs(VCfasore), angle(VCfasore))

% Pretransitorio
t1 = linspace(-10*Req*C, 0);
vCpre = abs(VCfasore)*sin(w*t1 + angle(VCfasore));

%postransitorio
t2 = linspace(0, 10*Req*C);
vCpost = K*exp(-t2/tao) + abs(VCfasorepost)*sin(w*t2 + angle(VCfasorepost));

figure
y1 = vCpre;
y2 = vCpost;
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

toc