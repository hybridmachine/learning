% RREF of different sized matrices, matrices of different ranks
% - Square
% - Rectangular (tall and wide)
% - Different ranks (linear dependancies)

SM = randi(25, 5,5);
RMT = randi(25, 5,3);
RMW = randi(25, 3,5);
LRMT = RMT;
LRMT(:,3) = LRMT(:,2); % Copy column 3 to col 2
LRMW = RMW;
LRMW(3,:) = LRMW(2,:); % Copy Row 3 to Row 2)

disp('Square Matrix')
rref(SM)

disp('Rect Matrix Tall')
rref(RMT)

disp('Rect Matrix Wide')
rref(RMW)

disp('Low Rank Matrix Tall')
rref(LRMT)

disp('Low Rank Matrix Wide')
rref(LRMW)