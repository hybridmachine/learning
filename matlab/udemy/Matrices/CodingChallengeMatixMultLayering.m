% Implement matrix multiplication by layering
% Option below suppresses warnings about output (non semicolon termination)
%#ok<*NOPTS>

% Gen two matrices
M1 = randi([0, 10],4,2);
M2 = randi([0, 10],2,4);

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

disp("Calculated answer by layers")
R 

disp("Check answer with builtin multiplication")
M1*M2

