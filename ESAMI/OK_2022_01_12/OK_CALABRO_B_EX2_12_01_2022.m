clear all
close all
clc

format compact

% Inserimento dati

PM = 1200; Z1 = 1+2*j; Z2 = 3-i*j; Z3 = 3+2*j; f = 50; 
Z4 = 1-j; Z5 = 4+3*j; Z6 = 1 + 4*j;
% Carico a monte 

IM = sqrt(PM/(3*real(Z1))); 
QM = 3*imag(Z1)*IM^2;

AM = sqrt(PM^2 + QM^2);

EM = AM/(3*IM); VM = AM/(sqrt(3)*IM);

% Carico S

PS = 3*real(EM^2/conj(Z2));
QS = 3*imag(EM^2/conj(Z2));

% Conservazione delle potenze su K, è necessario rifasare?

PK = PM + PS; QK = QM + QS, 

AK = sqrt(QK^2 + PK^2); IK = AK/(3*EM),

PFK = cos(atan(QK/PK))

if PFK < 0.9 & QK >0 
    fprintf('e'' necessario rifasare! \n')
end

% Rifasamento su K

phiDES = acos(0.9);

% La potenza reattiva che mi serve per rifasare è:

QDES = - QK + PK*tan(phiDES)

% e la capacità del banco di condensatori che mi servirà sarà pari a:

C = abs(QDES)/(3*EM^2*2*pi*f)

AKRIF = sqrt(QDES^2 + PK^2); IKRIF = AKRIF/(3*EM)

if abs(QDES) < QK & IKRIF < IK
    fprintf('ok \n')
else 
    fprintf('non ok')
end

% Sezione K RIFASATA

PKRIF = 3*real(Z3*IKRIF);
QKRIF = 3*imag(Z3*IKRIF);

% Conservazione delle potenze alla sezione T

PT = PKRIF + PK; 
QT = QKRIF + QDES;

AT = sqrt(PT^2 +QT^2);

ET = AT/(3*IKRIF);

% Passo ai fasori 

phiT = atan(QT/PT); 

ET1fasore = ET;
ET2fasore = ET1fasore*exp(-j*2*pi/3);
ET3fasore = ET1fasore*exp(j*2*pi/3);

IT1fasore = IKRIF*exp(-j*phiT);
IT2fasore = IT1fasore*exp(-j*2*pi/3);
IT3fasore = IT1fasore*exp(j*2*pi/3);

compass(ET1fasore, 'r')
hold on
compass(ET2fasore, 'r')
hold on 
compass(ET3fasore, 'r')


compass(IT1fasore, 'b')
hold on 
compass(IT2fasore, 'b')
hold on 
compass(IT3fasore, 'b')

close gcf

VT12fasore = sqrt(3)*ET1fasore*exp(j*pi/6);
VT23fasore = VT12fasore*exp(-j*2*pi/3);
VT31fasore = VT12fasore*exp(j*2*pi/3);

% La lettura del WATTMETRO è data da 

W = real(-VT23fasore*conj(IT3fasore))

% Arrivo al carico squilibrato 

% Faaore spostamento centro stella con Millmann 

V0primo0fasore = [ET1fasore/Z4 + ET2fasore/Z5 + ET3fasore/Z6]/[1/Z4 + 1/Z5 + 1/Z6]

% Le tensioni concatenate del carico squilibrato saranno

V10primofasore = ET1fasore - V0primo0fasore;
V20primofasore = ET2fasore - V0primo0fasore;
V30primofasore = ET3fasore - V0primo0fasore;

% Le correnti sul carico sono 

IZ4fasore = V10primofasore/Z4
IZ5fasore = V20primofasore/Z5
IZ6fasore = V30primofasore/Z6

% E le correnti totali diventano 

I1fasore = IZ4fasore + IT1fasore
I2fasore = IZ5fasore + IT2fasore
I3fasore = IZ6fasore + IT3fasore

% Gli amperometri leggono

A2 = abs(I2fasore)
A3 = abs(I3fasore)
V = abs(VT12fasore)

% Verifico con Boucherot

PG = ET1fasore*conj(I1fasore) +  ET2fasore*conj(I2fasore) +  ET3fasore*conj(I3fasore)
PU = PT +j*QT + Z4*abs(IZ4fasore)^2 + Z5*abs(IZ5fasore)^2 + Z6*abs(IZ6fasore)^2





