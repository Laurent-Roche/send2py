// Functions to call the Python interpreter.

#include <stdio.h>

#include <Python.h>
#include <numpy/arrayobject.h>



// Calls the Python interpreter with the passed Fortran variables.
void plt_plot(char* path, double x[], double y[], int n) {
    printf("C       %p %p\n", x, y);
    // Initialize the interpreter.
    Py_Initialize();
    import_array();
    PyObject* locals = PyDict_New();
    PyObject* globals = PyDict_New();
    // Create the variables.
    npy_intp dims[1] = {n};
    PyObject* npy_x = PyArray_SimpleNewFromData(1, dims, NPY_DOUBLE, x);
    PyObject* npy_y = PyArray_SimpleNewFromData(1, dims, NPY_DOUBLE, y);
    PyDict_SetItemString(locals, "x", npy_x);
    PyDict_SetItemString(locals, "y", npy_y);
    // Open the file and check if it is found.
    FILE* script = fopen(path, "r");
    if (!script) {
        printf("Error: file %s not found\n", path);
        PyErr_Print();
        Py_Finalize();
        return;
    }
    // Run and exit.
    PyRun_FileExFlags(script, path, Py_file_input, globals, locals, 1, NULL);
    PyErr_Print();
    Py_Finalize();
}