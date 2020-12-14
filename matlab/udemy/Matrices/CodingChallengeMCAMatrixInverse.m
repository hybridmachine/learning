% Implementation of the MCA algorithm for finding the matrix inverse

mSz = 5;
M1 = randn(mSz); % Generate a 5x5 random matrix

% For testing, a matrix from the lesson, which I know the answer to
% mSz = 3;
% M1 = [ 1, 3, 0; 0, -2, 8; 7, 2, -6 ];

detM1 = det(M1);
MinorsMatrix = zeros(mSz);
CofactorsSignMatrix = zeros(mSz);
positionSign = 1; % top left is always positive sign 

if abs(detM1) > 0
    % Find the Minors Matrix
    
    for M1Row = 1:mSz
        for M1Col = 1:mSz
            % Load up the CofactorsSignMatrix as we scan the source matrix
            CofactorsSignMatrix(M1Row, M1Col) = positionSign;
            positionSign = positionSign * -1; % Flip the sign for the next position
            
            MinorsComponentMatrix = M1;
            % Now remove the row and column from the component matrix
            MinorsComponentMatrix(M1Row,:) = [];
            MinorsComponentMatrix(:,M1Col) = [];
            
            % Calculate the determinant of the component matrix
            mcmDet = det(MinorsComponentMatrix);
            
            % Store the determinant in the row,col location of the
            % MinorsMatrix
            MinorsMatrix(M1Row, M1Col) = mcmDet;
            
        end
    end
    % Find the Cofactors Matrix
    % Cofactors matrix = Minors Matrix .* CofactorsSignMatrix (Hadamard
    % multiplication)
    CofactorsMatrix = MinorsMatrix .* CofactorsSignMatrix;
    
    
    % Find the Adjugate Matrix (this is the inverse)
    AdjugateMatrix = (CofactorsMatrix') / detM1;
end

disp("Matrix")
disp(M1)

disp("It's inverse")
disp(AdjugateMatrix)

disp("Matirx * its inverse")
disp(M1*AdjugateMatrix)

