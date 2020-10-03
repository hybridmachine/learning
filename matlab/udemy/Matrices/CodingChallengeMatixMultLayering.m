% Implement matrix multiplication by layering
% Option below suppresses warnings about output (non semicolon termination)
%#ok<*NOPTS>

% Gen two matrices
m = 4;
n = 6;
M1 = randi([0, 10],m,n);
M2 = randi([0, 10],n,m);

sizeM1 = size(M1);
sizeM2 = size(M2);

R = zeros(sizeM1(1), sizeM2(2));


for submatrix = 1:sizeM1(2)
    for layer = 1:sizeM1(1)
      for rightCol = 1:sizeM2(2)
        %msg = sprintf("left row,col %d,%d : layer,col %d,%d", layer,submatrix,submatrix,rightCol);
        %disp(msg);
        R(layer,rightCol) =  R(layer,rightCol) + (M1(layer,submatrix) * M2(submatrix,rightCol));
      end
    end
end

% Example from lesson is fewer loops:

C1 = zeros(m,m)
for i=1:n
    C1 = C1 + M1(:,i) * M2(i,:);
end

disp("Calculated answer by layers")
R 

disp("Calculated using code from lesson")
C1

disp("Check answer with builtin multiplication")
M1*M2

