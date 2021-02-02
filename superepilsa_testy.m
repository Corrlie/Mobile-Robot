theta = 0:0.001:pi/2;
a = 1;
b = 1;
n = 4;
x1 = a*(cos(theta)).^(2/n);
y1 = b*(sin(theta)).^(2/n);

x2 = -a*(cos(theta)).^(2/n);
y2 = b*(sin(theta)).^(2/n);

x3 = a*(cos(theta)).^(2/n);
y3 = -b*(sin(theta)).^(2/n);

x4 = -a*(cos(theta)).^(2/n);
y4 = -b*(sin(theta)).^(2/n);

plot(x1,y1); hold on;
plot(x2,y2);
plot(x3,y3);
plot(x4,y4);