clear all
close all
clc

% inserimento dati

R=3; X=4; PM=10e3; V1=100; phiM=acos(0.5);

% dal valore efficace della tensione ottengo quello della corrente 

I = V1/X; 

% dalla potenza attiva assorbita PM ottengo il valore efficace della
% tensione del carico M 

VM = PM/(3*I*cos(phiM));

% Il fasore della tensione sul carico sarà 

VMfasore = VM*exp(j*0); 

% Ricordando dai ddati che la corrente è in ritardo rispetto alla tensione,
% il fasore della corrente sulla linea 1 sarà

Ifasore = I*exp(-j*phiM);

% Attraverso una la legge di ohm generalizzata con la fase 1 ottengo il fasore della tensione
% stellata E1

E1fasore = VMfasore + (R-j*X)*Ifasore;

% e il valore efficace della tensione concatenata sarà perciò 

V = sqrt(3)*abs(E1fasore)