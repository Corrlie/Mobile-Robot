function out = controller_VFO_point(in)


Kp = 1;
Ka = 2*Kp;
% --- inne dobory nastaw

% eta = 0.9;
% --- koniec innych doborow nastaw


delta = 0.001;

theta_d = in(1);
x_d = in(2);
y_d = in(3);

theta = in(4);
x = in(5);
y = in(6);

eta = 0.8;

e_x = x_d-x;
e_y = y_d-y;
e = [e_x;e_y]; % 6.12
e_norm = norm(e);

g2 = [cos(theta_d); sin(theta_d)]; % 6.27

ed_x0 = e_x(1)*cos(theta_d)+e_y(1)*sin(theta_d); % 6.28
% sigma = sign(ed_x0); % 6.28
sigma = sgn_fun(ed_x0);
v = -eta*sigma*e_norm*g2; % 6.27

h_hat = Kp*e+v; % 6.11
h_x = h_hat(1); % 6.12
h_y = h_hat(2); % 6.12

% 6.32:
if e_norm > delta
    u2 = h_x*cos(theta)+h_y*sin(theta); % 6.16

    eTqp = e_x*u2*cos(theta)+e_y*u2*sin(theta);

    dh_x = -Kp*u2*cos(theta)+eta*sigma*(eTqp/(sqrt(e_x^2+e_y^2)))*cos(theta_d);
    dh_y = -Kp*u2*sin(theta)+eta*sigma*(eTqp/(sqrt(e_x^2+e_y^2)))*sin(theta_d);

    dtheta_a = (dh_y*h_x-h_y*dh_x)/(h_x^2+h_y^2); % 6.13

    atan2_help = atan2(sigma*h_y, sigma*h_x); % 6.9
    theta_a = Atan2c_fun(atan2_help); % 6.9
else 
    u2 = 0; % 6.32
    dtheta_a = 0; % 6.31
    theta_a = theta_d; % 6.30
end


e_a = theta_a-theta; % 6.10

h_theta = Ka*e_a+ dtheta_a;

u1 = h_theta; %6.15


out = [u1; u2; e_a];

end