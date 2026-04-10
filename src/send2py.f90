module send2py
    use iso_c_binding
    use stdlib_strings
    implicit none
  
    private
    public :: start_python, end_python, send_integer, send_real, send_logical, &
               send_bytes, send_str, send_variable, send_array, run_file
    
    ! Conversion between C types and Fortran type/kinds.
    
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
        subroutine run_file_c(path) bind(c, name="run_file")
            use iso_c_binding, only: c_char
            character(c_char), intent(in) :: path(*)
        end subroutine run_file_c
    end interface
    
    interface
        function send_int8(x, name_py) &
                                bind(c, name="send_int8") result(error)
            use iso_c_binding, only: c_char, c_int8_t, c_int
            integer(c_int8_t), intent(in) :: x
            character(c_char), intent(in) :: name_py(*)
            integer(c_int) :: error
        end function send_int8
    end interface
    interface
        function send_int16(x, name_py) &
                                bind(c, name="send_int16") result(error)
            use iso_c_binding, only: c_char, c_int16_t, c_int
            integer(c_int16_t), intent(in) :: x
            character(c_char), intent(in) :: name_py(*)
            integer(c_int) :: error
        end function send_int16
    end interface
    interface
        function send_int32(x, name_py) &
                                bind(c, name="send_int32") result(error)
            use iso_c_binding, only: c_char, c_int32_t, c_int
            integer(c_int32_t), intent(in) :: x
            character(c_char), intent(in) :: name_py(*)
            integer(c_int) :: error
        end function send_int32
    end interface
    interface
        function send_int64(x, name_py) &
                                bind(c, name="send_int64") result(error)
            use iso_c_binding, only: c_char, c_int64_t, c_int
            integer(c_int64_t), intent(in) :: x
            character(c_char), intent(in) :: name_py(*)
            integer(c_int) :: error
        end function send_int64
    end interface
    interface
        function send_float(x, name_py) &
                                bind(c, name="send_float") result(error)
            use iso_c_binding, only: c_char, c_float, c_int
            real(c_float), intent(in) :: x
            character(c_char), intent(in) :: name_py(*)
            integer(c_int) :: error
        end function send_float
    end interface
    interface
        function send_double(x, name_py) &
                                bind(c, name="send_double") result(error)
            use iso_c_binding, only: c_char, c_double, c_int
            real(c_double), intent(in) :: x
            character(c_char), intent(in) :: name_py(*)
            integer(c_int) :: error
        end function send_double
    end interface
    interface
        function send_bool(x, name_py) &
                                bind(c, name="send_bool") result(error)
            use iso_c_binding, only: c_char, c_bool, c_int
            logical(c_bool), intent(in) :: x
            character(c_char), intent(in) :: name_py(*)
            integer(c_int) :: error
        end function send_bool
    end interface
    
    interface send_integer
        procedure :: send_int8_f
        procedure :: send_int16_f
        procedure :: send_int32_f
        procedure :: send_int64_f
    end interface
    
    interface send_real
        procedure :: send_float_f
        procedure :: send_double_f
    end interface
    
    interface send_logical
        procedure :: send_bool_f, send_bool_fkind_f
    end interface
    
    interface
        function send_bytes_c(x, name_py) &
                                bind(c, name="send_bytes") result(error)
            use iso_c_binding, only: c_char, c_int
            character(c_char), intent(in) :: x(*)
            character(c_char), intent(in) :: name_py(*)
            integer(c_int) :: error
        end function send_bytes_c
    end interface
    
    interface send_bytes
        procedure :: send_bytes_f
    end interface
    interface
        function send_str_c(x, name_py) &
                                bind(c, name="send_str") result(error)
            use iso_c_binding, only: c_char, c_int
            character(c_char), intent(in) :: x(*)
            character(c_char), intent(in) :: name_py(*)
            integer(c_int) :: error
        end function send_str_c
    end interface
    
    interface send_str
        procedure :: send_str_f
    end interface
    
    interface send_variable
        procedure :: send_int8_f
        procedure :: send_int16_f
        procedure :: send_int32_f
        procedure :: send_int64_f
        procedure :: send_float_f
        procedure :: send_double_f
        procedure :: send_bool_f
        procedure :: send_bool_fkind_f, send_str_f
    end interface
    
    interface
        function send_array_int8(arr_ptr, shape_, rank_, name_py) &
                            bind(c, name="send_array_int8") result(error)
            use iso_c_binding, only: c_char, c_int8_t, c_size_t, c_int, &
                                     c_int64_t, c_ptr
            type(c_ptr), intent(in), value :: arr_ptr
            integer(c_int64_t), intent(in) :: shape_(rank_)
            integer(c_int), intent(in), value :: rank_
            character(c_char), intent(in) :: name_py(*)
            integer(c_int) :: error
        end function send_array_int8
    end interface
    interface
        function send_array_int16(arr_ptr, shape_, rank_, name_py) &
                            bind(c, name="send_array_int16") result(error)
            use iso_c_binding, only: c_char, c_int16_t, c_size_t, c_int, &
                                     c_int64_t, c_ptr
            type(c_ptr), intent(in), value :: arr_ptr
            integer(c_int64_t), intent(in) :: shape_(rank_)
            integer(c_int), intent(in), value :: rank_
            character(c_char), intent(in) :: name_py(*)
            integer(c_int) :: error
        end function send_array_int16
    end interface
    interface
        function send_array_int32(arr_ptr, shape_, rank_, name_py) &
                            bind(c, name="send_array_int32") result(error)
            use iso_c_binding, only: c_char, c_int32_t, c_size_t, c_int, &
                                     c_int64_t, c_ptr
            type(c_ptr), intent(in), value :: arr_ptr
            integer(c_int64_t), intent(in) :: shape_(rank_)
            integer(c_int), intent(in), value :: rank_
            character(c_char), intent(in) :: name_py(*)
            integer(c_int) :: error
        end function send_array_int32
    end interface
    interface
        function send_array_int64(arr_ptr, shape_, rank_, name_py) &
                            bind(c, name="send_array_int64") result(error)
            use iso_c_binding, only: c_char, c_int64_t, c_size_t, c_int, &
                                     c_int64_t, c_ptr
            type(c_ptr), intent(in), value :: arr_ptr
            integer(c_int64_t), intent(in) :: shape_(rank_)
            integer(c_int), intent(in), value :: rank_
            character(c_char), intent(in) :: name_py(*)
            integer(c_int) :: error
        end function send_array_int64
    end interface
    interface
        function send_array_float(arr_ptr, shape_, rank_, name_py) &
                            bind(c, name="send_array_float") result(error)
            use iso_c_binding, only: c_char, c_float, c_size_t, c_int, &
                                     c_int64_t, c_ptr
            type(c_ptr), intent(in), value :: arr_ptr
            integer(c_int64_t), intent(in) :: shape_(rank_)
            integer(c_int), intent(in), value :: rank_
            character(c_char), intent(in) :: name_py(*)
            integer(c_int) :: error
        end function send_array_float
    end interface
    interface
        function send_array_double(arr_ptr, shape_, rank_, name_py) &
                            bind(c, name="send_array_double") result(error)
            use iso_c_binding, only: c_char, c_double, c_size_t, c_int, &
                                     c_int64_t, c_ptr
            type(c_ptr), intent(in), value :: arr_ptr
            integer(c_int64_t), intent(in) :: shape_(rank_)
            integer(c_int), intent(in), value :: rank_
            character(c_char), intent(in) :: name_py(*)
            integer(c_int) :: error
        end function send_array_double
    end interface
    interface
        function send_array_bool(arr_ptr, shape_, rank_, name_py) &
                            bind(c, name="send_array_bool") result(error)
            use iso_c_binding, only: c_char, c_bool, c_size_t, c_int, &
                                     c_int64_t, c_ptr
            type(c_ptr), intent(in), value :: arr_ptr
            integer(c_int64_t), intent(in) :: shape_(rank_)
            integer(c_int), intent(in), value :: rank_
            character(c_char), intent(in) :: name_py(*)
            integer(c_int) :: error
        end function send_array_bool
    end interface
    
    interface send_array
        procedure :: send_array_int8_f
        procedure :: send_array_int16_f
        procedure :: send_array_int32_f
        procedure :: send_array_int64_f
        procedure :: send_array_float_f
        procedure :: send_array_double_f
        procedure :: send_array_bool_f
    end interface
    
    
    
contains

    ! Helpers

    ! Terminates the program if the error code is non null.
    subroutine check_error(error)
        integer(c_int), intent(in) :: error
        if (error /= 0) then
            print '(a)', "Python API error " // to_string(error) &
                                               // ": terminating program"
            call end_python()
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
        
        call run_file_c(append_end_of_string(path))
    end subroutine run_file


    ! send_xxx() wrappers to add c_null_char.
    subroutine send_int8_f(x, name_py)
        integer(c_int8_t), intent(in) :: x
        character(len=*, kind=c_char), intent(in) :: name_py
        
        integer(c_int) :: error

        error = send_int8(x, append_end_of_string(name_py))
        call check_error(error)
    end subroutine send_int8_f
    subroutine send_int16_f(x, name_py)
        integer(c_int16_t), intent(in) :: x
        character(len=*, kind=c_char), intent(in) :: name_py
        
        integer(c_int) :: error

        error = send_int16(x, append_end_of_string(name_py))
        call check_error(error)
    end subroutine send_int16_f
    subroutine send_int32_f(x, name_py)
        integer(c_int32_t), intent(in) :: x
        character(len=*, kind=c_char), intent(in) :: name_py
        
        integer(c_int) :: error

        error = send_int32(x, append_end_of_string(name_py))
        call check_error(error)
    end subroutine send_int32_f
    subroutine send_int64_f(x, name_py)
        integer(c_int64_t), intent(in) :: x
        character(len=*, kind=c_char), intent(in) :: name_py
        
        integer(c_int) :: error

        error = send_int64(x, append_end_of_string(name_py))
        call check_error(error)
    end subroutine send_int64_f
    subroutine send_float_f(x, name_py)
        real(c_float), intent(in) :: x
        character(len=*, kind=c_char), intent(in) :: name_py
        
        integer(c_int) :: error

        error = send_float(x, append_end_of_string(name_py))
        call check_error(error)
    end subroutine send_float_f
    subroutine send_double_f(x, name_py)
        real(c_double), intent(in) :: x
        character(len=*, kind=c_char), intent(in) :: name_py
        
        integer(c_int) :: error

        error = send_double(x, append_end_of_string(name_py))
        call check_error(error)
    end subroutine send_double_f
    subroutine send_bool_f(x, name_py)
        logical(c_bool), intent(in) :: x
        character(len=*, kind=c_char), intent(in) :: name_py
        
        integer(c_int) :: error

        error = send_bool(x, append_end_of_string(name_py))
        call check_error(error)
    end subroutine send_bool_f
    
    ! Converts default logical kind to c_bool to be able to send default 
    ! logicals too, not only c_bool.
    subroutine send_bool_fkind_f(x, name_py)
        logical, intent(in) :: x
        character(len=*, kind=c_char), intent(in) :: name_py
        
        integer(c_int) :: error

        error = send_bool(logical(x, kind=c_bool), &
                          append_end_of_string(name_py))
        call check_error(error)
    end subroutine send_bool_fkind_f
    
    subroutine send_bytes_f(x, name_py)
        character(len=*, kind=c_char), intent(in) :: x
        character(len=*, kind=c_char), intent(in) :: name_py
        
        integer(c_int) :: error

        error = send_bytes_c(append_end_of_string(x), &
                                     append_end_of_string(name_py))
        call check_error(error)
    end subroutine send_bytes_f
    subroutine send_str_f(x, name_py)
        character(len=*, kind=c_char), intent(in) :: x
        character(len=*, kind=c_char), intent(in) :: name_py
        
        integer(c_int) :: error

        error = send_str_c(append_end_of_string(x), &
                                     append_end_of_string(name_py))
        call check_error(error)
    end subroutine send_str_f

    ! send_array_xxx() wrappers to add array size in call and c_null_char.
    subroutine send_array_int8_f(arr, name_py)
        integer(c_int8_t), target, intent(in), contiguous :: arr(..)
        character(len=*, kind=c_char), intent(in) :: name_py
        
        integer(c_int) :: rank_, error, i
        integer(c_int64_t), allocatable :: shape_(:)
        type(c_ptr) :: arr_ptr
        
        ! select rank to get the shape and pointer.
        select rank (arr)
        rank (1)
            rank_ = 1
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1))
        rank (2)
            rank_ = 2
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1))
        rank (3)
            rank_ = 3
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1))
        rank (4)
            rank_ = 4
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1))
        rank (5)
            rank_ = 5
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1))
        rank (6)
            rank_ = 6
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1))
        rank (7)
            rank_ = 7
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1))
        rank (8)
            rank_ = 8
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1))
        rank (9)
            rank_ = 9
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank (10)
            rank_ = 10
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank (11)
            rank_ = 11
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank (12)
            rank_ = 12
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank (13)
            rank_ = 13
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank (14)
            rank_ = 14
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank default
            stop "Rank too high to be passed to NumPy"
        end select
        ! Call and check error.
        error = send_array_int8(arr_ptr, shape_, rank_, &
                                      append_end_of_string(name_py))
        deallocate(shape_)
        call check_error(error)
    end subroutine send_array_int8_f
    subroutine send_array_int16_f(arr, name_py)
        integer(c_int16_t), target, intent(in), contiguous :: arr(..)
        character(len=*, kind=c_char), intent(in) :: name_py
        
        integer(c_int) :: rank_, error, i
        integer(c_int64_t), allocatable :: shape_(:)
        type(c_ptr) :: arr_ptr
        
        ! select rank to get the shape and pointer.
        select rank (arr)
        rank (1)
            rank_ = 1
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1))
        rank (2)
            rank_ = 2
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1))
        rank (3)
            rank_ = 3
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1))
        rank (4)
            rank_ = 4
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1))
        rank (5)
            rank_ = 5
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1))
        rank (6)
            rank_ = 6
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1))
        rank (7)
            rank_ = 7
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1))
        rank (8)
            rank_ = 8
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1))
        rank (9)
            rank_ = 9
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank (10)
            rank_ = 10
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank (11)
            rank_ = 11
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank (12)
            rank_ = 12
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank (13)
            rank_ = 13
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank (14)
            rank_ = 14
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank default
            stop "Rank too high to be passed to NumPy"
        end select
        ! Call and check error.
        error = send_array_int16(arr_ptr, shape_, rank_, &
                                      append_end_of_string(name_py))
        deallocate(shape_)
        call check_error(error)
    end subroutine send_array_int16_f
    subroutine send_array_int32_f(arr, name_py)
        integer(c_int32_t), target, intent(in), contiguous :: arr(..)
        character(len=*, kind=c_char), intent(in) :: name_py
        
        integer(c_int) :: rank_, error, i
        integer(c_int64_t), allocatable :: shape_(:)
        type(c_ptr) :: arr_ptr
        
        ! select rank to get the shape and pointer.
        select rank (arr)
        rank (1)
            rank_ = 1
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1))
        rank (2)
            rank_ = 2
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1))
        rank (3)
            rank_ = 3
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1))
        rank (4)
            rank_ = 4
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1))
        rank (5)
            rank_ = 5
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1))
        rank (6)
            rank_ = 6
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1))
        rank (7)
            rank_ = 7
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1))
        rank (8)
            rank_ = 8
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1))
        rank (9)
            rank_ = 9
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank (10)
            rank_ = 10
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank (11)
            rank_ = 11
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank (12)
            rank_ = 12
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank (13)
            rank_ = 13
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank (14)
            rank_ = 14
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank default
            stop "Rank too high to be passed to NumPy"
        end select
        ! Call and check error.
        error = send_array_int32(arr_ptr, shape_, rank_, &
                                      append_end_of_string(name_py))
        deallocate(shape_)
        call check_error(error)
    end subroutine send_array_int32_f
    subroutine send_array_int64_f(arr, name_py)
        integer(c_int64_t), target, intent(in), contiguous :: arr(..)
        character(len=*, kind=c_char), intent(in) :: name_py
        
        integer(c_int) :: rank_, error, i
        integer(c_int64_t), allocatable :: shape_(:)
        type(c_ptr) :: arr_ptr
        
        ! select rank to get the shape and pointer.
        select rank (arr)
        rank (1)
            rank_ = 1
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1))
        rank (2)
            rank_ = 2
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1))
        rank (3)
            rank_ = 3
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1))
        rank (4)
            rank_ = 4
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1))
        rank (5)
            rank_ = 5
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1))
        rank (6)
            rank_ = 6
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1))
        rank (7)
            rank_ = 7
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1))
        rank (8)
            rank_ = 8
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1))
        rank (9)
            rank_ = 9
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank (10)
            rank_ = 10
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank (11)
            rank_ = 11
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank (12)
            rank_ = 12
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank (13)
            rank_ = 13
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank (14)
            rank_ = 14
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank default
            stop "Rank too high to be passed to NumPy"
        end select
        ! Call and check error.
        error = send_array_int64(arr_ptr, shape_, rank_, &
                                      append_end_of_string(name_py))
        deallocate(shape_)
        call check_error(error)
    end subroutine send_array_int64_f
    subroutine send_array_float_f(arr, name_py)
        real(c_float), target, intent(in), contiguous :: arr(..)
        character(len=*, kind=c_char), intent(in) :: name_py
        
        integer(c_int) :: rank_, error, i
        integer(c_int64_t), allocatable :: shape_(:)
        type(c_ptr) :: arr_ptr
        
        ! select rank to get the shape and pointer.
        select rank (arr)
        rank (1)
            rank_ = 1
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1))
        rank (2)
            rank_ = 2
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1))
        rank (3)
            rank_ = 3
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1))
        rank (4)
            rank_ = 4
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1))
        rank (5)
            rank_ = 5
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1))
        rank (6)
            rank_ = 6
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1))
        rank (7)
            rank_ = 7
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1))
        rank (8)
            rank_ = 8
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1))
        rank (9)
            rank_ = 9
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank (10)
            rank_ = 10
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank (11)
            rank_ = 11
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank (12)
            rank_ = 12
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank (13)
            rank_ = 13
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank (14)
            rank_ = 14
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank default
            stop "Rank too high to be passed to NumPy"
        end select
        ! Call and check error.
        error = send_array_float(arr_ptr, shape_, rank_, &
                                      append_end_of_string(name_py))
        deallocate(shape_)
        call check_error(error)
    end subroutine send_array_float_f
    subroutine send_array_double_f(arr, name_py)
        real(c_double), target, intent(in), contiguous :: arr(..)
        character(len=*, kind=c_char), intent(in) :: name_py
        
        integer(c_int) :: rank_, error, i
        integer(c_int64_t), allocatable :: shape_(:)
        type(c_ptr) :: arr_ptr
        
        ! select rank to get the shape and pointer.
        select rank (arr)
        rank (1)
            rank_ = 1
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1))
        rank (2)
            rank_ = 2
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1))
        rank (3)
            rank_ = 3
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1))
        rank (4)
            rank_ = 4
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1))
        rank (5)
            rank_ = 5
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1))
        rank (6)
            rank_ = 6
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1))
        rank (7)
            rank_ = 7
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1))
        rank (8)
            rank_ = 8
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1))
        rank (9)
            rank_ = 9
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank (10)
            rank_ = 10
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank (11)
            rank_ = 11
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank (12)
            rank_ = 12
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank (13)
            rank_ = 13
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank (14)
            rank_ = 14
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank default
            stop "Rank too high to be passed to NumPy"
        end select
        ! Call and check error.
        error = send_array_double(arr_ptr, shape_, rank_, &
                                      append_end_of_string(name_py))
        deallocate(shape_)
        call check_error(error)
    end subroutine send_array_double_f
    subroutine send_array_bool_f(arr, name_py)
        logical(c_bool), target, intent(in), contiguous :: arr(..)
        character(len=*, kind=c_char), intent(in) :: name_py
        
        integer(c_int) :: rank_, error, i
        integer(c_int64_t), allocatable :: shape_(:)
        type(c_ptr) :: arr_ptr
        
        ! select rank to get the shape and pointer.
        select rank (arr)
        rank (1)
            rank_ = 1
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1))
        rank (2)
            rank_ = 2
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1))
        rank (3)
            rank_ = 3
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1))
        rank (4)
            rank_ = 4
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1))
        rank (5)
            rank_ = 5
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1))
        rank (6)
            rank_ = 6
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1))
        rank (7)
            rank_ = 7
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1))
        rank (8)
            rank_ = 8
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1))
        rank (9)
            rank_ = 9
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank (10)
            rank_ = 10
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank (11)
            rank_ = 11
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank (12)
            rank_ = 12
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank (13)
            rank_ = 13
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank (14)
            rank_ = 14
            allocate(shape_(rank_))
            do i = 1, rank_
                shape_(i) = size(arr, i, kind=c_int64_t)
            end do
            arr_ptr = c_loc(arr(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1))
        rank default
            stop "Rank too high to be passed to NumPy"
        end select
        ! Call and check error.
        error = send_array_bool(arr_ptr, shape_, rank_, &
                                      append_end_of_string(name_py))
        deallocate(shape_)
        call check_error(error)
    end subroutine send_array_bool_f
    
end module send2py
