function out = controller_linear_path(in)

global dzeta

om_d = in(1);
v_d = in(2);

theta_d = in(3);
x_d = in(4);
y_d = in(5);

theta = in(6);
x = in(7);
y = in(8);

kappa_d = in(9);


j_S = [cos(theta_d+pi/2);
    sin(theta_d+pi/2)];

q_el = [x;y]; % (1.9)
q_del = [x_d;y_d]; % (1.9)

e_l_help = q_el - q_del; % (1.9)
e_l = sign(e_l_help'*j_S)*norm(e_l_help);
% e_l = sgn_fun(e_l_help'*j_S)*norm(e_l_help);

e_theta = theta-theta_d; % (1.14)

k1 = 9;
k2 = 6;

u1 = -v_d*(k1*dzeta*e_l+k2*e_theta-((dzeta*kappa_d*cos(e_theta))/(1-e_l*kappa_d)));
u2 = dzeta*v_d;

out = [u1;u2];
end