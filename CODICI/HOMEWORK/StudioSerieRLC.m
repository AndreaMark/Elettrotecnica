close all
clear all
clc

tic
% Circuito Serie RLC

% Fornisco dei dati di inpunt

        R=10; L=6e-7; C=1e-9; 

      % Sia dato il fasore del generatore

        VG=i;
        
      % Definisco un insieme di frequenze e calcolo 
      % pulsazione omega
      
      f=linspace(1e6,4e7,3000);
      omega=2*pi*f;
      

% Calcolo le reattanza X e i relativi operatori/fasori 
% impedenza Z

XR=R; XL=omega*L; XC=1./(omega*C); 
ZR=XR; ZL=j*XL; ZC=-j*XC;

% Poichè XL e XC sono vettori, dovrò rendere vettore
% anche R, affinchè le operazioni tra le tre impedenze 
% abbiano senso, perciò: 

Rvett=10*ones(1,length(f)); XRvett=Rvett; ZRvett=XRvett;

% L'impedenza della SERIE RLC sarà:

ZRLC_serie=ZRvett+ZL+ZC;

Z=R+j*omega*L+1./(j*omega*C);

% La corrente che scorre sul circuito serie sarà:

I = VG./ZRLC_serie;

% Calcolo della pulsazione di risonanza omega_r
% Calcolo della frequenza di risonanza f_r

omega_r=1/sqrt(L*C)
f_r=omega_r/(2*pi)

% A questo punto grafico l'andamento della frequenza 
% in funzione della corrente 

figure

subplot(2,2,1)
plot(f,abs(I),'linewidth',2)
xlabel('Frequenza [Hz]')
ylabel('|I| [A]')
grid on

subplot(2,2,2)
semilogx(f,abs(I),'linewidth',2)
xlabel('Frequenza [Hz]')
ylabel('|I| [A]')
grid on

Frequenza_di_risonanza=interp1(abs(I),f,max(abs(I)))

subplot(2,2,3)
plot(f,Rvett,'r',f,XL,'c',f,-XC,'y',f,abs(ZRLC_serie),'b','linewidth',2)
xlabel('Frequenza [Hz]')
ylabel('|I| [A]')
legend( 'R', 'X_L', 'X_C', '|ZRLC_{serie}|')
grid on

subplot(2,2,4)
semilogx(f,Rvett,'r',f,XL,'c',f,-XC,'y',f,abs(ZRLC_serie),'b','linewidth',2)
xlabel('Frequenza [Hz]')
ylabel('|I| [A]')
legend( 'R', 'X_L', 'X_C', '|ZRLC_{serie}|')
grid on

set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
sgtitle("Circuito RLC in serie")

toc



