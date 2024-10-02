close all
close force all hidden
clear all
clc

tic
% Circuito Serie RLC

% Fornisco dei dati di inpunt

        R=10; L=6e-7; C=1e-9; 

      % Sia dato il fasore del generatore

        VG=1;
        
      % Definisco un insieme di frequenze e calcolo 
      % pulsazione omega
      
      f=linspace(1e6,4e7,3000);
      omega=2*pi*f;
      

% Calcolo l'operatore ammettenza Y = 1/Z dalle impedenze Z e dalle reattanza X 
% l'operatore ammettenza è così definito: Y = 1/(R+jX) 

XR=R; XL=L.*omega; XC=1./(omega*C); 
ZR=XR; ZL=j*XL; ZC=-j*XC;

BR=1/XR; BL=1./XL; BC=1./XC; 
YR=1/ZR; YL=1./ZL; YC=1./ZC;

% Poichè XL e XC sono vettori, dovrò rendere vettore
% anche R, affinchè le operazioni tra le tre impedenze 
% abbiano senso, perciò: 

Rvett=R*ones(1, length(f)); BRvett=1./Rvett; YRvett=BRvett;

% L'ammettenza del PARALLELO RLC sarà:

YRLC_parallelo = YRvett + YC + YL;

% L'impedenza del PARALLELO RLC sarà:

ZRLC_parallelo = 1./YRLC_parallelo;

% La corrente che scorre sul circuito parallelo sarà:

I = VG.*YRLC_parallelo;

% Calcolo della pulsazione di risonanza omega_r
% Calcolo della frequenza di risonanza f_r

omega_r = 1/sqrt(L*C)
f_r = omega_r/(2*pi)

% A questo punto grafico l'andamento della frequenza 
% in funzione della corrente 

figure

subplot(3,2,1)
plot(f,abs(I),'linewidth',2)
xlabel('Frequenza [Hz]')
ylabel('|I| [A]')
grid on

subplot(3,2,2)
semilogx(f,abs(I),'linewidth',2)
xlabel('Frequenza [Hz]')
ylabel('|I| [A]')
grid on

Frequenza_di_risonanza=interp1(abs(I),f,min(abs(I)))

subplot(3,2,3)
plot(f, BRvett,'r', f, -BL, 'c', f, BC, 'y', f, abs(YRLC_parallelo), 'b', 'linewidth', 2)
xlabel('Frequenza [Hz]')
ylabel('|I| [A]')
legend( 'G', 'B_L', 'B_C', '|YRLC_{parallelo}|')
grid on

subplot(3,2,4)
semilogx(f,BRvett,'r',f,-BL,'c',f,BC,'y',f,abs(YRLC_parallelo),'b','linewidth',2)
xlabel('Frequenza [Hz]')
ylabel('|I| [A]')
legend( 'G', 'B_L', 'B_C', '|YRLC_{parallelo}|')
grid on

subplot(3,2,5)
plot(f,Rvett,'r',f,XL,'c',f,-XC,'y',f,10*abs(ZRLC_parallelo),'b','linewidth',2)
xlabel('Frequenza [Hz]')
ylabel('|I| [A]')
legend( 'R', 'X_L', 'X_C', '|ZRLC_{parallelo}|')
grid on

subplot(3,2,6)
semilogx(f,Rvett,'r',f,XL,'c',f,-XC,'y',f,10*abs(ZRLC_parallelo),'b','linewidth',2)
xlabel('Frequenza [Hz]')
ylabel('|I| [A]')
legend( 'R', 'X_L', 'X_C', '|ZRLC_{parallelo}|')
grid on



set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
sgtitle("Circuito RLC in parallelo")

toc
