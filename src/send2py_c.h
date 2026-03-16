#ifndef SEND2PY_C_H
#define SEND2PY_C_H



#include <stdio.h>

#include <Python.h>
#include <numpy/arrayobject.h>



// Error handling with exit codes because Fortran

#define ERR_PYTHON_NOT_INIT 1
#define CHECK_PY_INIT() {                             \
    if (!Py_IsInitialized()) {                        \
        printf("Error: Python is not initialized\n"); \
        return ERR_PYTHON_NOT_INIT;                       \
    }                                                 \
}

#define ERR_FILE_NOT_FOUND 2
#define CHECK_FILE_OPENED(f) {                      \
    if (!f) {                                       \
        printf("Error: file %s not found\n", path); \
        return ERR_FILE_NOT_FOUND;                  \
    }                                               \
}



#endif