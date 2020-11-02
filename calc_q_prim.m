function out_calc_q_prim = calc_q_prim(in)

u = in(1:2);
omega = u(1);
v = u(2);
u_vec = [omega; v];

q = in(3:5);
theta = q(1);
x = q(2);
y=q(3);

G = [1 0;
    0 cos(theta);
    0 sin(theta)];

q_prim = G*u_vec;

out_calc_q_prim = q_prim;

end
