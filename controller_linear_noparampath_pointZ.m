function out = controller_linear_noparampath_pointZ(in)

global dzeta Lz

F = in(1);
Fx = in(2);
Fy = in(3);
Fxx = in(4);
Fyy = in(5);
Fxy = in(6);

theta = in(7);
x = in(8);
y = in(9);

Kp = 1;

% vd = 0.25;
vd = 1;


gradientF =[Fx; Fy];
v=-gradientF/norm(gradientF);

w = Kp*F*v+vd*[0 1; -1 0]*v;

D=[-Lz*sin(theta) cos(theta);
    Lz*cos(theta) sin(theta)];

u=inv(D)*w;

out=[u; F];

end