clear all
close all
clc

% INSERIMENTO DATI

A = 10; Z1 = 1-j*2; Z2 = 3-j; Z3 = 1+2*j; Z4 = 2+3*j; Z5 = 1+j; ZT = 2+j;

PFDES = 0.9; PHIDES = acos(0.9); w = 2*pi*50; 


% caratterizzazione carico a valle zt

IT = sqrt(3)*A; % Corrente di linea

PT = 3*real(A^2*ZT); QT = 3*imag(A^2*ZT); AT = sqrt(PT^2 + QT^2); ET = AT/(3*IT); VT = sqrt(3)*ET; 

% CARICO Z5

P5 = 3*real(Z5*IT^2); Q5 = imag(Z5*IT^2); 

% conservazione delle potenze in g

PG = PT + P5; QG = QT + Q5; AG = sqrt(PG^2 + QG^2); IG = IT; EG = AG/(3*IG); 

% CARIZO Z4 IN PARALLELO A STELLA 

P4 = 3*real(EG^2/conj(Z4)); Q4 = 3*imag(EG^2/conj(Z4)); 

% CONSERVAZIONE DELLE POTENZE IN H

PH = P4 + PG; 
QH = Q4 + QG 
AH = sqrt(PH^2 + QH^2); EH = EG; IH = AH/(3*EH) 

PHIH = atan(QH/PH); PFH = cos(PHIH)

if PFH<PFDES & QH > 0
    fprintf('E'' NECESSARIO RIFASARE \n')
else
    fprintf('NON E'' NECESSARIO RIFASARE! \n')
end

QDES = -QH + PH*tan(PHIDES); 

C = abs(QDES)/(3*EH^2*w)

ARIF = sqrt(PH^2 + QDES^2); IRIF = ARIF/(3*EH) 

if QDES<QH & IRIF<IH 
    fprintf('IL RIFASAMENTO FUNZIONA \n')
else 
    fprintf('IL RIFASAMENTO NON HA FUNZIONATO \n')
end

PHIRIF = atan(QDES/PH); 

% PASSAGGIO AI VASORI IN H LE GRANDEZZE SEGUENTI SI INTENDONO FASORIALI

E1H = EH;
E2H = E1H*exp(-j*2*pi/3);
E3H = E1H*exp(j*2*pi/3);

I1H = IRIF*exp(-j*PHIRIF);
I2H = I1H*exp(-j*2*pi/3);
I3H = I1H*exp(j*2*pi/3);

V12H = sqrt(3)*E1H*exp(j*pi/6);
V23H = V12H*exp(-j*2*pi/3);
V31H = V12H*exp(j*2*pi/3);

compass(E1H, 'r')
hold on
compass(E2H, 'r')
hold on
compass(E3H, 'r')
hold on
compass(I1H, 'b')
hold on
compass(I2H, 'b')
hold on
compass(I3H, 'b')
hold on
compass(V12H, 'g')
hold on
compass(V23H, 'g')
hold on
compass(V31H, 'g')

close gcf

W = real(-V31H*conj(I2H))

% FASORE SPOSTAMENTO CENTRO STELLA 

V0PRIMO0 = (E1H/Z1 + E2H/Z2 + E3H/Z3)/(1/Z1 + 1/Z2 + 1/Z3); 

V10PRIMO = E1H - V0PRIMO0;
V20PRIMO = E2H - V0PRIMO0;
V30PRIMO = E3H - V0PRIMO0;

% CORRENTI SUL CARICO 

IZ1 = V10PRIMO/Z1; PZ1 = Z1*abs(IZ1)^2;
IZ2 = V20PRIMO/Z2; PZ2 = Z2*abs(IZ2)^2;
IZ3 = V30PRIMO/Z3; PZ3 = Z3*abs(IZ3)^2;

% CORRENTI TOTALI 

I1 = IZ1 + I1H; 
A1 = abs(I1)

I2 = IZ2 + I2H;
A2 = abs(I2)

I3 = IZ3 + I3H;
A3 = abs(I3)

V = abs(V23H)

% VERIFICO CON BOUCHEROT

PU = PH + j*QDES + PZ1 + PZ2 + PZ3

PG = E1H*conj(I1) + E2H*conj(I2) + E3H*conj(I3)





