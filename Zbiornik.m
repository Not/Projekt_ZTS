h0=40;
Fh0=15;
Fc0=27;
Fd0=12;
Tc=18;
Th=78;
Td=48;
T0=41.3;
a=8.5;
c=3;
F_H=Fh0
F_C=Fc0
F_D=Fd0

close all
clc




A = [ -2/(3* c * h0 ^3) *( Fh0 + Fc0 + Fd0 ) + a /(2* c* h0 ^(2.5) ) 0;
-3/( c * h0 ^4) *( Fh0 *( Th - T0 ) + Fc0 *( Tc - T0 ) + Fd0 *( Td - T0 ) ) -1/( c * h0 ^3) *( Fh0 +Fc0 + Fd0 ) ]

B = [1/(3* c * h0 ^2) 1/(3* c * h0 ^2) ;
1/( c * h0 ^3) *( Th - T0 ) 1/( c * h0 ^3) *( Tc - T0 )]

Bd = [1/(3* c * h0 ^2) ; 1/( c* h0 ^3) *( Td - T0 ) ]
C = eye (2) ;
D = zeros (2 ,3) ;

BBd=[B Bd]

system=ss(A,BBd,C,D);
systf=tf(system)
t=(0:1:80000);
[y,t,x]=step(system,t);

max_t=200000;
h=0.1;
t=0:h:max_t-h;
u=zeros(max_t/h,3);
u(1/h+1:end,1)=Fh0;
u(1/h+1:end,2)=Fc0;
u(1/h+1:end,3)=Fd0;
[y,t,x]=lsim(system,u,t);



%Gs=zpk(systf(2,3));%do wy�wietlenia w dobrym formacie
%[z,p,k]=zpkdata(Gs);
%Gs=zpk(z,p,k,'DisplayFormat','time constant')
%systemd=c2d(system,100,'foh');
%systfd=tf(systemd)
%[y,t,x]=step(systemd,t);

subplot(2,1,1);

plot(t,x(:,1),'-b','LineWidth',2)
hold on
plot(h_simulink,'-r','LineWidth',2);
ylabel('wysokosc cieczy [cm]')
title({'Odpowiedz uk�adu zlinearyzowanego'})
xlabel('Czas[s]')
subplot(2,1,2); 
plot(t,x(:,2),'-b','LineWidth',2)
hold on
plot(T_simulink,'-r','LineWidth',2);
legend('Linearyzacja','Oryginalny')
ylabel('Temparatura[]')
xlabel('Czas[s]')

