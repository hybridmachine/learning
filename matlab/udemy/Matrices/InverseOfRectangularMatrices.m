% Calculating the left and right inverses of rectangular matrix
% rectangular matrix A is not directly invertable but
% A'A (which is square) is invertable

% inv(A'A) * (A'A) -> Identity matrix
% We can group inv(A'A) and A'
% This matrix C = inv(A'A)*A is the "left inverse" of A

% Right inverse of wide matrix mxn m<n
% A*A' * inv(A*A') -> Identity matrix
% A'*inv(A*A') is the right inverse of A
m=4;
n=7;
% 
A = randn(m,n);
AAt = A*A';
AtA = A' * A;
Ri = A' * inv(AAt);
Li = inv(AtA) * A';

figure(4),clf
subplot(331), imagesc(A), axis image, axis off
title([ 'A, r=' num2str(rank(A))])

subplot(332), imagesc(AAt), axis image, axis off
title(['AAt r=' num2str(rank(AAt))])

subplot(333), imagesc(Ri), axis image, axis off
title(['Right Inverse r=' num2str(rank(Ri))])

subplot(333), imagesc(Li), axis image, axis off
title(['Right Inverse r=' num2str(rank(Li))])

subplot(335), imagesc(A*Ri), axis image, axis off
title(['A*Ri r=' num2str(rank(A*Ri))])

subplot(336), imagesc(Ri*A), axis image, axis off
title(['Ri*A r=' num2str(rank(Ri*A))])

subplot(338), imagesc(Li*A), axis image, axis off
title(['Li*A r=' num2str(rank(Li*A))])

subplot(339), imagesc(A*Li), axis image, axis off
title(['A*Li r=' num2str(rank(A*Li))])



m=7;
n=4;
% 
A = randn(m,n);
AAt = A*A';
AtA = A' * A;
Ri = A' * inv(AAt);
Li = inv(AtA) * A';

figure(5),clf
subplot(331), imagesc(A), axis image, axis off
title([ 'A, r=' num2str(rank(A))])

subplot(332), imagesc(AAt), axis image, axis off
title(['AAt r=' num2str(rank(AAt))])

subplot(333), imagesc(Ri), axis image, axis off
title(['Right Inverse r=' num2str(rank(Ri))])

subplot(333), imagesc(Li), axis image, axis off
title(['Right Inverse r=' num2str(rank(Li))])

subplot(335), imagesc(A*Ri), axis image, axis off
title(['A*Ri r=' num2str(rank(A*Ri))])

subplot(336), imagesc(Ri*A), axis image, axis off
title(['Ri*A r=' num2str(rank(Ri*A))])

subplot(338), imagesc(Li*A), axis image, axis off
title(['Li*A r=' num2str(rank(Li*A))])

subplot(339), imagesc(A*Li), axis image, axis off
title(['A*Li r=' num2str(rank(A*Li))])
