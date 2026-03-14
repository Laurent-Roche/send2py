# send2py
Example of calling Python code from Fortran. Fortran defines two arrays, which are plotted using matplotlib in Python, without doing a copy.

This uses Python and NumPy's C-APIs and Fortran's C-binding abilities to be able to pass variables from Fortran to C, and then from C to Python, all without using copies. This is especially useful to pass large arrays from Fortran to NumPy.

# Build

This is a fpm package, which can be built using standard fpm commands. You will however probably need to tell fpm where to find Python and NumPy headers. Both provide a way to get the required compiler / linker flags, through python3-config and numpy-config. The following should work (on Linux) to build and run the program:

```bash
fpm run --c-flag "$(python3-config --cflags) $(numpy-config --cflags)" --link-flag "$(python3-config --ldflags)"
```
