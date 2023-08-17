# We will now demonstrate the numerical instabilities of the determinant.
# Implement the following in code:
# 1. Create a matrix of normally distributed random numbers.
# 2. Ensure that the matrix is reduced-rank.
# 3. Compute the absolute value of the determinant (we are
# interested in whether the determinant deviates from zero;
# the sign doesn’t matter).
import numpy as np
import matplotlib.pyplot as plt

matSize = range(3,31)
log10Det = np.array(np.zeros(np.size(matSize)))
log10DetIdx = 0
for M in matSize:
    avgDet = 0
    for idx in range(100):
        A = np.random.normal(0.0, 1.0, (M,M))
        A[:,0]=A[:,1] # Reduce rank
        avgDet = avgDet + abs(np.linalg.det(A))
    avgDet = avgDet / 100
    log10Det[log10DetIdx] = np.log10(avgDet)
    log10DetIdx = log10DetIdx + 1
plt.plot(matSize, log10Det)
plt.show(block=True)
