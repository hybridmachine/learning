% For random 3x3 matrices show that DET(AB) = DET(A) * DET(B)
% For random matrices up to 40x40 do the same in a loop

M1 = randn(3,3);
M2 = randn(3,3);
zeroThreshold = 1.0e-5;

equalTest = abs(det(M1 * M2) - (det(M1) * det(M2)));

if (equalTest < zeroThreshold) 
    disp("They are equal")
else
    disp("They are not equal")
end

k = 40;
dets = zeros(k,2);

for idx = 1:k
    matSz = k;
    
    M3 = randn(matSz, matSz);
    M4 = randn(matSz, matSz);

    dets(idx,:) = [det(M3 * M4), (det(M3) * det(M4))];
%     equalTest = abs(det(M3 * M4) - (det(M3) * det(M4)));
%     
%     if (equalTest < zeroThreshold) 
%         fprintf("Size %d, %g They are equal\n", matSz, equalTest);
%     else
%         fprintf("Size %d, %g They are NOT equal\n", matSz, equalTest);
%     end
    
end

plot(dets(:,1) - dets(:,2),'s-');
