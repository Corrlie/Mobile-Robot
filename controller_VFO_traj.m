function out = controller_VFO_traj(in)

global dzeta;

%%%%%%% wejscia

theta_d = in(1);
x_d = in(2);
y_d = in(3);

dx_d = in(4);
dy_d = in(5);

theta = in(6);
x = in(7);
y = in(8);

ddx_d = in(9);
ddy_d = in(10);

%%%%%%% zmienne

sigma = dzeta;

Kp = 1;
Ka = 2*Kp;
% --- inne dobory nastaw

% Kp = 2;
% Ka = 2*Kp;

% --- koniec innych doborow nastaw

e_x = x_d-x;
e_y = y_d-y;
e = [e_x;e_y]; % 6.12

v_x = dx_d;
v_y = dy_d;
v = [v_x; v_y]; % 6.12

h_hat = Kp*e+v; % 6.11
h_x = h_hat(1); % 6.12
h_y = h_hat(2); % 6.12

% % % %%%% okreslenie epsilona
% % % val_inf_help = sqrt(dx_d^2+dy_d^2);
% % % val_inf = lowerbound(val_inf_help);
% % % 
% % % epsilon = abs(0.5*val_inf); % epsilon jako w polowie z nierownosci 6.23

atan2_help = atan2(sigma*h_y, sigma*h_x); % 6.9
theta_a = Atan2c_fun(atan2_help); % 6.9
    
   


e_a = theta_a-theta; % 6.10

dv_x = ddx_d;
dv_y = ddy_d;

u2 = h_x*cos(theta)+h_y*sin(theta);

dh_x = Kp*(dx_d-u2*cos(theta))+dv_x;
dh_y = Kp*(dy_d-u2*sin(theta))+dv_y;

dtheta_a = (dh_y*h_x-h_y*dh_x)/(h_x^2+h_y^2); % 6.13


h_theta = Ka*e_a+ dtheta_a;

u1 = h_theta;


out = [u1; u2; e_a];



end