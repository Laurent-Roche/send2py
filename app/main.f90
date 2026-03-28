! Pour compiler: fpm run --c-flag "$(/home/laurent/Programmation/Python/Installations/install/3_14/bin/python3-config --cflags)" --link-flag "$(/home/laurent/Programmation/Python/Installations/install/3_14/bin/python3-config --ldflags) -Wl,-rpath,/home/laurent/Programmation/Python/Installations/install/3_14/lib"

program main
    use iso_c_binding, only: c_char, c_int
    use stdlib_constants, only: PI_dp
    use stdlib_kinds, only: sp, dp, int8
    use stdlib_math, only: linspace
    
    use send2py
    
    implicit none
    
    character(len=7, kind=c_char), parameter :: &
                                path = c_char_"plot.py"
    integer(kind=c_int), parameter :: N = 100000
    real(kind=sp), allocatable :: x(:)
    integer(kind=int8), allocatable :: y(:)
    
    allocate(x(N), y(N))
    x = linspace(0.0_dp, 6*PI_dp, N)
    y = int(256 * sin(x), kind=int8)
    
    call start_python()
    call send_array(x, "x")
    call send_array(y, "y")
    call run_file(path)
    call end_python()
    
end program main
