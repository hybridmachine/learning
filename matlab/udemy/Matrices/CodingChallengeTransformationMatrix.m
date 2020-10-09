% Explore the transformation matrix

%2D input vector
v = [ 3 -2 ];

theta = pi/30;

while(1)
    theta = theta + (2*pi)/(360/5);
    A = [2*cos(theta) -2*sin(theta); 
     sin(theta) cos(theta) ];
 
     w = A*v';

     figure(2),clf;

     plot([0 v(1)],[0 v(2)], 'k', 'linew', 2)
     hold on;
     plot([0 w(1)],[0 w(2)], 'r', 'linew', 3)
     axis([-8 8 -8 8]);
 
    th = 0:pi/50:2*pi;
    r = norm(w);
    xunit = r * cos(th);
    yunit = r * sin(th);
    plot(xunit, yunit);
	pause(0.05);
end
