clear all
close all
clc

% Inserimento dati 

V = 70; ZA = 2-j; ZB = 1-j*2; ZC = 3-j; ZD = 1+2*j; ZE = 3+j; ZF = 1-3*j; ZG = 1+j; 
W1 = 350; W2 = 600; w = 2*pi*50; PFDES = 0.9; PHIDES = acos(0.9);

% Carico a monte, sezione H

PV = W1 + W2; QV = sqrt(3)*(W2-W1); 

AV = sqrt(PV^2 + QV^2); IV = AV/(sqrt(3)*V); EV = AV/(3*IV);

% CARICO ZA 

IA = IV; IY = IV; 

PA = 3*real(ZA*IA^2); QA = 3*imag(ZA*IA^2); 

% CONSERVAZIONE DELLE POTENZE SU Y

PY = PV + PA; QY = QV + QA; 

PFY = cos(atan(QY/PY))

if PFY < PFDES & QY > 0
    fprintf('E'' NECESSARIO RIFASARE!')
else 
    fprintf('NON E'' NECESSARIO RIFASARE')
end

AY = sqrt(PY^2 + QY^2); VY = AY/(sqrt(3)*IY); 

EY = AY/(3*IY);

% CARICO ZB 

PB = 3*real(VY^2/conj(ZB)); QB = 3*imag(VY^2/conj(ZB)); EL = EY; AB = sqrt(PB^2 +QB^2);

% CONSERVAZIONE DELLE POTENZE IN L 

PL = PB + PY; QL = QB + QY; AL = sqrt(PL^2 + QL^2); IL = AL/(3*EL); 

JZB = AB/(3*VY); 

A3 = sqrt(3)*JZB

% CARICO ZC

PC = 3*real(ZC*IL^2); QC = 3*imag(ZC*IL^2); 

% CONSERVAZIONE DELLE POTENZE IN M 

PM = PC + PL; QM = QC + QL; IM = IL; PHIM = atan(QM/PM); 

AM = sqrt(PM^2 + QM^2); EM = AM/(3*IM);

% PASSAGGIO AI FASORI

E1MFASORE = EM;
E2MFASORE = E1MFASORE*exp(-j*2*pi/3);
E3MFASORE = E1MFASORE*exp(j*2*pi/3);

I1MFASORE = IM*exp(-j*PHIM);
I2MFASORE = I1MFASORE*exp(-j*2*pi/3);
I3MFASORE = I1MFASORE*exp(j*2*pi/3);

figure
compass(E1MFASORE, 'r')
hold on
compass(E2MFASORE, 'r')
hold on 
compass(E3MFASORE, 'r')
hold on
compass(I1MFASORE, 'b')
hold on 
compass(I2MFASORE, 'b')
hold on 
compass(I3MFASORE, 'b')



V12MFASORE = sqrt(3)*E1MFASORE*exp(j*pi/6);

% carico ZD, ZE, ZF, ZG

IZD = V12MFASORE/ZD; PZD = ZD*abs(IZD)^2;

IZE = E1MFASORE/ZE; PZE = ZE*abs(IZE)^2;

IZF = E2MFASORE/ZF; PZF = ZF*abs(IZF)^2;

IZG = E3MFASORE/ZG; PZG = ZG*abs(IZG)^2;

INFASORE = IZE + IZF + IZG; 

I1FASORE = I1MFASORE + IZD + IZE;
A1 = abs(I1FASORE)

I2FASORE = I2MFASORE - IZD + IZF; 
A2 = abs(I2FASORE)

I3FASORE = I3MFASORE + IZG; 

W = real(E3MFASORE*conj(-INFASORE))

P_G = E1MFASORE*conj(I1FASORE) + E2MFASORE*conj(I2FASORE) + E3MFASORE*conj(I3FASORE)

P_U = PM + j*QM + PZD + PZE + PZF + PZG






