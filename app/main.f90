! Pour compiler: fpm run --c-flag "$(/home/laurent/Programmation/Python/Installations/install/3_14/bin/python3-config --cflags)" --link-flag "$(/home/laurent/Programmation/Python/Installations/install/3_14/bin/python3-config --ldflags) -Wl,-rpath,/home/laurent/Programmation/Python/Installations/install/3_14/lib"

program main
    use iso_c_binding, only: c_char, c_int, c_bool
    use stdlib_constants, only: PI_dp
    use stdlib_kinds, only: sp, dp, int8
    use stdlib_math, only: linspace
    
    use send2py
    
    implicit none
    
    character(kind=c_char, len=7), parameter :: &
                                path = c_char_"plot.py"
    integer(c_int), parameter :: N = 100000
    real(dp), allocatable :: x(:)
    integer(int8), allocatable :: y(:)
    logical(c_bool), allocatable :: mask(:)
    
    allocate(x(N), y(N), mask(N))
    x = linspace(0.0_dp, 6*PI_dp, N)
    y = int(256 * sin(x), kind=int8)
    where (x <= 2 * PI_dp .or. x >= 4 * PI_dp)
        mask = .true.
    elsewhere
        mask = .false.
    end where
    
    call start_python()
    call send_array(x, "x")
    call send_array(y, "y")
    call send_array(mask, "mask")
    call run_file(path)
    call end_python()
    
end program main
