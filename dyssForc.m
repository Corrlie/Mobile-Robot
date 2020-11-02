function dyssForces = dyssForc(input)

global D_aom D_av C_r J_inv b m g r


omega = input(1);
v = input(2);

u = [omega;v];


N_a_om = D_aom*abs(omega)*omega;

F_a_v = D_av*abs(v)*v;

F_a_u = [N_a_om; F_a_v];

OmegaLP = J_inv*u;

omega_p = OmegaLP(1);
omega_l = OmegaLP(2);

wsp_strom = 2;

N_r = (b/2) * m*g * C_r *(tanh(wsp_strom*r*omega_p) - tanh(wsp_strom*r*omega_l));
F_r = (1/2) *  m*g * C_r *(tanh(wsp_strom*r*omega_p) + tanh(wsp_strom*r*omega_l));

F_r_vec = [N_r;F_r];

F_out = F_a_u+F_r_vec;

dyssForces = F_out;

end

