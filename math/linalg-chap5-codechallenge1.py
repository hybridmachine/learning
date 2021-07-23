import numpy as np

M1 = np.random.randn(4,2)
M2 = np.random.randn(4,2)

C = np.zeros((2,2))
C2 = np.zeros((2,2))

i_idx = 0
j_idx = 0

for i_idx in range(2):
    for j_idx in range(2):
        C[i_idx,j_idx] = M1[:,i_idx].dot(M2[:,j_idx])
        C2[i_idx, j_idx] = np.dot(M1[:,i_idx],M2[:,j_idx])

print(M1)
print(M2)
print(C)
print(C2)