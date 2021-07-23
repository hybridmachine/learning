import numpy as np

M1 = 10*np.random.randn(4,3)
M2 = 10*np.random.randn(3,5)

C = M1 @ M2

print(C)