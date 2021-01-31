% Implementation of the Gram-Schmidt 
% Start with a square matrix
% Check that Q'Q == Identity Matrix
% Compare against built in function qr()

% Gram Schmidt is to columns perpendicular to each other , start with left
% most column as base (by convention)

% Take left most column then decompose next column against it, find the
% perpendicular component. Then decompose the next column against the
% decomposed column, find perpendicular component and then take that and
% find perpendicular component from first column and subtract it.

m = 4;
n = 4;
M1 = randi(100,m,n);
MO = zeros(m,n);
% Find orthoginal is
% 1) dot(v1,ref)/dot(ref,ref) * ref == parallel_component
% 2) v1 - parallel_component


MO(:,1) = M1(:,1); % first column of orth matrix is the starting matrix

for ColIdx = 2:n
    OrthIdx = ColIdx;
    ColVec = M1(:,ColIdx);
    MO(:,ColIdx) = ColVec;
    while OrthIdx > 1 
        RefVec = MO(:,(OrthIdx - 1));
        ParallelComponent = (dot(ColVec,RefVec)/dot(RefVec,RefVec)) * RefVec;
        MO(:,ColIdx) = MO(:,ColIdx) - ParallelComponent;
        OrthIdx = OrthIdx - 1;
    end
end

% Q is the orthoginal unit matrix
for ColIdx = 1:n
    UnitCol = MO(:,ColIdx);
    % MO(:,ColIdx) = UnitCol / sqrt(dot(UnitCol,UnitCol));
    
    MO(:,ColIdx) = UnitCol / norm(UnitCol);
end

figure(1)
imagesc(M1);

figure(2)
imagesc((MO' * MO));
