%%
% COURSE: Linear Algebra: theory and implementation
% Secion: Matrix Spaces
% Video: Column Space Of A Matrix
%
%
%%

% matrix S
S = [3 0;
     5 2;
     1 2];
 
 % vector v
 v = [-3 1 5]';
 v = [1 7 1]';
 
 figure(1),clf
 plot3([0 S(1,1)],[0 S(2,1)], [0 S(3,1)],'k','linew',3)
 hold on
 plot3([0 S(1,2)],[0 S(2,2)], [0 S(3,2)],'k','linew',3)
 plot3([0 v(1)],[0, v(2)], [0, v(3)], 'r', 'linew', 3)
 
 h = ezmesh(@(s,t)S(1,1)*s+S(1,2)*t,@(s,t)S(2,1)*s+S(2,2)*t,@(s,t)S(3,1)*s+S(3,2)*t,[-1 1 -1 1 -1 1]);
 set (h, 'facecolor', 'g', 'cdata', ones(50),'linestyle','none')
 xlabel('C_1'),ylabel('C_2'),zlabel('C_3')
 title(' ')