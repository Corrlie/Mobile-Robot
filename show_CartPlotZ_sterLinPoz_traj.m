% -------- sterownik linPoz, dla trajektorii, kre�l Z

global Lz

x0_odczyt = q_odczyt.signals.values(:,2);
y0_odczyt = q_odczyt.signals.values(:,3);
teta0_odczyt = q_odczyt.signals.values(:,1);

x0_ref_odczyt = q_ref_odczyt.signals.values(:,2);
y0_ref_odczyt = q_ref_odczyt.signals.values(:,3);
teta0_ref_odczyt = q_ref_odczyt.signals.values(:,1);


pkt_Z_x_odczyt = x0_odczyt+Lz*cos(teta0_odczyt);
pkt_Z_y_odczyt = y0_odczyt+Lz*sin(teta0_odczyt);


len = length(x0_odczyt);
bounds = [-2 2 -2 2]; % granice osi wykresow
% bounds = [-2 8 -2 8]; % granice osi wykresow % prostolin
for i = 1:len
    teta0 = q_odczyt.signals.values(i,1);
    x0 = q_odczyt.signals.values(i,2);
    y0 = q_odczyt.signals.values(i,3);
    we = [x0; y0; teta0];
    CartPlotZ(we);
    plot(x0_odczyt(1:i), y0_odczyt(1:i), 'k--')
    
    xlabel('x^G [m]');
    ylabel('y^G [m]');
    
    
    %----- kreslenie pktu Z
   
    plot(pkt_Z_x_odczyt(1:i), pkt_Z_y_odczyt(1:i), 'r:');
    
    
    %----- koniec kreslenia pktu Z
    
    
    %%% tu start ref
    hold on;
    teta_ref = q_ref_odczyt.signals.values(i,1);
    x_ref = q_ref_odczyt.signals.values(i,2);
    y_ref = q_ref_odczyt.signals.values(i,3);
    plot(x0_ref_odczyt(1:i), y0_ref_odczyt(1:i), 'g');
    %%% koniec ref
    
    axis(bounds);
    grid on; 
        
    hold off;
    pause(0.01);
end


plot(q_odczyt.signals.values(:,2), q_odczyt.signals.values(:,3), 'k--'); % x, y tor przerywana
hold on;
plot(q_ref_odczyt.signals.values(:,2), q_ref_odczyt.signals.values(:,3), 'g');
plot(pkt_Z_x_odczyt, pkt_Z_y_odczyt, 'r:');
% plot(x0_ref_odczyt,y0_ref_odczyt, 'g'); % sciezka
grid on;
xlabel('x^G [m]');
ylabel('y^G [m]');
axis(bounds);
CartPlotZ([q_odczyt.signals.values(1,2);q_odczyt.signals.values(1,3); q_odczyt.signals.values(1,1)]); % poz pocz, funkcja -  wczyt x, y theta
half = round(len/2); % round zeby byla liczba calk
CartPlotZ([q_odczyt.signals.values(half,2);q_odczyt.signals.values(half,3); q_odczyt.signals.values(half,1)]); % poz srod x,y,theta
CartPlotZ([q_odczyt.signals.values(len,2);q_odczyt.signals.values(len,3); q_odczyt.signals.values(len,1)]); % poz konc
