close all
clear all
clc

% dati
R1=1; R2=1000;

% matrice potenziali nodali

An = [...
1/R1+1/(2*R1)+1/R2 -(1/(2*R1)+1/R2)
-(1/(2*R1)+1/R2) 1/R1+1/(2*R1)+1/R2];

C1 = cond(An)

Ln=eig(An);

C1_controllo = max(Ln)/min(Ln)

% matrice correnti di maglia

Ac = [...
R1+R2+R1 R2
R2 R2+2*R1];

C2 = cond(Ac)

Lc=eig(Ac);

C2_controllo = max(Lc)/min(Lc)


