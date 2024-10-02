clear all
close all
clc

% Inserimento dati 

V=500; f=50; P1=10e3; Q1=10e3; Q2=8e3; 

% Il carico 1 è completamente caratterizzato da P1 e Q1.
% Per il carico 2 manca P2

phi2 = acos(0.5);

P2 = Q2/tan(phi2); 

% Il carico vede, totalmente 

Ptot = P1 + P2; Qtot = Q1 + Q2; Atot = sqrt(Ptot^2 + Qtot^2);

% la corrente che necessietrà di rifasamento sarà:

Itot = Atot/V; 

% Il fattore di potenza complessivo sarà:

PF = cos(atan(Qtot/Ptot))

if PF < 0.95 
    fprintf(' e'' necessario rifasare!')
end 

phiR = acos(0.95);

% La potenza reattiva che mi serve per rifasare è:

QC = - Qtot + Ptot*tan(phiR);

% e la capacità del banco di condensatori che mi servirà sarà pari a:

C = abs(QC)/(V^2*2*pi*f)

% in  modo tale che la corrente rifasata IR e la potenza reattiva QR siano
% miori rispettivamente di Itot e QR 

QR = Qtot + QC;

AR = sqrt(QR^2 +Ptot^2);

IR = AR/V;

if IR < Itot & QR < Qtot
    fprintf('Il rifasamento è andato a buon fine')
else 
    fprintf('hai sbagliato qualcosa')
end 


