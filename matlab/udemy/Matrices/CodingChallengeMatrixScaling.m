% Generate XY coordinates for circle
r = 1;
th = 0:pi/100:2*pi;
xunit = r * cos(th);
yunit = r * sin(th);
%plot(xunit, yunit);

scalingMatrix=[1 0; 0 3];
coordMatrix = [ xunit; yunit];
scaledCoords = scalingMatrix * coordMatrix;  



% plot(coordMatrix(1,:),coordMatrix(2,:))
% plot(scaledCoords(1,:),scaledCoords(2,:))

% From the lecture

x = linspace(-pi, pi, 100);
xy = [cos(x); sin(x)]';

for i = -5:.25:5
    figure(1),clf;
    hold on
    T = [i 0; i 1];

    plot(xy(:,1),xy(:,2),'bs', 'markerfacecolor', 'w');

    newxy = xy * T;
    plot(newxy(:,1),newxy(:,2),'bs', 'markerfacecolor', 'g');
    axis([-1 1 -1 1] * max(abs([newxy(:); xy(:)])));
    axis square;
    pause(0.25);
end