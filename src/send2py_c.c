// Functions to call the Python interpreter.

#include "send2py_c.h"



// locals and globals in Python. Need to be global variables because otherwise
// we would need to pass them to each function call, which would require to
// interface the type in Fortran.
PyObject* locals = NULL;
PyObject* globals = NULL;



// Python launching/closing functions

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



// send_array()

// Sends the given array to Python as a global numpy array, with the given name.
int send_array_int8(int8_t x[], size_t n, char* name_py) {
    CHECK_PY_INIT();
    npy_intp dims[1] = {n};
    PyObject* npy_x = PyArray_SimpleNewFromData(1, dims, NPY_INT8, x);
    PyDict_SetItemString(globals, name_py, npy_x);
}

// Sends the given array to Python as a global numpy array, with the given name.
int send_array_int16(int16_t x[], size_t n, char* name_py) {
    CHECK_PY_INIT();
    npy_intp dims[1] = {n};
    PyObject* npy_x = PyArray_SimpleNewFromData(1, dims, NPY_INT16, x);
    PyDict_SetItemString(globals, name_py, npy_x);
}

// Sends the given array to Python as a global numpy array, with the given name.
int send_array_int32(int32_t x[], size_t n, char* name_py) {
    CHECK_PY_INIT();
    npy_intp dims[1] = {n};
    PyObject* npy_x = PyArray_SimpleNewFromData(1, dims, NPY_INT32, x);
    PyDict_SetItemString(globals, name_py, npy_x);
}

// Sends the given array to Python as a global numpy array, with the given name.
int send_array_int64(int64_t x[], size_t n, char* name_py) {
    CHECK_PY_INIT();
    npy_intp dims[1] = {n};
    PyObject* npy_x = PyArray_SimpleNewFromData(1, dims, NPY_INT64, x);
    PyDict_SetItemString(globals, name_py, npy_x);
}

// Sends the given array to Python as a global numpy array, with the given name.
int send_array_float(float x[], size_t n, char* name_py) {
    CHECK_PY_INIT();
    npy_intp dims[1] = {n};
    PyObject* npy_x = PyArray_SimpleNewFromData(1, dims, NPY_FLOAT, x);
    PyDict_SetItemString(globals, name_py, npy_x);
}

// Sends the given array to Python as a global numpy array, with the given name.
int send_array_double(double x[], size_t n, char* name_py) {
    CHECK_PY_INIT();
    npy_intp dims[1] = {n};
    PyObject* npy_x = PyArray_SimpleNewFromData(1, dims, NPY_DOUBLE, x);
    PyDict_SetItemString(globals, name_py, npy_x);
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