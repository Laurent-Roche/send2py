import numpy as np
import matplotlib.pyplot as plt



global x, y, mask

print(x.dtype, y.dtype, mask.dtype)
plt.plot(x[mask], y[mask])
plt.show()