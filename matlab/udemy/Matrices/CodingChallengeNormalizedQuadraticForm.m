% Generate the quadratic form and normalized quadratic form for
A = [ 6 0; 0 0 ];
n=30;
wRange = linspace(-5,5,n);
qf = zeros(n);
qfN = zeros(n);

for i=1:n
    for j=1:n
        w = [ wRange(i) wRange(j) ]';
        qf(i,j) = w' * A * w;
        qfN(i,j) = (w' * A * w)/(w' * w);
    end
end

colormap jet

% show the surface
subplot(1,2,1)
surf(wRange,wRange,qf')
% make it look a bit nicer
shading interp, axis square
set(gca,'fontsize',12,'clim',[-1 1]*max(abs(qf(:)))*.6)
xlabel('w_1'), ylabel('w_2'), zlabel('Quad.form energy')
% show the surface
subplot(1,2,2)
surf(wRange,wRange,qfN')
% make it look a bit nicer
shading interp, axis square
set(gca,'fontsize',12,'clim',[-1 1]*max(abs(qfN(:)))*.6)
xlabel('w_1'), ylabel('w_2'), zlabel('Quad.form normalized')

rotate3d on