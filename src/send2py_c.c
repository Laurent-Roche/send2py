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

// Sends the given int to Python as a global int, with the given name.
DEFINE_SEND_INT(send_int8, int8_t)
DEFINE_SEND_INT(send_int16, int16_t)
DEFINE_SEND_INT(send_int32, int32_t)
DEFINE_SEND_INT(send_int64, int64_t)

// Sends the given float to Python as a global float, with the given name.
DEFINE_SEND_REAL(send_float, float)
DEFINE_SEND_REAL(send_double, double)

// Sends the given bool to Python as a global bool, with the given name.
int send_bool(bool* x, char* name_py) {
    CHECK_PY_INIT();
    // Python doesn't have C-bool --> py-bool conversion: do it manually.
    PyObject* py_x = *x ? Py_True : Py_False;
    return PyDict_SetItemString(globals, name_py, py_x);
}

// Sends the given array to Python as a global numpy array, with the given name.
DEFINE_SEND_ARRAY(send_array_int8, int8_t, NPY_INT8)
DEFINE_SEND_ARRAY(send_array_int16, int16_t, NPY_INT16)
DEFINE_SEND_ARRAY(send_array_int32, int32_t, NPY_INT32)
DEFINE_SEND_ARRAY(send_array_int64, int64_t, NPY_INT64)
// DEFINE_SEND_ARRAY(send_array_uint8, uint8_t, NPY_UINT8)
// DEFINE_SEND_ARRAY(send_array_uint16, uint16_t, NPY_UINT16)
// DEFINE_SEND_ARRAY(send_array_uint32, uint32_t, NPY_UINT32)
// DEFINE_SEND_ARRAY(send_array_uint64, uint64_t, NPY_UINT64)
DEFINE_SEND_ARRAY(send_array_float, float, NPY_FLOAT)
DEFINE_SEND_ARRAY(send_array_double, double, NPY_DOUBLE)
DEFINE_SEND_ARRAY(send_array_bool, bool, NPY_BOOL)

// Executes the given file.
int run_file(char* path) {
    CHECK_PY_INIT();
    // Open the file and check if it is found.
    FILE* script = fopen(path, "r");
    CHECK_FILE_OPENED(script);
    // Run.
    return PyRun_FileExFlags(script, path, Py_file_input, globals, locals, 1,
                              NULL);
}