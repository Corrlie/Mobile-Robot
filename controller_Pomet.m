function out = controller_Pomet(in)

theta_d = in(1);
x_d = in(2);
y_d = in(3);

theta = in(4);
x = in(5);
y = in(6);

t = in(7);

e_theta = theta_d-theta;
e_x = x_d - x;
e_y = y_d - y;

e = [e_theta; e_x; e_y];

R = [1 0 0;
    0 cos(theta_d) sin(theta_d);
    0 -sin(theta_d) cos(theta_d)];

e_p = -R*e;

Omega = 1;
k1 = 1;
k2 = 1;
k3 = 1;
k4 = 1;
delta_p = 0.01;
%%%%%%%%%%%%%%% pierwsza funkcja - 5.35

% h = k4*((e_p(2))^2+(e_p(3))^2)*cos(Omega*t); % 5.35
% 
% dhde_p2 = 2*e_p(2)*k4*cos(Omega*t); % pod 5.26
% dhde_p3 = 2*e_p(3)*k4*cos(Omega*t); % pod 5.26
% 
% dhdt = -Omega*k4*((e_p(2))^2+(e_p(3))^2)*sin(Omega*t); % do 5.20

%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%% druga funkcja - 5.36
h = k4 * (((e_p(2))^2+(e_p(3))^2)/((e_p(2))^2+(e_p(3))^2+(delta_p)^2))*cos(Omega*t); % 5.36

dhde_p2 = (2*e_p(2)*k4*cos(Omega*t))/(e_p(2)^2+e_p(3)^2+delta_p)-(2*e_p(2)*k4*cos(Omega*t)*(e_p(2)^2+e_p(3)^2))/(e_p(2)^2+e_p(3)^2+delta_p)^2;
dhde_p3 = (2*e_p(3)*k4*cos(Omega*t))/(e_p(2)^2+e_p(3)^2+delta_p)-(2*e_p(3)*k4*cos(Omega*t)*(e_p(2)^2+e_p(3)^2))/(e_p(2)^2+e_p(3)^2+delta_p)^2;

dhdt = -Omega * k4 * (((e_p(2))^2+(e_p(3))^2)/((e_p(2))^2+(e_p(3))^2+(delta_p)^2)) * sin(Omega*t);

%%%%%%%%%%%%%%

Lg1V = k1*(e_p(1)+h); % 5.25
Lg2V = (k2*e_p(2)+k1*(e_p(1)+h)*dhde_p2)*cos(e_p(1))+(k3*e_p(3)+k1*(e_p(1)+h)*dhde_p3)*sin(e_p(1)); % 5.26

u1 = -Lg1V-dhdt; % 5.20
u2 = -Lg2V;

%u = [u1;u2];

e_p_theta = e_p(1);
e_p_x = e_p(2);
e_p_y = e_p(3);

out = [u1; u2; e_p_theta; e_p_x; e_p_y; h];

end