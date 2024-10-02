function [X]=risoluzione_matrici(A,B)

% risoluzione_matrici
% funzione che implementa la risuluzione dei sistemi lineari 
% attraverso il comando "\: questo approccio utilizza l'eliminazione Gaussiana 

% Calcolo dell'output

X = A\B;

% Stampa dell'output

fprintf('Il risultato del prodotto matriciale e'' %6.2 \n', X);

end

