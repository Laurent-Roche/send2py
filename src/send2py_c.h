#ifndef SEND2PY_C_H
#define SEND2PY_C_H



#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>

#include <Python.h>
#include <numpy/arrayobject.h>



// Error handling with exit codes because Fortran

#define ERR_PYTHON_NOT_INIT 1
#define CHECK_PY_INIT() {                             \
    if (!Py_IsInitialized()) {                        \
        printf("Error: Python is not initialized\n"); \
        return ERR_PYTHON_NOT_INIT;                   \
    }                                                 \
}

#define ERR_FILE_NOT_FOUND 2
#define CHECK_FILE_OPENED(f) {                      \
    if (!f) {                                       \
        printf("Error: file %s not found\n", path); \
        return ERR_FILE_NOT_FOUND;                  \
    }                                               \
}

// Macro to define send_array_xxx() with each type.
#define DEFINE_SEND_ARRAY(NAME, C_TYPE, NPY_TYPE)                       \
int NAME(C_TYPE x[], size_t n, char* name_py) {                         \
    CHECK_PY_INIT();                                                    \
    npy_intp dims[1] = {n};                                             \
    PyObject* npy_x = PyArray_SimpleNewFromData(1, dims, NPY_TYPE, x);  \
    return PyDict_SetItemString(globals, name_py, npy_x);               \
}



// Starts the Python interpreter.
int start_python();

// Ends the Python interpreter.
int end_python();

// Sends the given array to Python as a global numpy array, with the given name.
int send_array_int8(int8_t x[], size_t n, char* name_py);
int send_array_int16(int16_t x[], size_t n, char* name_py);
int send_array_int32(int32_t x[], size_t n, char* name_py);
int send_array_int64(int64_t x[], size_t n, char* name_py);
// int send_array_uint8(uint8_t x[], size_t n, char* name_py);
// int send_array_uint16(uint16_t x[], size_t n, char* name_py);
// int send_array_uint32(uint32_t x[], size_t n, char* name_py);
// int send_array_uint64(uint64_t x[], size_t n, char* name_py);
int send_array_float(float x[], size_t n, char* name_py);
int send_array_double(double x[], size_t n, char* name_py);
int send_array_bool(bool x[], size_t n, char* name_py);

// Executes the given file.
int run_file(char* path);



#endif