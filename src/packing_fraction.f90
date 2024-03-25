module packing_fraction
    use, intrinsic :: iso_fortran_env, only: sp=>real32, dp=>real64
    implicit none
    
contains

    subroutine get_packing_fraction(packing_fraction, width, height, radius, num_of_samples)
        implicit none 

        real(dp), intent(out) :: packing_fraction
        
        !inputs
        real(dp), intent(in) :: width, height, radius
        integer, intent(in) :: num_of_samples

        ! calculation variables
        real(dp) :: PI=4.D0*DATAN(1.D0)
        real(dp) :: diameter, circle_area, box_area, x, y, randx, randy
        integer :: batch_size, sample_number, num_of_circles, i
        real(dp), allocatable :: x_coordinates(:), y_coordinates(:)
        logical :: overlapping

        allocate(x_coordinates(num_of_samples))
        allocate(y_coordinates(num_of_samples))

        diameter = 2.0_dp * radius
        circle_area = PI * (radius ** 2)
        box_area = width * height
        batch_size = floor(num_of_samples * 0.01)
        num_of_circles = 0

        do sample_number = 0, num_of_samples
            call random_number(randx)
            call random_number(randy)
            x = radius + randx * (width - diameter)
            y = radius + randy * (height - diameter)

            overlapping = .FALSE.
            do i = 1, num_of_circles
                overlapping = (((x_coordinates(i) - x)**2 + (y_coordinates(i) - y)**2) ** 0.5) < diameter
                if (overlapping) then
                    exit
                end if 
            end do

            if (.not.overlapping) then
                x_coordinates(num_of_circles) = x
                y_coordinates(num_of_circles) = y
                num_of_circles = num_of_circles + 1
            end if
        end do

        deallocate(x_coordinates)
        deallocate(y_coordinates)

        ! Calculate outputs 
        packing_fraction = (num_of_circles * circle_area) / box_area
        ! print *, 'Packing fraction for ', num_of_samples, ' samples and ', num_of_circles, ' circles is ', packing_fraction
        ! open (unit=0, file="coordinates.csv")
        ! do i = 0, num_of_circles
        !     write(0, *) x_coordinates(i), y_coordinates(i)
        ! end do
        ! close (0)
    end subroutine get_packing_fraction

end module packing_fraction
    