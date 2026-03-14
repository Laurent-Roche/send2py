module send2py
    implicit none
  
    private
    public :: plt_plot
    
    interface
        subroutine plt_plot(path, x, y, n) bind(c, name="plt_plot")
            use iso_c_binding, only: c_char, c_double, c_int
            character(kind=c_char), dimension(*) :: path
            real(kind=c_double) :: x(*), y(*)
            integer(kind=c_int), value :: n
        end subroutine plt_plot
    end interface
    
end module send2py
