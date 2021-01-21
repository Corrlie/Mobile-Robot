% WK 

clc;
clear all;
close all;

global M_inv H B D_aom D_av C_r J_inv N_inv K_m R_m_inv b m g r theta0 is_init_atan2c Lz
%%%%%%%%%%%%%%%%%%%%%%%% GSR
% 
% T_P = 0.01;
% T_L = 0.0099;
% T = [T_P;T_L];
%%% trajektoria
theta0 = 0;
is_init_atan2c = 1;
% 
% x0=0.5;
% y0=0.5;

%%%%%% ster vfo traj
% % x0 = 0;
% % y0 = 0;

%%%%% vfo punkt
point_x_d = 0;
point_y_d = -1;
x0 = 0;
y0 = 1;

% sterownik pometa
% x0 = 0;
% y0 = 1;
% point_x_d = 0;
% point_y_d = -1;

% sciezka kolowa?
% x0=0.5;
% y0=0;
%%%% punkt
% point_x_d = -2;
% point_y_d = -1;
point_d = [point_x_d;point_y_d];
q0 = [theta0; x0; y0];

%%%%%%%% punkt z
% Lz = 1;


Um = [9;9];
Umax = 9; % duza wartosc bo brak nasycenia 
%%%%%%%%%%%%%%%%%%%%%%%

% % % dynamika PARAMETRY

g = 9.81;

m = 0.6; % masa robota
b = 0.033;
r = 0.026; % promien kola
a = 0.078;
c = 0.078;

m_kola = 0.03; % masa kola 

Ic = (1/12)*m*(a^2+c^2); % mom bezwl

I_kP = 1.014*10^-5; % mom bezwladnosci kola - ?liczone z bezwld walca wzgl Iz?
I_kL = I_kP;
Ik = I_kL;
Ik_mat = [I_kP 0; 0 I_kL]; % macierz bezwl - mom bezw³ kó³ praw i lewe

I_mP = 4.22*10^-7; % 4.22 g*cm^2 
I_mL = I_mP;
Im = I_mL;
Im_mat = [I_mP 0; 0 I_mL]; % macierz bezwl wirnikow silnikow nap

ng = 1/12;
N = [ng 0;0 ng]; % macierz wsp przelozenia przekladni red
N_inv = inv(N);

km = 8.55*10^-3; % 8.55 mN*m/A
K_m = [km 0; 0 km]; % macierz stalych maszynowych zastosowanych silnikow

R_mP = 3.78;
R_mL = R_mP;
R_m = [R_mP 0; 0 R_mL]; % macierz rezystancji uzwojen twornikow praw i lew silnika
R_m_inv = inv(R_m);

ksi_P = 10^-4;   % 1.85*10^-8;
ksi_L = ksi_P;
Ksi = ksi_L;
Ksi_mat = [ksi_P 0;0 ksi_L]; % wspolczynniki tarcia wiskotycznego zalezne 

ksi_M_P = 1.85*10^-8;
ksi_M_L = ksi_M_P;
Ksi_m = ksi_M_L;
Ksi_m_mat =[ksi_M_P 0; 0 ksi_M_L]; % tlumienie wiskotyczne  

M = [Ic+((2*b^2)/(r^2))*Ik+((2*b^2)/(r^2*ng^2))*Im 0;0 m+(2/(r^2))*Ik+(2/(r^2*ng^2))*Im]; % 2,63
M_inv = inv(M);

H = [((2*b^2)/(r^2))*(Ksi+1/(ng^2)*Ksi_m) 0;0 (2/(r^2))*(Ksi+1/(ng^2)*Ksi_m)]; % 2.64

B = [b/(r*ng) -b/(r*ng); 1/(r*ng) 1/(r*ng)]; % 2.65


% %%%%%%%%%%%%%%% Si³y dyssypatywne

J = [r/(2*b) -(r/(2*b)); r/2 r/2];

J_inv = inv(J);

D_aom = 0.0005; % 5*10^-4 kg m^2
D_av = 0.005; % 5*10^-3 kg/m

C_r = 0.0005; % 5*10^-4 [-]


%%%%%%%%%%%%%%%%%%%%%%

%%%%%%% regulatory

K = 9.39; % (rad/s)/V
T = 0.095; %s
fp = 18;
Tp = 1/fp; % czas ustalania
zeta_0 = 1;
% om_0 = 2*pi/(zeta_0*Tp);
% om_0 = 114;
om_0 = 126; %takie jak prow
omega_dc = [80;80];

kp = (2*T*zeta_0*om_0-1)/K;
ki = (T*om_0^2)/(K*kp);
% kc = 69; % dobrane nierownosc 3.39 a ki = 67.7730
% kc = 2*ki;
kc = ki + 50;
% kc = 0;
Tf = 1/ki;


%%%%%%%%%%%%%%% skalowanie predkosci

om_k_max = 161.5;

% uruchoimenie symulacji
% sim('robotMobilny.mdl', [0 10]);

% show_CartPlotZ; % automatyczne uruchomienie m pliku show_CartPoleZ (kola
% i punkt Z)
