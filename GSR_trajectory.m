function out = GSR_trajectory(in)
% gsr - œledzenie trajektorii

% wejscia
t = in(1); % parametr czas
option = in(2); % wybrana opcja (jaka figura)

% zmienne
dzeta = 1;  % ruch przodem
% dzeta = -1; % ruch ty³em

X_d = 0; % wspolrzedne srodka krzywej wzgledem poczatku ukladu wspolrzednych
Y_d = 0;

% opcje

% % wybrana opcja 1 : trajektoria prostoliniowa
% % wybrana opcja 2 : trajektoria ko³owa
% % wybrana opcja 3 : trajektoria eliptyczna
% % wybrana opcja 4 : trajektoria ósemkowa

switch option
    case 1
        a = 1; 
        b = 2; 
        kx = -2;
        ky = -2;
        
    case 2
        A_dx = 1;
        A_dy = 1;
        om_dx = 1;
        om_dy = 1;
        psi_dx = 0;
        psi_dy = 0;       
    case 3
        A_dx = 2;
        A_dy = 1;
        om_dx = 1;
        om_dy = 1;
        psi_dx = 0;
        psi_dy = 0;
    case 4
        A_dx = 0.6;
        A_dy = 0.6;
        om_dx = 0.4;
        om_dy = 0.2;
        psi_dx = -pi/2;
        psi_dy = 0;
        
%         A_dx = 2;
%         A_dy = 2;
%         om_dx = 1;
%         om_dy = 0.5;
%         psi_dx = -pi/2;
%         psi_dy = 0;
    otherwise
        A_dx = 0;
        A_dy = 0;
        om_dx = 0;
        om_dy = 0;
        psi_dx = 0;
        psi_dy = 0;
        

end

% wyjscia
% wyjscia plaskie dla kin 2,0 - x i y
if option == 2 || option==3 || option == 4
    x_d = X_d + A_dx*cos(om_dx*t+psi_dx); 
    y_d = Y_d + A_dy*sin(om_dy*t+psi_dy);

    dx_d = -A_dx*om_dx*sin(om_dx*t+psi_dx);  % pierwsza pochodna po x  
    dy_d = A_dy*om_dy*cos(om_dy*t+psi_dy);

    ddx_d = -A_dx*om_dx^2*cos(om_dx*t+psi_dx);
    ddy_d = -A_dy*om_dy^2*sin(om_dy*t+psi_dy);

    theta_atan2 = atan2(dzeta*dy_d, dzeta*dx_d);
    theta_d = Atan2c_fun(theta_atan2);

    v_d = dzeta*sqrt(dx_d^2+dy_d^2);

    om_d = (ddy_d*dx_d-dy_d*ddx_d)/(dx_d^2+dy_d^2);

elseif option == 1 
    x_d = t+kx; 
    y_d = a*x_d+b+ky;
    dx_d = 1;
    dy_d = a;
    ddx_d = 0;
    ddy_d = 0;
    theta_atan2 = atan2(dzeta*dy_d, dzeta*dx_d);
    theta_d = Atan2c_fun(theta_atan2);

    v_d = dzeta*sqrt(dx_d^2+dy_d^2);

    om_d = (ddy_d*dx_d-dy_d*ddx_d)/(dx_d^2+dy_d^2);
else 
    disp('Nieprawidlowa wartosc gsr trajektoria');
end

out = [theta_d; x_d; y_d; dx_d; dy_d; ddx_d; ddy_d; om_d; v_d];

end