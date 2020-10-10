% Generate XY coordinates for circle
th = 0:pi/100:2*pi;
xunit = r * cos(th);
yunit = r * sin(th);
%plot(xunit, yunit);

scalingMatrix=[1 0; 0 3];
coordMatrix = [ xunit; yunit];
scaledCoords = scalingMatrix * coordMatrix;  

figure(1),clf;
hold on
plot(coordMatrix(1,:),coordMatrix(2,:))
plot(scaledCoords(1,:),scaledCoords(2,:))