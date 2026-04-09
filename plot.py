import numpy as np
import matplotlib.pyplot as plt



global x, y, color, show_grid, title

plt.plot(x, y, color=color)
plt.grid(show_grid)
plt.title(title)
plt.show()