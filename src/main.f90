program hello_world
    use, intrinsic :: iso_fortran_env, only: sp=>real32, dp=>real64
    use packing_fraction
    implicit none

    real(dp) :: pf
    real(dp) :: width, height, radius
    integer :: num_of_samples

    print *, 'Box width:'
    read(*, *) width
    print *, 'Box height:'
    read(*, *) height
    print *, 'Circle radius:'
    read(*, *) radius
    print *, 'Total number of samples:'
    read(*, *) num_of_samples

    print*, 'Input are:' 
    print *, 'Box width: ', width
    print *, 'Box height: ', height
    print *, 'Circle radius: ', radius
    print *, 'Total number of samples: ', num_of_samples

    call get_packing_fraction(pf, width, height, radius, num_of_samples)

    print *, "Packing fraction = ", pf
end program hello_world