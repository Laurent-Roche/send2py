import numpy as np
import matplotlib.pyplot as plt



global x, y, mask, k

print(x.dtype, y.dtype, mask.dtype, type(k))
print(k)
plt.plot(x[mask], y[mask])
plt.show()