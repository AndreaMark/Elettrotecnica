close all
clear all
clc


R1 = linspace(1, 100);
R2 = linspace(1, 100);

% matrice potenziali nodali

An = [...
1./R1+1./(2*R1)+1./R2 -(1./(2*R1)+1./R2)
-(1./(2*R1)+1./R2) 1./R1+1./(2*R1)+1./R2];

C1 = cond(An)

% matrice correnti di maglia

Ac = [...
R1+R2+R1 R2
R2 R2+2+R1];

C2 = cond(Ac)

% stampa risultati

fprintf('R1\t R2\t PotNodali\t CorrMaglia\n');...
fprintf('%d\t %d\t %d\t %d\n',[(1:100);(1:100);C1;C2])