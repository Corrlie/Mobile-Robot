function out = GSR_path_noparam_Zpoint(in)

global dzeta Lz xr yr

dzeta = 1; 
% dzeta = -1; 
% sigma = -1;
sigma = 1;

% dzeta : - ruch tylem; + ruch przodem
% sigma : - zgodnie/ + przeciwny do ruchu zegara


theta = in(1);
x = in(2);
y = in(3);
option = in(4);
% % opcje:
% % 1 - prostoliniowa
% % 2 - ko³owa
% % 3 - superelipsa

x = x+Lz*cos(theta);
y  = y+Lz*sin(theta);

switch option
    case 1
        a = -1;
        b = 0;
        f = sigma*(y-a*x-b);
        f_x = -sigma*a;
        f_y = sigma;
        f_xx = 0;
        f_yy = 0;
        f_xy = 0;
        
        A=0;
        for j = -10:0.1:10
            A=A+1;
        	xr(A)=j;
            yr(A)=a*j+b;
        end
        
    case 2
        a = 1;
        b = 1;
        f = sigma*((x/a)^2+(y/b)^2-1);
        f_x = (2*sigma*x)/a^2;
        f_y = (2*sigma*y)/b^2;
        f_xx = (2*sigma)/a^2;
        f_yy = (2*sigma)/b^2;
        f_xy = 0;
        
        A=0;
        for j = 0:0.1:10
            A=A+1;
        	xr(A)=a*cos(j);
            yr(A)=b*sin(j);
        end        
        
    case 3
        a = 1;
        b= 0.5;
        n = 4;
        
        f = sigma*((x/a)^n+(y/b)^n-1);
        
        f_x = (n*sigma*(x/a)^(n - 1))/a;
        f_y = (n*sigma*(y/b)^(n - 1))/b;
        f_xx = (n*sigma*(x/a)^(n - 2)*(n - 1))/a^2;
        f_yy = (n*sigma*(y/b)^(n - 2)*(n - 1))/b^2;
        f_xy = 0;
        
        A=0;
        for j = 0:0.1:10
            A=A+1;
        	xr(A)=abs(cos(j))^(2/n)*a*sgn_fun(cos(j));
            yr(A)=abs(sin(j))^(2/n)*b*sgn_fun(sin(j));
        end        
        
end

out = [f; f_x; f_y; f_xx; f_yy; f_xy];


end