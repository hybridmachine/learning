% Explore the transformation matrix

%2D input vector
v = [ 3 -2 ];

thetas = linspace(1,2 * pi, 100);
theta = pi/30;
impureLen = zeros(length(thetas));

for idx = 1:length(thetas)
    theta = thetas(idx);
    A = [2*cos(theta) sin(theta); 
     sin(theta) cos(theta) ];
 
     w = A*v';

     figure(2),clf;

     plot([0 v(1)],[0 v(2)], 'k', 'linew', 2)
     hold on;
     plot([0 w(1)],[0 w(2)], 'r', 'linew', 3)
     axis([-8 8 -8 8]);
 
    th = 0:pi/50:2*pi;
    r = norm(w);
    impureLen(idx) = r;
    xunit = r * cos(th);
    yunit = r * sin(th);
    plot(xunit, yunit);
	pause(0.05);
end

figure(3),clf;
plot((impureLen/norm(v)));
