% Vector W to be decomposed with respect to Vector V below
w = [2 3];

% vector v, the reference vector
v = [4 -1];

% FIrst find the relative component parallel to vector v
% THis is the projection of w on to v which is
% w'v/(v'v) * v

w_parallel_v = dot(w,v)/dot(v,v) * v;

w_perp_v = w - w_parallel_v;

figure(1);
clf;
hold on;
plot([0, w(1)],[0,w(2)]);
plot([0,v(1)],[0,v(2)]);
plot([0,w_parallel_v(1)],[0,w_parallel_v(2)],'--or');
plot([0,w_perp_v(1)],[0,w_perp_v(2)],'--+b');
axis([-2,5,-2,5]);
axis square, grid on;