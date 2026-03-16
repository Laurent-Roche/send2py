module send2py
    use iso_c_binding, only: c_char, c_double, c_int, c_null_char
    implicit none
  
    private
    public :: start_python, end_python, send_to_python, run_file
    
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
        function send_to_python_c(arr, n, name_py) bind(c, name="send_to_python") result(error)
            use iso_c_binding, only: c_char, c_double, c_int
            real(kind=c_double) :: arr(*)
            integer(kind=c_int), value :: n
            character(kind=c_char) :: name_py(*)
            integer(c_int) :: error
        end function send_to_python_c
    end interface
    
    interface
        function run_file_c(path) bind(c, name="run_file") result(error)
            use iso_c_binding, only: c_char, c_int
            character(kind=c_char) :: path(*)
            integer(c_int) :: error
        end function run_file_c
    end interface
    
contains

    ! Terminates the program if the error code is non null.
    subroutine check_error(error)
        integer(c_int), intent(in) :: error
        if (error /= 0) then
            print '(a)', "Python API error: terminating program"
            stop error
        end if
    end subroutine check_error

    ! Adds c_null_char at the end .
    pure function append_end_of_string(string) result(output)
        character(len=*, kind=c_char), intent(in) :: string
        character(len=len(string)+1, kind=c_char) :: output
        
        output = string // c_null_char
    end function append_end_of_string
    
    
    
    subroutine start_python()
        integer(kind=c_int) :: error
        error = start_python_c()
        call check_error(error)
    end subroutine start_python
    
    subroutine end_python()
        integer(kind=c_int) :: error
        error = end_python_c()
        call check_error(error)
    end subroutine end_python

    ! Wrapper to add c_null_char at the end of the name.
    subroutine send_to_python(arr, n, name_py)
        real(kind=c_double), intent(in) :: arr(:)
        integer(kind=c_int), value, intent(in) :: n
        character(len=*, kind=c_char), intent(in) :: name_py
        
        integer(c_int) :: error
        
        error = send_to_python_c(arr, n, append_end_of_string(name_py))
        call check_error(error)
    end subroutine send_to_python
    
    ! Wrapper to add c_null_char at the end of the name.
    subroutine run_file(path)
        character(len=*, kind=c_char), intent(in) :: path
        
        integer(kind=c_int) :: error
        
        error = run_file_c(append_end_of_string(path))
        call check_error(error)
    end subroutine run_file
    
end module send2py
