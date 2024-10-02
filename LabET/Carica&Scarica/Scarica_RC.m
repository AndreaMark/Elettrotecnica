close all
clear all
clc

% Definisco un set di valori globali
global  R C
R = 1e3; C = 1e-6; V_C_0 = 2;

% Risolvo l'equazione differenziale associata al problema della scarica del
% condensatore

[t2,v_C] = ode45(@RC, [0 10*R*C], V_C_0);

% trovato v_C sono ora in grado di trovarmi la corrente circolante sul
% circuito tramite la legge di Ohm V = R*I


I = (v_C)/R;

% Ricordandoci delle condizioni iniziali 

t1 = linspace(-10*R*C, 0);
I_0 = 0;
V_C_0 = 2;

% Visualizzo ora i grafici degli andamenti (anche attraverso opportuni
% fattori di scala per aiutarci nella visualizzazione)

figure
h1 = plot(t1,V_C_0,'r.-', t2,v_C,'r.-');
hold on
h2 = plot(t2,100*I,'b.-', t1,I_0,'b.-');
hold off
legend([h1(1), h2(1)], 'Tensione','Corrente');

xlabel( 'Tempo [s]')
title('Scarica del condensatore')

ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
ax.XLim = [-10*R*C 10*R*C];
ax.YLim = [-0.5 2.1];
grid on 