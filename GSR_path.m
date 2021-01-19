function out = GSR_path(in)
    theta = in(1);
    x = in(2);
    y = in(3);
    option = in(4);
    dzeta = 1; 
%     dzeta = -1;
    
% opcje: 
% 1 - prostoliniowa
% 2 - ko³owa

switch option
    case 1
        Ax = 1;
        Ay = 1;
        
        p1 = ((Ax*Ay)/(Ax^2+Ay^2))*y + (Ax^2/(Ax^2+Ay^2))*x;
        s = (p1*(sqrt(Ax^2+Ay^2)))/Ax;
        
        x_d = (Ax/sqrt(Ax^2+Ay^2))*s;
        y_d = (Ay/sqrt(Ax^2+Ay^2))*s;
        
        dx_d = Ax/(sqrt(Ax^2+Ay^2));
        dy_d = Ay/(sqrt(Ax^2+Ay^2));
        
        ddx_d = 0;
        ddy_d = 0;
        
    case 2 % dla sciezki kolowej warunki poczatkowe x i y musza byc ró¿ne od zera!
        A = 1;
        mi = 0.1;
%         p1 = sign(x)*abs(A)/sqrt(1+(y/x)^2);
        %sign???
        p1 = abs(A)*x/sqrt(x^2 + y^2);
        p2 = abs(A)*y/sqrt(x^2 + y^2);
%             %%%%%%%%%%%%%%%%%%%%%%%%%% ATAN2 ZAMIAST ACOS
%         s = acos(p1/A)*abs(A*mi)/mi;

        s = atan2(p2,p1);

    
        x_d = A*cos((mi*s)/(abs(A*mi)));
        y_d = A*sin((mi*s)/(abs(A*mi)));

        dx_d = -sign(A*mi)*sin((mi*s)/(abs(A*mi)));
        dy_d = sign(A*mi)*cos((mi*s)/(abs(A*mi)));
        
        ddx_d = -(1/A)*cos((mi*s)/(abs(A*mi)));
        ddy_d = -(1/A)*sin((mi*s)/(abs(A*mi)));  
end 
theta_atan2 = atan2(dzeta*dy_d, dzeta*dx_d);
theta_d = Atan2c_fun(theta_atan2);

v_d = dzeta*sqrt(dx_d^2+dy_d^2);

om_d = (ddy_d*dx_d-dy_d*ddx_d)/(dx_d^2+dy_d^2);

out = [theta_d; x_d; y_d; dx_d; dy_d; ddx_d; ddy_d; om_d; v_d];

end