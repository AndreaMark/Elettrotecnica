clear all
close all
clc

tic
% Inserimento dati 

Q = -450; PHIV = acos(0.72); A = 4; ZA = 3-j; ZB = 1+2*j; ZC = 4+j; ZD = 2+j;

ZE = 1-3*j; ZF = 2-2*j; ZG = 1-j; w = 2*pi*50;

% cARICO A VALLE

VV = Q/(sqrt(3)*A*sin(-PHIV)); PV = sqrt(3)*VV*A*cos(-PHIV); 

AV = sqrt(PV^2 + Q^2); EV = AV/(3*A); 

% IN SEZIONE S NON è NECESSARIO RIFASARE. LA POTENZA REATTIVA è GIà
% NEGATIVA

% CARICO ZA PARALLELO A TRIANGOLO

VS = VV; 

PA = 3*real(VS^2/conj(ZA)); QA = 3*imag(VS^2/conj(ZA)); 

% CONSERVAZIONE DELLE POTENZE IN Y
EY = EV;

PY = PV + PA; QY = Q + QA; AY = sqrt(PY^2 + QY^2); IY = AY/(3*EY);

% CARICO ZB IN SERIE

PB = 3*real(ZB*IY^2); QB = 3*imag(ZB*IY^2); 

% CONSERVAZIONE DELLE POTENZE IN T 

IT = IY;

PT = PB + PY; QT = QB + QY; AT = sqrt(PT^2+QT^2); ET = AT/(3*IT); PHIT = atan(QT/PT);

% PASSAGGIO A FASORI 

EI1fas = ET; 
EI2fas = EI1fas*exp(-j*2*pi/3);
EI3fas = EI1fas*exp(j*2*pi/3);

IT1fas = IT*exp(-j*PHIT);
IT2fas = IT1fas*exp(-j*2*pi/3);
IT3fas = IT1fas*exp(j*2*pi/3);

V12Tfas = sqrt(3)*EI1fas*exp(j*pi/6); 
V23Tfas = V12Tfas*exp(-j*2*pi/3); 
V13Tfas = V12Tfas*exp(j*2*pi/3); 

compass(EI1fas, 'r') 
hold on
compass(EI2fas, 'r')
hold on
compass(EI3fas, 'r')
hold on
compass(IT1fas, 'b')
hold on
compass(IT2fas, 'b')
hold on
compass(IT3fas, 'b'); 
hold on
compass(V12Tfas, 'g');
hold on
compass(V23Tfas, 'g');
hold on
compass(V13Tfas, 'g');

% carichi ZC, SD, ZE, ZF, ZG TUTTE LE GRANDEZZE IN INTENDONO FASORIALI

IZC = V12Tfas/ZC; PZC = ZC*abs(IZC)^2;
IZD = V23Tfas/ZD; PZD = ZD*abs(IZD)^2;

IZE = EI1fas/ZE; PZE = ZE*abs(IZE)^2;
IZF = EI2fas/ZF; PZF = ZF*abs(IZF)^2;
IZG = EI3fas/ZG; PZG = ZG*abs(IZG)^2;

% CALCOLO DELLE CORRENTI

IN = IZE + IZF + IZG;
I1 = IT1fas + IZC + IZE; 
I2 = IT2fas + IZF + IZD - IZC; 
I3 = IT3fas + IZG - IZD; 

V = abs(V12Tfas)
A1 = abs(I1)
A3 = abs(I3)
W = real(EI2fas+IN)

PU = PT +j*QT + PZC + PZD + PZE + PZF + PZG

PG = EI1fas*conj(I1) + EI2fas*conj(I2) + EI3fas*conj(I3)

toc
