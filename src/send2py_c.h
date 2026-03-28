#ifndef SEND2PY_C_H
#define SEND2PY_C_H



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



// Starts the Python interpreter.
int start_python();

// Ends the Python interpreter.
int end_python();

// Sends the given array to Python as a global numpy array, with the given name.
int send_array_int8(int8_t x[], size_t n, char* name_py);

// Sends the given array to Python as a global numpy array, with the given name.
int send_array_int16(int16_t x[], size_t n, char* name_py);

// Sends the given array to Python as a global numpy array, with the given name.
int send_array_int32(int32_t x[], size_t n, char* name_py);

// Sends the given array to Python as a global numpy array, with the given name.
int send_array_int64(int64_t x[], size_t n, char* name_py);

// Sends the given array to Python as a global numpy array, with the given name.
int send_array_float(float x[], size_t n, char* name_py);

// Sends the given array to Python as a global numpy array, with the given name.
int send_array_double(double x[], size_t n, char* name_py);

// Executes the given file.
int run_file(char* path);



#endif