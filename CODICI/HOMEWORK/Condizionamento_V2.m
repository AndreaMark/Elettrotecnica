close all
clear all
clc

tic
% Ciclo for
M=1000;
R1=linspace(1,M);
R2=linspace(M,1);

for i=1:length(R1)
    for j=1:length(R2)
% Matrice dai Potenziali Nodali

An = [...
1/R1(i)+1/(2*R1(i))+1/R2(j)  -(1/(2*R1(i))+1/R2(j))
-(1/(2*R1(i))+1/R2(j))  1/R1(i)+1/(2*R1(i))+1/R2(j)];

C1 (i,j)= cond(An); % Condizionamento Potenziali Nodali

% Matrice dalle Correnti di Maglia

Ac = [...
R1(i)+R2(j)+R1(i)  R2(j)
R2(i)  R2(j)+2*R1(i)];

C2 (i,j)= cond(Ac); % Condizionamento Correnti di Maglia

    end
end

toc

subplot(2,2,1)
bar3(C1)
subplot(2,2,2)
plot(C1)
subplot(2,2,3)
bar3(C2)
subplot(2,2,4)
plot(C2)








