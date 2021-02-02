function out = controller_VFO_path_noparam(in)

global dzeta


F= in(1);
Fx = in(2);
Fy = in(3);
Fxx = in(4);
Fyy = in(5);
Fxy = in(6);

theta = in(7);
x = in(8);
y = in(9);

Kp = 1;
Ka = 2*Kp;

% v_d = dzeta*0.25; 
v_d = 0.25;

R = [0 1;-1 0]; % pod (9)
nabla_F = [Fx; Fy];
norm_nabla_F = norm(nabla_F);
w = -nabla_F; % (9)
w_per = R*w; % (9)

v_vec = w/norm_nabla_F; % (11)
v_x = v_vec(1);
v_y = v_vec(2);

hp = (v_d *R+Kp*F*eye(2))*v_vec; % (10)
hx = hp(1); % (7)
hy = hp(2); % (7)

atan2_help = atan2(dzeta*hy, dzeta*hx);
theta_a = Atan2c_fun(atan2_help); % (12)

e_a = theta_a - theta; 

u2 = hx*cos(theta)+hy*sin(theta); % pod (17)

dF = (Fx*cos(theta)+Fy*sin(theta))*u2; % pod (16)

help_mat_dv_vec =[Fy*((Fx*Fxy-Fy*Fxx)*cos(theta)+(Fx*Fyy-Fy*Fxy)*sin(theta)); 
    Fx*((Fy*Fxx-Fx*Fxy)*cos(theta)+(Fy*Fxy-Fx*Fyy)*sin(theta))];
dv_vec = (u2/(norm_nabla_F^3))*help_mat_dv_vec;
dv_x = dv_vec(1);
dv_y = dv_vec(2); % pod (16)

dhp = [v_d*dv_y+Kp*(dF*v_x+F*dv_x); 
    -v_d*dv_x+Kp*(dF*v_y+F*dv_y)]; % (16)
dhp_x = dhp(1);
dhp_y = dhp(2);

dtheta_a = (dhp_y*hx-hy*dhp_x)/(hx^2+hy^2); % (15)
h_theta = Ka*e_a+dtheta_a; % (14)

u1 = h_theta;

out = [u1;u2; e_a; F]; % (8)


end
% % 
% % function out = controller_VFO_path_noparam(in)
% % 
% % global dzeta
% % 
% % F = in(1);
% % Fx = in(2);
% % Fy = in(3);
% % Fxx = in(4);
% % Fyy = in(5);
% % Fxy = in(6);
% % 
% % theta = in(7);
% % x = in(8);
% % y = in(9);
% % 
% % Kp = 1;
% % Ka = Kp*2;
% % 
% % vr = dzeta*0.2;
% % 
% % R = [0, 1; -1, 0];
% % gradientF =[Fx; Fy];
% % w = -gradientF;
% % w2 = R*w;
% % 
% % ve = w/norm(gradientF);
% % vex = ve(1);
% % vey = ve(2);
% % hp = (vr*R + Kp*F*eye(2))*ve;
% % hx = hp(1);
% % hy = hp(2);
% % 
% % 
% % atan2_help = atan2(dzeta*hy, dzeta*hx);
% % thetaa = Atan2c_fun(atan2_help); % (12)
% % 
% % 
% % % thetaa = Atan2c_fun([dzeta*hy, dzeta*hx, thetaa]);
% % ea = thetaa - theta;
% % 
% % u2 = hx*cos(theta) + hy*sin(theta);
% % Fr = (Fx*cos(theta) + Fy*sin(theta))*u2;
% % ver = (u2/norm(gradientF)^3)*[Fy*((Fx*Fxy - Fy*Fxx)*cos(theta) + (Fx*Fyy - Fy*Fxy)*sin(theta)); 
% %        Fx*((Fy*Fxx - Fx*Fxy)*cos(theta) + (Fy*Fxy - Fx*Fyy)*sin(theta))];
% % 
% % vexr = ver(1);
% % veyr = ver(2);
% % hpr = [vr*veyr + Kp*(Fr*vex + F*vexr); -vr*vexr + Kp*(Fr*vey + F*veyr)];
% % hxr = hpr(1);
% % hyr = hpr(2);
% % 
% % thetaar = (hyr*hx - hy*hxr)/(hx^2 + hy^2);
% % thetah = Ka*ea + thetaar;
% % 
% % u1 = thetah;
% % 
% % out=[u1, u2];
% % 
% % end
