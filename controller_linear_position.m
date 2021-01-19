function out = controller_linear_position(in)

global Lz;

%%%%%%%%%%%% pamietac o ustawieniu Lz, bo inaczej bledy z wymiarami
%%%%%%%%%%%% macierzy

% % 
% % q_d = in(1:3); % theta_d x_d y_d
% % dq_d = in(4:5); % dx_d dy_d
% % q = in(6:8); % theta, x, y

theta_d = in(1);
x_d = in(2);
y_d = in(3);

dx_d = in(4);
dy_d = in(5);

theta = in(6);
x = in(7);
y = in(8);

q_d = [x_d; y_d];
dq_d = [dx_d; dy_d];
q = [x;y];

D = [-Lz*sin(theta) cos(theta);
    Lz*cos(theta) sin(theta)];
%%%% T1 i T2 - za³o¿one sta³e czasowe zaniku poszczególnych sk³adowych
%%%% uchybu e_Z - (4.85)

T1 = 1;
T2 = 1;

k11 = 1/T1; 
k12 = 0;
k21 = 0;
k22 = 1/T2;

K = [k11 k12;
    k21 k22];

q_Z = q+Lz*[cos(theta);sin(theta)];

e_Z = q_d-q_Z;

u = inv(D)*(K*e_Z+dq_d);

out = [u; e_Z];

end