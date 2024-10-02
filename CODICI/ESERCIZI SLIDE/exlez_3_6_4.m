clear all
close all
clc


% Inserimento dei dati

R=3; X=4; V3primo0fasore=100*exp(j*0);

% La corrente I3=I3' che scorre sulla linea 3 è

I3 = V3primo0fasore/(j*X); 

% La caduta di potenziale tra 3 e 3' sarà

V33primofasore = R*I3; 

% Attraverso la legge di ohm generalizzata si trovail fasore del generatore
% V30=E3

E3fasore = V33primofasore + V3primo0fasore; 

% il valore efficace della tensione concatenata sarà, per definizione 

V = sqrt(3)*abs(E3fasore); 

% il fasore della tensione concatenata V12 è a partire dalla tensione
% concatenata V12 e  dai fasori E1 ed E3

V12fasore = sqrt(3)*E3fasore*exp(j*(3*pi/2));

% il valore di V12(t) sarà determinato a partire dall'argomento e da valore massimo del
% fasore corrispondente, per cui

V12max = abs(V12fasore)*sqrt(2); 

phi = rad2deg(angle(V12fasore)); 

% alla fine il risultato da stampare sarà 

fprintf('v12(t) = %3.2d sin(wt + %3.2d)\n', V12max, phi)