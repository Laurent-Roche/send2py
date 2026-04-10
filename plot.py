import numpy as np
import matplotlib.pyplot as plt



global x, y, arr, color, show_grid, title

print(arr.shape, arr.dtype, arr.strides)
print(arr.flags)
arr[0, 1] = -7
print(arr)
plt.plot(x, y, color=color)
plt.grid(show_grid)
plt.title(title)
plt.show()