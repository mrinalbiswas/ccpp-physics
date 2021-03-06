!> \file GFS_SCNV_generic.F90
!!  Contains code related to shallow convective schemes to be used within the GFS physics suite.

      module GFS_SCNV_generic_pre

      contains

      subroutine GFS_SCNV_generic_pre_init ()
      end subroutine GFS_SCNV_generic_pre_init

      subroutine GFS_SCNV_generic_pre_finalize()
      end subroutine GFS_SCNV_generic_pre_finalize

!> \section arg_table_GFS_SCNV_generic_pre_run Argument Table
!! \htmlinclude GFS_SCNV_generic_pre_run.html
!!
      subroutine GFS_SCNV_generic_pre_run (im, levs, ldiag3d, lgocart, gt0, gq0_water_vapor, &
        save_t, save_qv, errmsg, errflg)

        use machine,               only: kind_phys

        implicit none

        integer, intent(in) :: im, levs
        logical, intent(in) :: ldiag3d, lgocart
        real(kind=kind_phys), dimension(im,levs), intent(in) :: gt0, gq0_water_vapor

        real(kind=kind_phys), dimension(im,levs), intent(inout) :: save_t, save_qv
        character(len=*),                 intent(out) :: errmsg
        integer,                          intent(out) :: errflg

        integer :: i, k

        ! Initialize CCPP error handling variables
        errmsg = ''
        errflg = 0

        if (ldiag3d) then
          do k=1,levs
            do i=1,im
              save_t(i,k)   = gt0(i,k)
            enddo
          enddo
        endif
!        if (ldiag3d .or. lgocart) then
!          do k=1,levs
!            do i=1,im
!              save_qv(i,k) = gq0_water_vapor(i,k)
!            enddo
!          enddo
!        endif

    end subroutine GFS_SCNV_generic_pre_run

    end module GFS_SCNV_generic_pre

    module GFS_SCNV_generic_post

    contains

    subroutine GFS_SCNV_generic_post_init ()
    end subroutine GFS_SCNV_generic_post_init

    subroutine GFS_SCNV_generic_post_finalize ()
    end subroutine GFS_SCNV_generic_post_finalize

!> \section arg_table_GFS_SCNV_generic_post_run Argument Table
!! \htmlinclude GFS_SCNV_generic_post_run.html
!!
      subroutine GFS_SCNV_generic_post_run (im, levs, nn, lssav, ldiag3d, lgocart, cplchm, &
        frain, gt0, gq0_water_vapor, save_t, save_qv, dqdti, dt3dt, dq3dt, clw, errmsg, errflg)

      use machine,               only: kind_phys

      implicit none

      integer, intent(in) :: im, levs, nn
      logical, intent(in) :: lssav, ldiag3d, lgocart, cplchm
      real(kind=kind_phys),                     intent(in) :: frain
      real(kind=kind_phys), dimension(im,levs), intent(in) :: gt0, gq0_water_vapor
      real(kind=kind_phys), dimension(im,levs), intent(in) :: save_t, save_qv

      ! dqdti only allocated if ldiag3d == .true. or lgocart == .true.
      real(kind=kind_phys), dimension(:,:), intent(inout) :: dqdti
      ! dt3dt, dq3dt, only allocated if ldiag3d == .true.
      real(kind=kind_phys), dimension(:,:), intent(inout) :: dt3dt, dq3dt
      real(kind=kind_phys), dimension(im,levs,nn), intent(inout) :: clw

      character(len=*),              intent(out) :: errmsg
      integer,                       intent(out) :: errflg

      integer :: i, k
      real(kind=kind_phys) :: tem

      ! Initialize CCPP error handling variables
      errmsg = ''
      errflg = 0

      if (lssav) then
!          update dqdt_v to include moisture tendency due to shallow convection
        if (lgocart .and. .not.cplchm) then
          do k=1,levs
            do i=1,im
              tem  = (gq0_water_vapor(i,k)-save_qv(i,k)) * frain
              dqdti(i,k) = dqdti(i,k) + tem
            enddo
          enddo
        endif
        if (ldiag3d) then
          do k=1,levs
            do i=1,im
              dt3dt(i,k) = dt3dt(i,k) + (gt0(i,k)  - save_t(i,k))   * frain
!              dq3dt(i,k) = dq3dt(i,k) + (gq0_water_vapor(i,k) - save_qv(i,k)) * frain
            enddo
          enddo
        endif
      endif   ! end if_lssav
!
      if (cplchm) then
        do k=1,levs
          do i=1,im
            tem  = (gq0_water_vapor(i,k)-save_qv(i,k)) * frain
            dqdti(i,k) = dqdti(i,k) + tem
          enddo
        enddo
      endif
!
      do k=1,levs
        do i=1,im
          if (clw(i,k,2) <= -999.0) clw(i,k,2) = 0.0
        enddo
      enddo

      end subroutine GFS_SCNV_generic_post_run

      end module GFS_SCNV_generic_post
