clear all
close all
clc

tic
% Inserimento dati
% R = 1.8 kOhm per ogni caso
% Caso1: f=240Hz, C=0.33microF
% Caso2: f=720Hz, c=0.33microF
% Caso3: f=240Hz, c=2.2microF

global R f1 f2 C1 C2 Emax omega1 omega2 tao1 tao2 
R=1.8e3; f1=240; f2=750; C1=0.33e-6; C2=2.2e-6;

omega1 = 2*pi*f1; omega2 = 2*pi*f2; tao1 = R*C1; tao2 = R*C2;
Emax = 2;  phi = 0; % A fase nulla %
V_C_0 = 0; % Il condensatore è scarico %

% Il calcolo della funzione di carica e scarica del condensatore è lasciato
% alla funzione ODE45 che implementa la function @RC_lab1,2,3 per essere
% risolta, dunque si ha, per il 
% CASO 1: f1 = 240Hz, C1=0.33microF, omega1 = 2*pi*f1, tao1 = R*C1
% CARICA COMPLETA

[t,v_C_1] = ode45(@RC_lab1, [0 10*tao1], V_C_0);

% L'onda quadra a generatore  carica e scarica il condensatore: 
% è come se fosse un interruttore che, in maniera periodica, 
% alimenta e disalimenta il circuito; è dotata di una frequenza 
% e di un'ampiezza.
% Si noti poi come l'informazione sul vettore dei tempi è contenuta in ODE45, 
% in special modo nel tremine [0 10*tao1]. 
% Il segnale sorgente sarà in questo modo:

E1 = sign(Emax*sin(omega1*t));  

    % Visualizzazione risultati grafici
    figure
    plot(t,E1,'y.-', 'LineWidth', 2)
    hold on
    plot(t,v_C_1, 'c.-', 'LineWidth', 2)
    grid on
    ylabel('Tensione [V]')
    xlabel('tempo [s]')
    title('Scarica condensatore Caso1')
    legend('Generatore', 'Condensatore', 'textcolor', 'white')
    legend boxoff
    % Impostazione degli assi
    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    ylim([-1.5 1.5]) 
    % Allarga immagine a schermo intero
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    set(gca, 'Color','k', 'XColor','w', 'YColor','w')

% CASO 2: f2 = 720Hz, C1=0.33F, omega2 = 2*pi*f2, tao1 = R*C1
% CARICA INCOMPLETA, FREQUENZA

[t,v_C_2] = ode45(@RC_lab2, [0 10*tao1], V_C_0);
E2 = sign(Emax*sin(omega2*t));

    %Visualizzazione 
    figure
    plot(t,E2,'y.-', 'LineWidth', 2)
    hold on
    plot(t,v_C_2, 'c.-', 'LineWidth', 2)
    grid on
    ylabel('Tensione [V]')
    xlabel('tempo [s]')
    title('Scarica condensatore Caso2')
    legend('Generatore', 'Condensatore', 'textcolor', 'white')
    legend boxoff
    % Impostazione degli assi
    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    ylim([-1.5 1.5]) 
    % Allarga immagine a schermo intero
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    set(gca, 'Color','k', 'XColor','w', 'YColor','w')

% CASO 3: f1 = 240Hz, C2=2.2F, omega1 = 2*pi*f1, tao2 = R*C2
% CARICA INCOMPLETA, CAPACITà

[t,v_C_3] = ode45(@RC_lab3, [0 10*tao2], V_C_0);
E3 = sign(Emax*sin(2*pi*f1*t));

    % Visualizzazione
    figure
    plot(t,E3,'y.-', 'LineWidth', 2)
    hold on
    plot(t,v_C_3, 'c.-', 'LineWidth', 2)
    grid on
    ylabel('Tensione [V]')
    xlabel('tempo [s]')
    title('Scarica condensatore Caso3')
    legend('Generatore', 'Condensatore', 'textcolor', 'white')
    legend boxoff
    % Impostazione degli assi
    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    ylim([-1.5 1.5]) 
    % Allarga immagine a schermo intero
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    set(gca, 'Color','k', 'XColor','w', 'YColor','w')
toc

