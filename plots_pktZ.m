% ----- wykresy dla niezerowego Lz

close all;

global Lz 

% --- przeliczenie dla pktu Z
theta_rob = q_odczyt.signals.values(:,1);
x_rob = q_odczyt.signals.values(:,2);
y_rob = q_odczyt.signals.values(:,3);

x_Z = x_rob + Lz*cos(theta_rob);
y_Z = y_rob + Lz*sin(theta_rob);

% bledy/uchyby
error_theta = q_ref_odczyt.signals.values(:,1) - q_odczyt.signals.values(:,1);
error_x = q_ref_odczyt.signals.values(:,2) - x_Z;
error_y = q_ref_odczyt.signals.values(:,3) - y_Z;
time = q_odczyt.time;


figure(1);
plot(time, error_theta, 'r');
hold on;
grid on;
plot(time, error_x, 'b');
plot(time, error_y, 'g');
xlabel('Czas [s]');
ylabel('B³êdy');
legend('B³¹d theta [rad]', 'B³¹d x (pkt Z) [m]', 'B³¹d y (pkt Z) [m]');
title('Zmiana b³êdów w czasie');

u1 = u_odczyt.signals.values(:,1);
u2 = u_odczyt.signals.values(:,2);

% sygnaly u
figure(2);
plot(u_odczyt.time, u1, 'r');
hold on;
grid on;
plot(u_odczyt.time, u2, 'b');
xlabel('Czas [s]');
ylabel('Sygna³ steruj¹cy u');
legend('u1', 'u2');
title('Sygna³y steruj¹ce u');

% q i qd
q = q_odczyt.signals.values;
q_ref = q_ref_odczyt.signals.values;

figure(3);
grid on;

subplot(3,1,1)
plot(time, q(:,1), 'r');
hold on;
grid on;
plot(time, q_ref(:,1), 'b');
xlabel('Czas [s]');
ylabel('Orientacja [rad]');
legend('theta [rad]', 'theta_{ref} [rad]');
title('Porównanie orientacji theta rzeczywistej i referencyjnej');

subplot(3,1,2)
plot(time, x_Z, 'r');
hold on;
grid on;
plot(time, q_ref(:,2), 'b');
xlabel('Czas [s]');
ylabel('Pozycja oœ x');
legend('x [m]', 'x_{ref} [m]');
title('Porównanie po³o¿enia dla punktu Z x rzeczywistego i x referencyjnego');

subplot(3,1,3)
plot(time, y_Z, 'r');
hold on;
grid on;
plot(time, q_ref(:,3), 'b');
xlabel('Czas [s]');
ylabel('Pozycja oœ y');
legend('y [m]', 'y_{ref} [m]');
title('Porównanie po³o¿enia dla punktu Z y rzeczywistego i y referencyjnego');
%-----------------------------POMET--------------------------------------|
%%%%%%--- ea pomet
% e_p_theta = e_p.signals.values(:,1);
% e_p_x = e_p.signals.values(:,2);
% e_p_y = e_p.signals.values(:,3);
% 
% figure(4)
% plot(e_p.time, e_p_theta, 'r');
% hold on;
% grid on;
% plot(time, e_p_x, 'b');
% plot(time, e_p_y, 'g');
% xlabel('Czas [s]');
% ylabel('B³êdy przekszta³cone'); 
% legend('e_{p theta} [rad]', 'e_{p x} [m]', 'e_{p y} [m]');
% title('Zmiana b³êdów przekszta³conych w czasie');
% 
% %%%%%%%--- h pomet
% h_val = h_odczyt.signals.values(:,1);
% figure(5);
% plot(time, h_val, 'b');
% grid on;
% xlabel('Czas [s]');
% ylabel('Wartoœæ funkcji h'); %%%%%%%%%%%%%% JEDN
% legend('Funkcja h');
% title('Wartoœæ funkcji h w czasie');

%-----------------------------VFO----------------------------------------|
%%%--- w vfo zmiana tylko trzech pierwszych linijek przykolejnych wykresach

% % % ----------------------- vfo ea

% % ----- vfo trajektoria
% ea_traj_val = ea_traj_odczyt.signals.values(:,1);
% figure(6);
% plot(time, ea_traj_val, 'b');

% % ---- vfo punkt
% ea_point_val = ea_point_odczyt.signals.values(:,1);
% figure(7);
% plot(time, ea_point_val, 'b');

% % ---- vfo sciezka
% ea_path_val = ea_path_odczyt.signals.values(:,1);
% figure(8);
% plot(time, ea_path_val, 'b');
% 

% grid on;
% xlabel('Czas [s]');
% ylabel('Pomocniczy b³¹d orientacji [rad]'); %%%%%%% jednostka???????????
% legend('e_a [rad]');
% title('Zmiana pomocniczego b³êdu orientacji e_a w czasie');

% % % ----------------- vfo f - uchyb do nieparam

% f_vfo_val = f_vfo_odczyt.signals.values(:,1);
% figure(9);
% plot(time,f_vfo_val, 'b');
% grid on;
% xlabel('Czas [s]');
% ylabel('Uchyb pozycji');
% legend('Uchyb pozycji');
% title('Zmiana uchybu w czasie');



%%%%% --------------------- ster lin nieparam Z ------------------------|
% 
f_lin_val = f_lin_odczyt.signals.values(:,1);
figure(10);
plot(time, f_lin_val, 'b');
grid on;
xlabel('Czas [s]');
ylabel('Uchyb pozycji');
legend('Uchyb pozycji');
title('Zmiana uchybu w czasie');



