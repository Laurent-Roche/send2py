! Pour compiler: fpm run --c-flag "$(/home/laurent/Programmation/Python/Installations/install/3_14/bin/python3-config --cflags)" --link-flag "$(/home/laurent/Programmation/Python/Installations/install/3_14/bin/python3-config --ldflags) -Wl,-rpath,/home/laurent/Programmation/Python/Installations/install/3_14/lib"

program main
    use iso_c_binding, only: c_char, c_int, c_bool
    use stdlib_constants, only: PI_dp
    use stdlib_kinds
    use stdlib_math, only: linspace
    
    use send2py
    
    implicit none
    
    character(kind=c_char, len=7), parameter :: &
                                path = c_char_"plot.py"
    integer(c_int), parameter :: N = 100000
    real(dp), allocatable :: x(:)
    integer(int8), allocatable :: y(:)
    integer(int16), allocatable :: arr(:, :)
    
    allocate(x(N), y(N), arr(2, 3))
    x = linspace(0.0_dp, 4*PI_dp, N)
    y = int(256 * sin(x), kind=int8)
    arr(1, 1) = 1_int16
    arr(2, 1) = 2_int16
    arr(1, 2) = 3_int16
    arr(2, 2) = 4_int16
    arr(1, 3) = 5_int16
    arr(2, 3) = 6_int16
    print *, arr
    
    call start_python()
    call send_array(x, "x")
    call send_array(y, "y")
    call send_array(arr, "arr")
    call send_variable("r", "color")
    call send_variable(.true., "show_grid")
    call send_variable("Integer overflow on a sine function", "title")
    call run_file(path)
    call end_python()
    
    print *, arr
    
end program main
