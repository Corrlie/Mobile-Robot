function q_d_wielomian = gsr_wielomian(t_wielomian)

global Qd01 Qd11 Qd21 Qd31 Qd02 Qd12 Qd22 Qd32

q_d_wielomian_1  = Qd01+Qd11*t_wielomian+Qd21*t_wielomian^2+Qd31*t_wielomian^3;
q_d_wielomian_2 = Qd02+Qd12*t_wielomian+Qd22*t_wielomian^2+Qd32*t_wielomian^3;

q_d_wielomian = [q_d_wielomian_1; q_d_wielomian_2];
end