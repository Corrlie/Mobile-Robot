x0_odczyt = q_odczyt.signals.values(:,2);
len = length(x0_odczyt);
bounds = [-1 30 -1 1]; % granice osi wykresow
for i = 1:len
    teta0 = q_odczyt.signals.values(i,1);
    x0 = q_odczyt.signals.values(i,2);
    y0 = q_odczyt.signals.values(i,3);
    we = [x0; y0; teta0];
    CartPlotZ(we);
    axis(bounds);
    grid on; 
    hold off;
    pause(0.01);
end

plot(q_odczyt.signals.values(:,2), q_odczyt.signals.values(:,3), 'k--'); % x, y tor przerywana
hold on;
grid on;
axis(bounds);
CartPlotZ([q_odczyt.signals.values(1,2);q_odczyt.signals.values(1,3); q_odczyt.signals.values(1,1)]); % poz pocz, funkcja -  wczyt x, y theta
half = round(len/2); % round zeby byla liczba calk
CartPlotZ([q_odczyt.signals.values(half,2);q_odczyt.signals.values(half,3); q_odczyt.signals.values(half,1)]); % poz srod x,y,theta
CartPlotZ([q_odczyt.signals.values(len,2);q_odczyt.signals.values(len,3); q_odczyt.signals.values(len,1)]); % poz konc