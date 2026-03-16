// Functions to call the Python interpreter.

#include "send2py_c.h"



// locals and globals in Python. Need to be global variables because otherwise
// we would need to pass them to each function call, which would require to
// interface the type in Fortran.
PyObject* locals = NULL;
PyObject* globals = NULL;



// Starts the Python interpreter.
int start_python() {
    Py_Initialize();
    import_array();
    locals = PyDict_New();
    globals = PyDict_New();
    return 0;
}

// Ends the Python interpreter.
int end_python() {
    CHECK_PY_INIT();
    PyErr_Print();
    Py_Finalize();
    return 0;
}

// Sends the given double array to Python as a global numpy array, with the
// given name.
int send_to_python(double x[], size_t n, char* name_py) {
    CHECK_PY_INIT();
    npy_intp dims[1] = {n};
    PyObject* npy_x = PyArray_SimpleNewFromData(1, dims, NPY_DOUBLE, x);
    PyDict_SetItemString(locals, name_py, npy_x);
}

// Executes the given file.
int run_file(char* path) {
    CHECK_PY_INIT();
    // Open the file and check if it is found.
    FILE* script = fopen(path, "r");
    CHECK_FILE_OPENED(script);
    // Run.
    PyRun_FileExFlags(script, path, Py_file_input, globals, locals, 1, NULL);
}