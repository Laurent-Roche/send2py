module send2py
    use iso_c_binding
    implicit none
  
    private
    public :: start_python, end_python, send_array, run_file
    
    ! C wrappers
    interface
        function start_python_c() bind(c, name="start_python") result(error)
            use iso_c_binding, only: c_int
            integer(c_int) :: error
        end function start_python_c
    end interface
    
    interface
        function end_python_c() bind(c, name="end_python") result(error)
            use iso_c_binding, only: c_int
            integer(c_int) :: error
        end function end_python_c
    end interface
    
    interface
        function run_file_c(path) bind(c, name="run_file") result(error)
            use iso_c_binding, only: c_char, c_int
            character(c_char), intent(in) :: path(*)
            integer(c_int) :: error
        end function run_file_c
    end interface
    
    interface
        function send_array_int8(arr, n, name_py) &
                                bind(c, name="send_array_int8") result(error)
            use iso_c_binding, only: c_char, c_int8_t, c_size_t, c_int
            integer(c_int8_t), intent(in) :: arr(n)
            integer(c_size_t), intent(in), value :: n
            character(c_char), intent(in) :: name_py(*)
            integer(c_int) :: error
        end function send_array_int8
    end interface
    
    interface
        function send_array_int16(arr, n, name_py) &
                                bind(c, name="send_array_int16") result(error)
            use iso_c_binding, only: c_char, c_int16_t, c_size_t, c_int
            integer(c_int16_t), intent(in) :: arr(n)
            integer(c_size_t), intent(in), value :: n
            character(c_char), intent(in) :: name_py(*)
            integer(c_int) :: error
        end function send_array_int16
    end interface
    
    interface
        function send_array_int32(arr, n, name_py) &
                                bind(c, name="send_array_int32") result(error)
            use iso_c_binding, only: c_char, c_int32_t, c_size_t, c_int
            integer(c_int32_t), intent(in) :: arr(n)
            integer(c_size_t), intent(in), value :: n
            character(c_char), intent(in) :: name_py(*)
            integer(c_int) :: error
        end function send_array_int32
    end interface
    
    interface
        function send_array_int64(arr, n, name_py) &
                                bind(c, name="send_array_int64") result(error)
            use iso_c_binding, only: c_char, c_int64_t, c_size_t, c_int
            integer(c_int64_t), intent(in) :: arr(n)
            integer(c_size_t), intent(in), value :: n
            character(c_char), intent(in) :: name_py(*)
            integer(c_int) :: error
        end function send_array_int64
    end interface
    
    interface
        function send_array_float(arr, n, name_py) &
                                bind(c, name="send_array_float") result(error)
            use iso_c_binding, only: c_char, c_float, c_size_t, c_int
            real(c_float), intent(in) :: arr(n)
            integer(c_size_t), intent(in), value :: n
            character(c_char), intent(in) :: name_py(*)
            integer(c_int) :: error
        end function send_array_float
    end interface
    
    interface        
        function send_array_double(arr, n, name_py) &
                                bind(c, name="send_array_double") result(error)
            use iso_c_binding, only: c_char, c_double, c_size_t, c_int
            real(c_double), intent(in) :: arr(n)
            integer(c_size_t), intent(in), value :: n
            character(c_char), intent(in) :: name_py(*)
            integer(c_int) :: error
        end function send_array_double
    end interface
    
    interface send_array
        procedure :: send_array_float_f, send_array_double_f
        procedure :: send_array_int8_f, send_array_int16_f, send_array_int32_f
        procedure :: send_array_int64_f
    end interface
    
contains

    ! Helpers

    ! Terminates the program if the error code is non null.
    subroutine check_error(error)
        integer(c_int), intent(in) :: error
        if (error /= 0) then
            print '(a)', "Python API error: terminating program"
            stop error
        end if
    end subroutine check_error

    ! Adds c_null_char at the end.
    pure function append_end_of_string(string) result(output)
        character(len=*, kind=c_char), intent(in) :: string
        character(len=len(string)+1, kind=c_char) :: output
        
        output = string // c_null_char
    end function append_end_of_string
    
    
    ! Fortran wrappers to check Python errors and add c_null_char.
    
    subroutine start_python()
        integer(c_int) :: error
        error = start_python_c()
        call check_error(error)
    end subroutine start_python
    
    subroutine end_python()
        integer(kind=c_int) :: error
        error = end_python_c()
        call check_error(error)
    end subroutine end_python
    
    subroutine run_file(path)
        character(len=*, kind=c_char), intent(in) :: path
        
        integer(c_int) :: error
        
        error = run_file_c(append_end_of_string(path))
        call check_error(error)
    end subroutine run_file


    ! send_array_xxx() wrappers to add array size in call and c_null_char.

    subroutine send_array_int8_f(arr, name_py)
        integer(c_int8_t), intent(in) :: arr(:)
        character(len=*, kind=c_char), intent(in) :: name_py
        
        integer(c_size_t) :: n
        integer(c_int) :: error

        n = size(arr)
        error = send_array_int8(arr, n, append_end_of_string(name_py))
        call check_error(error)
    end subroutine send_array_int8_f

    subroutine send_array_int16_f(arr, name_py)
        integer(c_int16_t), intent(in) :: arr(:)
        character(len=*, kind=c_char), intent(in) :: name_py
        
        integer(c_size_t) :: n
        integer(c_int) :: error

        n = size(arr)
        error = send_array_int16(arr, n, append_end_of_string(name_py))
        call check_error(error)
    end subroutine send_array_int16_f

    subroutine send_array_int32_f(arr, name_py)
        integer(c_int32_t), intent(in) :: arr(:)
        character(len=*, kind=c_char), intent(in) :: name_py
        
        integer(c_size_t) :: n
        integer(c_int) :: error

        n = size(arr)
        error = send_array_int32(arr, n, append_end_of_string(name_py))
        call check_error(error)
    end subroutine send_array_int32_f

    subroutine send_array_int64_f(arr, name_py)
        integer(c_int64_t), intent(in) :: arr(:)
        character(len=*, kind=c_char), intent(in) :: name_py
        
        integer(c_size_t) :: n
        integer(c_int) :: error

        n = size(arr)
        error = send_array_int64(arr, n, append_end_of_string(name_py))
        call check_error(error)
    end subroutine send_array_int64_f

    subroutine send_array_float_f(arr, name_py)
        real(c_float), intent(in) :: arr(:)
        character(len=*, kind=c_char), intent(in) :: name_py
        
        integer(c_size_t) :: n
        integer(c_int) :: error

        n = size(arr)
        error = send_array_float(arr, n, append_end_of_string(name_py))
        call check_error(error)
    end subroutine send_array_float_f
    
    subroutine send_array_double_f(arr, name_py)
        real(c_double), intent(in) :: arr(:)
        character(len=*, kind=c_char), intent(in) :: name_py
        
        integer(c_size_t) :: n
        integer(c_int) :: error

        n = size(arr)
        error = send_array_double(arr, n, append_end_of_string(name_py))
        call check_error(error)
    end subroutine send_array_double_f
    
end module send2py
