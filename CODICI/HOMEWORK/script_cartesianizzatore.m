 clear all
 close all
 clc
% Inserisco variabili da cartesianizzare: 
% Angolo theta e Modulo rho

rho=4; theta=50;

% Implemento la function che in output mi resistuisce un 
% nunero complesso in forma cartesiana 

z=cartesianizza(rho, theta); 

% Inserisco i numeri complessi in forma cartesiana che 
% mi da l'esercizio

% a=7.8785 + 1.3892*i; b=5.6382 - 2.0521*i;
% c=1.5628 + 8.8633*i; d=2.5712 + 3.0642*i

% Calcolo il risultato

% Risultato = (a+b)/(c+d)

ris = z\a + j*2