function out = controller_linear_trajectory(in)

q_d = in(1:3);
q = in(4:6);
om_d = in(7);
v_d = in(8);

theta_d = q_d(1);
x_d = q_d(2);
y_d = q_d(3);


theta = q(1);
x = q(2);
y = q(3);

u_d1 = om_d;
u_d2 = v_d;

e_theta = theta_d - theta;
e_x = x_d - x;
e_y = y_d - y;
e = [e_theta; e_x; e_y];


dzeta = 1;
alfa = 2;

R = [1 0 0;
    0 cos(theta) sin(theta);
    0 -sin(theta) cos(theta)];

e_p = R*e; % b³¹d przekszta³cony

k11 = -2*dzeta*sqrt(u_d1^2+alfa*u_d2^2);
k12 = 0; 
k13 = -alfa*u_d2;
k21 = 0;
k22 = -2*dzeta*sqrt(u_d1^2+alfa*u_d2^2);
k23 = 0;

u = [u_d1-k11*e_p(1)-k12*e_p(2)-k13*e_p(3);
    u_d2*cos(e_p(1))-k21*e_p(1)-k22*e_p(2)-k23*e_p(3)];

out = u;
end
