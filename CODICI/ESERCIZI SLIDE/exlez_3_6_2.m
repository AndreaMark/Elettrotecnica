clear all
close all
clc

% Inserimento dati 

V=250; f=50; P=1200; R=3; L=1e-3; 

% Il carico P è caratterizzato da P2 e cos(phi2).
% mancano la Q2 la potenza dissipata dall'impedenza equivalente.

phi2 = acos(0.75); Q = P*tan(phi2);

Zeq = R + j*2*pi*f*L;

% Trovo la corrente che scorre sul carico come

IZ = P/(V*0.75);

% e la potenza dissipata sull'impedenza sarà

PZ = real(Zeq)*IZ^2; QZ = imag(Zeq)*IZ^2; 

% Il carico vede, totalmente 

Ptot = P + PZ; Qtot = Q + QZ; Atot = sqrt(Ptot^2 + Qtot^2);


% il rendimento della linea pre rifasamento sarà

eta1 = P/Ptot

% Il fattore di potenza complessivo sarà:

PF = cos(atan(Qtot/Ptot))

if PF < 0.90 
    fprintf(' e'' necessario rifasare!')
end 

phiR = acos(0.9);

% La potenza reattiva che mi serve per rifasare è:

QC = - Qtot + Ptot*tan(phiR);

% e la capacità del banco di condensatori che mi servirà sarà pari a:

C = abs(QC)/(V^2*2*pi*f)

% in  modo tale che la corrente rifasata IR e la potenza reattiva QR siano
% miori rispettivamente di Itot e QR 

QR = Qtot + QC;

AR = sqrt(QR^2 + Ptot^2);

% La corrente ottenuta dopo il rifasamento sarà

IR = AR/V;

if IR < IZ & QR < Qtot
    fprintf('Il rifasamento è andato a buon fine')
else 
    fprintf('hai sbagliato qualcosa')
end 

% la potenza assorbita dal carico post rifasamento è

PZR = real(Zeq)*IR^2

% e il nuovo rendimento di lnea è

PtotR = P + PZR

eta2 = P/PtotR
