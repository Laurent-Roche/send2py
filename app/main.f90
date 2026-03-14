! Pour compiler: fpm run --c-flag "$(/home/laurent/Programmation/Python/Installations/install/3_14/bin/python3-config --cflags)" --link-flag "$(/home/laurent/Programmation/Python/Installations/install/3_14/bin/python3-config --ldflags) -Wl,-rpath,/home/laurent/Programmation/Python/Installations/install/3_14/lib"

program main
    use iso_c_binding, only: c_char, c_null_char, c_int
    use stdlib_constants, only: PI_dp
    use stdlib_kinds, only: dp, int64
    use stdlib_math, only: linspace
    use pyplot_module
    
    use send2py, only: plt_plot
    
    implicit none
    
    character(len=15, kind=c_char), parameter :: &
                                path = c_char_"plot.py" // c_null_char
    integer(kind=c_int), parameter :: N = 10000
    integer(kind=c_int) :: start_time, end_time
    real(kind=dp) :: x(N), y(n), rate
    type(pyplot) :: plt
    x = linspace(0.0_dp, 6*PI_dp, N)
    y = sin(x)
    rate = 1.0_dp
    print '("Fortran 0x", Z0, " 0x", Z0)', loc(x), loc(y)
    
end program main
