!> \file GFS_suite_interstitial.f90
!!  Contains code related to more than one scheme in the GFS physics suite.

    module GFS_suite_interstitial_rad_reset

    contains

    subroutine GFS_suite_interstitial_rad_reset_init ()
    end subroutine GFS_suite_interstitial_rad_reset_init

    subroutine GFS_suite_interstitial_rad_reset_finalize()
    end subroutine GFS_suite_interstitial_rad_reset_finalize

!> \section arg_table_GFS_suite_interstitial_rad_reset_run Argument Table
!! \htmlinclude GFS_suite_interstitial_rad_reset_run.html
!!
    subroutine GFS_suite_interstitial_rad_reset_run (Interstitial, errmsg, errflg)

      use GFS_typedefs, only: GFS_interstitial_type

      implicit none

      ! interface variables
      type(GFS_interstitial_type), intent(inout) :: Interstitial
      character(len=*), intent(out) :: errmsg
      integer, intent(out) :: errflg

      errmsg = ''
      errflg = 0

      call Interstitial%rad_reset()

    end subroutine GFS_suite_interstitial_rad_reset_run

    end module GFS_suite_interstitial_rad_reset


    module GFS_suite_interstitial_phys_reset

    contains

    subroutine GFS_suite_interstitial_phys_reset_init ()
    end subroutine GFS_suite_interstitial_phys_reset_init

    subroutine GFS_suite_interstitial_phys_reset_finalize()
    end subroutine GFS_suite_interstitial_phys_reset_finalize

!> \section arg_table_GFS_suite_interstitial_phys_reset_run Argument Table
!! \htmlinclude GFS_suite_interstitial_phys_reset_run.html
!!
    subroutine GFS_suite_interstitial_phys_reset_run (Interstitial, Model, errmsg, errflg)

      use GFS_typedefs, only: GFS_control_type, GFS_interstitial_type

      implicit none

      ! interface variables
      type(GFS_interstitial_type), intent(inout) :: Interstitial
      type(GFS_control_type),      intent(in)    :: Model
      character(len=*), intent(out) :: errmsg
      integer, intent(out) :: errflg

      errmsg = ''
      errflg = 0

      call Interstitial%phys_reset(Model)

    end subroutine GFS_suite_interstitial_phys_reset_run

    end module GFS_suite_interstitial_phys_reset


    module GFS_suite_interstitial_1

    contains

    subroutine GFS_suite_interstitial_1_init ()
    end subroutine GFS_suite_interstitial_1_init

    subroutine GFS_suite_interstitial_1_finalize()
    end subroutine GFS_suite_interstitial_1_finalize

!> \section arg_table_GFS_suite_interstitial_1_run Argument Table
!! \htmlinclude GFS_suite_interstitial_1_run.html
!!
    subroutine GFS_suite_interstitial_1_run (im, levs, ntrac, dtf, dtp, slmsk, area, dxmin, dxinv, pgr, &
      frain, islmsk, work1, work2, psurf, dudt, dvdt, dtdt, dtdtc, dqdt, errmsg, errflg)

      use machine,               only: kind_phys

      implicit none

      ! interface variables
      integer,              intent(in) :: im, levs, ntrac
      real(kind=kind_phys), intent(in) :: dtf, dtp, dxmin, dxinv
      real(kind=kind_phys), intent(in), dimension(im) :: slmsk, area, pgr

      real(kind=kind_phys), intent(out) :: frain
      integer,              intent(out), dimension(im) :: islmsk
      real(kind=kind_phys), intent(out), dimension(im) :: work1, work2, psurf
      real(kind=kind_phys), intent(out), dimension(im,levs) :: dudt, dvdt, dtdt, dtdtc
      real(kind=kind_phys), intent(out), dimension(im,levs,ntrac) ::  dqdt
      character(len=*),     intent(out) :: errmsg
      integer,              intent(out) :: errflg

      ! local variables
      integer :: i, k, n

      ! Initialize CCPP error handling variables
      errmsg = ''
      errflg = 0

      frain = dtf / dtp

      do i = 1, im
        islmsk(i)   = nint(slmsk(i))

        work1(i) = (log(area(i)) - dxmin) * dxinv
        work1(i) = max(0.0, min(1.0,work1(i)))
        work2(i) = 1.0 - work1(i)
        psurf(i) = pgr(i)
      end do

      do k=1,levs
        do i=1,im
          dudt(i,k)  = 0.
          dvdt(i,k)  = 0.
          dtdt(i,k)  = 0.
          dtdtc(i,k) = 0.
        enddo
      enddo
      do n=1,ntrac
        do k=1,levs
          do i=1,im
            dqdt(i,k,n) = 0.
          enddo
        enddo
      enddo

    end subroutine GFS_suite_interstitial_1_run

  end module GFS_suite_interstitial_1


  module GFS_suite_interstitial_2

  contains

    subroutine GFS_suite_interstitial_2_init ()
    end subroutine GFS_suite_interstitial_2_init

    subroutine GFS_suite_interstitial_2_finalize()
    end subroutine GFS_suite_interstitial_2_finalize
#if 0
!> \section arg_table_GFS_suite_interstitial_2_run Argument Table
!! \htmlinclude GFS_suite_interstitial_2_run.html
!!
#endif
    subroutine GFS_suite_interstitial_2_run (im, levs, lssav, ldiag3d, lsidea, cplflx, flag_cice, shal_cnv, old_monin, mstrat,  &
      do_shoc, imfshalcnv, dtf, xcosz, adjsfcdsw, adjsfcdlw, pgr, ulwsfc_cice, lwhd, htrsw, htrlw, xmu, ctei_rm, work1, work2,  &
      prsi, tgrs, prsl, qgrs_water_vapor, qgrs_cloud_water, cp, hvap, prslk,                                                    &
      suntim, adjsfculw, dlwsfc, ulwsfc, psmean, dt3dt_lw, dt3dt_sw, dt3dt_pbl, dt3dt_dcnv, dt3dt_scnv, dt3dt_mp, ctei_rml,     &
      ctei_r, kinver, errmsg, errflg)

      use machine,               only: kind_phys

      implicit none

      ! interface variables
      integer,              intent(in) :: im, levs, imfshalcnv
      logical,              intent(in) :: lssav, ldiag3d, lsidea, cplflx, shal_cnv, old_monin, mstrat, do_shoc
      real(kind=kind_phys), intent(in) :: dtf, cp, hvap

      logical,              intent(in), dimension(im) :: flag_cice
      real(kind=kind_phys), intent(in), dimension(2) :: ctei_rm
      real(kind=kind_phys), intent(in), dimension(im) :: xcosz, adjsfcdsw, adjsfcdlw, pgr, xmu, ulwsfc_cice, work1, work2
      real(kind=kind_phys), intent(in), dimension(im, levs) :: htrsw, htrlw, tgrs, prsl, qgrs_water_vapor, qgrs_cloud_water, prslk
      real(kind=kind_phys), intent(in), dimension(im, levs+1) :: prsi
      real(kind=kind_phys), intent(in), dimension(im, levs, 6) :: lwhd

      integer,              intent(inout), dimension(im) :: kinver
      real(kind=kind_phys), intent(inout), dimension(im) :: suntim, dlwsfc, ulwsfc, psmean, adjsfculw, ctei_rml, ctei_r
      ! These arrays are only allocated if ldiag3d is .true.
      real(kind=kind_phys), intent(inout), dimension(:,:) :: dt3dt_lw, dt3dt_sw, dt3dt_pbl, dt3dt_dcnv, dt3dt_scnv, dt3dt_mp

      character(len=*),     intent(out) :: errmsg
      integer,              intent(out) :: errflg

      ! local variables
      real(kind=kind_phys), parameter :: czmin   = 0.0001      ! cos(89.994)
      integer :: i, k
      real(kind=kind_phys) :: tem1, tem2, tem, hocp
      logical, dimension(im) :: invrsn
      real(kind=kind_phys), dimension(im) :: tx1, tx2

      real(kind=kind_phys), parameter :: qmin = 1.0d-10

      ! Initialize CCPP error handling variables
      errmsg = ''
      errflg = 0

      hocp = hvap/cp

      if (lssav) then      !  --- ...  accumulate/save output variables

!  --- ...  sunshine duration time is defined as the length of time (in mdl output
!           interval) that solar radiation falling on a plane perpendicular to the
!           direction of the sun >= 120 w/m2

        do i = 1, im
          if ( xcosz(i) >= czmin ) then   ! zenth angle > 89.994 deg
            tem1 = adjsfcdsw(i) / xcosz(i)
            if ( tem1 >= 120.0 ) then
              suntim(i) = suntim(i) + dtf
            endif
          endif
        enddo

!  --- ...  sfc lw fluxes used by atmospheric model are saved for output
        if (cplflx) then
          do i=1,im
            if (flag_cice(i)) adjsfculw(i) = ulwsfc_cice(i)
          enddo
        endif
        do i=1,im
          dlwsfc(i) = dlwsfc(i) +   adjsfcdlw(i)*dtf
          ulwsfc(i) = ulwsfc(i) +   adjsfculw(i)*dtf
          psmean(i) = psmean(i) +   pgr(i)*dtf        ! mean surface pressure
        end do

        if (ldiag3d) then
          if (lsidea) then
            do k=1,levs
              do i=1,im
                dt3dt_lw(i,k) = dt3dt_lw(i,k) + lwhd(i,k,1)*dtf
                dt3dt_sw(i,k) = dt3dt_sw(i,k) + lwhd(i,k,2)*dtf
                dt3dt_pbl(i,k) = dt3dt_pbl(i,k) + lwhd(i,k,3)*dtf
                dt3dt_dcnv(i,k) = dt3dt_dcnv(i,k) + lwhd(i,k,4)*dtf
                dt3dt_scnv(i,k) = dt3dt_scnv(i,k) + lwhd(i,k,5)*dtf
                dt3dt_mp(i,k) = dt3dt_mp(i,k) + lwhd(i,k,6)*dtf
              end do
            end do
          else
            do k=1,levs
              do i=1,im
                dt3dt_lw(i,k) = dt3dt_lw(i,k) + htrlw(i,k)*dtf
                dt3dt_sw(i,k) = dt3dt_sw(i,k) + htrsw(i,k)*dtf*xmu(i)
              enddo
            enddo
          endif
        endif
      endif    ! end if_lssav_block

      do i=1, im
        invrsn(i) = .false.
        tx1(i) = 0.0
        tx2(i) = 10.0
        ctei_r(i) = 10.0
      end do

      if ((((imfshalcnv == 0 .and. shal_cnv) .or. old_monin) .and. mstrat) &
         .or. do_shoc) then
        ctei_rml(:) = ctei_rm(1)*work1(:) + ctei_rm(2)*work2(:)
        do k=1,levs/2
          do i=1,im
            if (prsi(i,1)-prsi(i,k+1) < 0.35*prsi(i,1)       &
                .and. (.not. invrsn(i))) then
              tem = (tgrs(i,k+1) - tgrs(i,k))  &
                  / (prsl(i,k)   - prsl(i,k+1))

              if (((tem > 0.00010) .and. (tx1(i) < 0.0)) .or.  &
                  ((tem-abs(tx1(i)) > 0.0) .and. (tx2(i) < 0.0))) then
                invrsn(i) = .true.

                if (qgrs_water_vapor(i,k) > qgrs_water_vapor(i,k+1)) then
                  tem1 = tgrs(i,k+1) + hocp*max(qgrs_water_vapor(i,k+1),qmin)
                  tem2 = tgrs(i,k)   + hocp*max(qgrs_water_vapor(i,k),qmin)

                  tem1 = tem1 / prslk(i,k+1) - tem2 / prslk(i,k)

!  --- ...  (cp/l)(deltathetae)/(deltatwater) > ctei_rm -> conditon for CTEI
                  ctei_r(i) = (1.0/hocp)*tem1/(qgrs_water_vapor(i,k+1)-qgrs_water_vapor(i,k)  &
                            + qgrs_cloud_water(i,k+1)-qgrs_cloud_water(i,k))
                else
                  ctei_r(i) = 10
                endif

                if ( ctei_rml(i) > ctei_r(i) ) then
                  kinver(i) = k
                else
                  kinver(i) = levs
                endif
              endif

              tx2(i) = tx1(i)
              tx1(i) = tem
            endif
          enddo
        enddo
      endif

    end subroutine GFS_suite_interstitial_2_run

  end module GFS_suite_interstitial_2


  module GFS_suite_stateout_reset

  contains

    subroutine GFS_suite_stateout_reset_init ()
    end subroutine GFS_suite_stateout_reset_init

    subroutine GFS_suite_stateout_reset_finalize()
    end subroutine GFS_suite_stateout_reset_finalize

!> \section arg_table_GFS_suite_stateout_reset_run Argument Table
!! \htmlinclude GFS_suite_stateout_reset_run.html
!!
    subroutine GFS_suite_stateout_reset_run (im, levs, ntrac,        &
                                             tgrs, ugrs, vgrs, qgrs, &
                                             gt0 , gu0 , gv0 , gq0 , &
                                             errmsg, errflg)

      use machine,               only: kind_phys

      implicit none

      ! interface variables
      integer, intent(in) :: im
      integer, intent(in) :: levs
      integer, intent(in) :: ntrac
      real(kind=kind_phys), dimension(im,levs),       intent(in)  :: tgrs, ugrs, vgrs
      real(kind=kind_phys), dimension(im,levs,ntrac), intent(in)  :: qgrs
      real(kind=kind_phys), dimension(im,levs),       intent(out) :: gt0, gu0, gv0
      real(kind=kind_phys), dimension(im,levs,ntrac), intent(out) :: gq0

      character(len=*), intent(out) :: errmsg
      integer,          intent(out) :: errflg

      ! Initialize CCPP error handling variables
      errmsg = ''
      errflg = 0

      gt0(:,:)   = tgrs(:,:)
      gu0(:,:)   = ugrs(:,:)
      gv0(:,:)   = vgrs(:,:)
      gq0(:,:,:) = qgrs(:,:,:)

    end subroutine GFS_suite_stateout_reset_run

  end module GFS_suite_stateout_reset


  module GFS_suite_stateout_update

  contains

    subroutine GFS_suite_stateout_update_init ()
    end subroutine GFS_suite_stateout_update_init

    subroutine GFS_suite_stateout_update_finalize()
    end subroutine GFS_suite_stateout_update_finalize

!> \section arg_table_GFS_suite_stateout_update_run Argument Table
!! \htmlinclude GFS_suite_stateout_update_run.html
!!
    subroutine GFS_suite_stateout_update_run (im, levs, ntrac, dtp,  &
                     tgrs, ugrs, vgrs, qgrs, dudt, dvdt, dtdt, dqdt, &
                     gt0, gu0, gv0, gq0, errmsg, errflg)

      use machine,               only: kind_phys

      implicit none

      ! Interface variables
      integer,              intent(in) :: im
      integer,              intent(in) :: levs
      integer,              intent(in) :: ntrac
      real(kind=kind_phys), intent(in) :: dtp

      real(kind=kind_phys), dimension(im,levs),       intent(in)  :: tgrs, ugrs, vgrs
      real(kind=kind_phys), dimension(im,levs,ntrac), intent(in)  :: qgrs
      real(kind=kind_phys), dimension(im,levs),       intent(in)  :: dudt, dvdt, dtdt
      real(kind=kind_phys), dimension(im,levs,ntrac), intent(in)  :: dqdt
      real(kind=kind_phys), dimension(im,levs),       intent(out) :: gt0, gu0, gv0
      real(kind=kind_phys), dimension(im,levs,ntrac), intent(out) :: gq0

      character(len=*), intent(out) :: errmsg
      integer,          intent(out) :: errflg

      ! Initialize CCPP error handling variables
      errmsg = ''
      errflg = 0

      ! DH* add gw_dXdt terms here
      gt0(:,:)   = tgrs(:,:)   + dtdt(:,:)   * dtp
      gu0(:,:)   = ugrs(:,:)   + dudt(:,:)   * dtp
      gv0(:,:)   = vgrs(:,:)   + dvdt(:,:)   * dtp
      gq0(:,:,:) = qgrs(:,:,:) + dqdt(:,:,:) * dtp

    end subroutine GFS_suite_stateout_update_run

  end module GFS_suite_stateout_update


  module GFS_suite_interstitial_3

  contains

    subroutine GFS_suite_interstitial_3_init ()
    end subroutine GFS_suite_interstitial_3_init

    subroutine GFS_suite_interstitial_3_finalize()
    end subroutine GFS_suite_interstitial_3_finalize

#if 0
!> \section arg_table_GFS_suite_interstitial_3_run Argument Table
!! \htmlinclude GFS_suite_interstitial_3_run.html
!!
#endif
    subroutine GFS_suite_interstitial_3_run (im, levs, nn, cscnv, satmedmf, trans_trac, do_shoc, ltaerosol, ntrac, ntcw,  &
      ntiw, ntclamt, ntrw, ntsw, ntrnc, ntsnc, ntgl, ntgnc, xlat, gq0, imp_physics, imp_physics_mg, imp_physics_zhao_carr,&
      imp_physics_zhao_carr_pdf, imp_physics_gfdl, imp_physics_thompson, imp_physics_wsm6, prsi, prsl, prslk, rhcbot,     &
      rhcpbl, rhctop, rhcmax, islmsk, work1, work2, kpbl, kinver,                                                         &
      clw, rhc, save_qc, save_qi, errmsg, errflg)

      use machine, only: kind_phys

      implicit none

      ! interface variables
      integer,                                          intent(in) :: im, levs, nn, ntrac, ntcw, ntiw, ntclamt, ntrw,     &
        ntsw, ntrnc, ntsnc, ntgl, ntgnc, imp_physics, imp_physics_mg, imp_physics_zhao_carr, imp_physics_zhao_carr_pdf,   &
        imp_physics_gfdl, imp_physics_thompson, imp_physics_wsm6
      integer, dimension(im),                           intent(in) :: islmsk, kpbl, kinver
      logical,                                          intent(in) :: cscnv, satmedmf, trans_trac, do_shoc, ltaerosol

      real(kind=kind_phys),                             intent(in) :: rhcbot, rhcmax, rhcpbl, rhctop
      real(kind=kind_phys), dimension(im),              intent(in) :: work1, work2
      real(kind=kind_phys), dimension(im, levs),        intent(in) :: prsl, prslk
      real(kind=kind_phys), dimension(im, levs+1),      intent(in) :: prsi
      real(kind=kind_phys), dimension(im),              intent(in) :: xlat
      real(kind=kind_phys), dimension(im, levs, ntrac), intent(in) :: gq0

      real(kind=kind_phys), dimension(im, levs),      intent(inout) :: rhc, save_qc
      ! save_qi is not allocated for Zhao-Carr MP
      real(kind=kind_phys), dimension(:, :),          intent(inout) :: save_qi
      real(kind=kind_phys), dimension(im, levs, nn),  intent(inout) :: clw

      character(len=*), intent(out) :: errmsg
      integer, intent(out) :: errflg

      ! local variables
      integer :: i,k,n,tracers,kk
      real(kind=kind_phys) :: tem, tem1, tem2
      real(kind=kind_phys), dimension(im) :: tx1, tx2, tx3, tx4

      !real(kind=kind_phys),parameter :: slope_mg = 0.02, slope_upmg = 0.04,  &
      !                   turnrhcrit = 0.900, turnrhcrit_upper = 0.150
      ! in the following inverse of slope_mg and slope_upmg are specified
      real(kind=kind_phys),parameter :: slope_mg   = 50.0_kind_phys,   &
                                        slope_upmg = 25.0_kind_phys

      ! Initialize CCPP error handling variables
      errmsg = ''
      errflg = 0

      !GF* The following section (initializing convective variables) is already executed in GFS_typedefs%interstitial_phys_reset
      ! do k=1,levs
      !   do i=1,im
      !     clw(i,k,1) = 0.0
      !     clw(i,k,2) = -999.9
      !   enddo
      ! enddo
      ! if (Model%imfdeepcnv >= 0 .or.  Model%imfshalcnv > 0  .or. &
      !     (Model%npdf3d == 3     .and. Model%num_p3d   == 4) .or. &
      !     (Model%npdf3d == 0     .and. Model%ncnvcld3d == 1) ) then
      !   do k=1,levs
      !     do i=1,im
      !       cnvc(i,k)  = 0.0
      !       cnvw(i,k)  = 0.0
      !     enddo
      !   enddo
      ! endif
      ! if(imp_physics == 8) then
      !   if(Model%ltaerosol) then
      !     ice00 (:,:) = 0.0
      !     liq0  (:,:) = 0.0
      !   else
      !     ice00 (:,:) = 0.0
      !   endif
      ! endif
      !*GF

      if (cscnv .or. satmedmf .or. trans_trac ) then
        tracers = 2
        do n=2,ntrac
          if ( n /= ntcw  .and. n /= ntiw  .and. n /= ntclamt .and. &
               n /= ntrw  .and. n /= ntsw  .and. n /= ntrnc   .and. &
               n /= ntsnc .and. n /= ntgl  .and. n /= ntgnc) then
            tracers = tracers + 1
            do k=1,levs
              do i=1,im
                clw(i,k,tracers) = gq0(i,k,n)
              enddo
            enddo
          endif
        enddo
      endif ! end if_ras or cfscnv or samf

      if (ntcw > 0) then
        if (imp_physics == imp_physics_mg .and. rhcpbl < 0.5) then ! compute rhc for GMAO macro physics cloud pdf
          do i=1,im
            tx1(i) = 1.0 / prsi(i,1)
            tx2(i) = 1.0 - rhcmax*work1(i)-rhcbot*work2(i)

            kk     = min(kinver(i), max(2,kpbl(i)))
            tx3(i) = prsi(i,kk)*tx1(i)
            tx4(i) = rhcpbl - rhctop*abs(cos(xlat(i)))
          enddo
          do k = 1, levs
            do i = 1, im
              tem  = prsl(i,k) * tx1(i)
              tem1 = min(max((tem-tx3(i))*slope_mg, -20.0), 20.0)
              ! Using rhcpbl and rhctop from the namelist instead of 0.3 and 0.2
              ! and rhcbot represents pbl top critical relative humidity
              tem2 = min(max((tx4(i)-tem)*slope_upmg, -20.0), 20.0) ! Anning
              if (islmsk(i) > 0) then
                tem1 = 1.0 / (1.0+exp(tem1+tem1))
              else
                tem1 = 2.0 / (1.0+exp(tem1+tem1))
              endif
              tem2 = 1.0 / (1.0+exp(tem2))

              rhc(i,k) = min(rhcmax, max(0.7, 1.0-tx2(i)*tem1*tem2))
            enddo
          enddo
        else
          do k=1,levs
            do i=1,im
              kk = max(10,kpbl(i))
              if (k < kk) then
                tem    = rhcbot - (rhcbot-rhcpbl) * (1.0-prslk(i,k)) / (1.0-prslk(i,kk))
              else
                tem    = rhcpbl - (rhcpbl-rhctop) * (prslk(i,kk)-prslk(i,k)) / prslk(i,kk)
              endif
              tem      = rhcmax * work1(i) + tem * work2(i)
              rhc(i,k) = max(0.0, min(1.0,tem))
            enddo
          enddo
        endif
      endif

      if (imp_physics == imp_physics_zhao_carr .or. imp_physics == imp_physics_zhao_carr_pdf) then   ! zhao-carr microphysics
        !GF* move to GFS_MP_generic_pre (from gscond/precpd)
        ! do i=1,im
        !   psautco_l(i) = Model%psautco(1)*work1(i) + Model%psautco(2)*work2(i)
        !   prautco_l(i) = Model%prautco(1)*work1(i) + Model%prautco(2)*work2(i)
        ! enddo
        !*GF
        do k=1,levs
          do i=1,im
            clw(i,k,1) = gq0(i,k,ntcw)
          enddo
        enddo
      elseif (imp_physics == imp_physics_gfdl) then
        clw(1:im,:,1) = gq0(1:im,:,ntcw)
      elseif (imp_physics == imp_physics_thompson) then
        do k=1,levs
          do i=1,im
            clw(i,k,1) = gq0(i,k,ntiw)                    ! ice
            clw(i,k,2) = gq0(i,k,ntcw)                    ! water
          enddo
        enddo
        if(ltaerosol) then
          save_qi(:,:) = clw(:,:,1)
          save_qc(:,:)  = clw(:,:,2)
        else
          save_qi(:,:) = clw(:,:,1)
        endif
      elseif (imp_physics == imp_physics_wsm6 .or. imp_physics == imp_physics_mg) then
        do k=1,levs
          do i=1,im
            clw(i,k,1) = gq0(i,k,ntiw)                    ! ice
            clw(i,k,2) = gq0(i,k,ntcw)                    ! water
          enddo
        enddo
      else       ! if_ntcw
        !GF* never executed unless imp_physics = imp_physics_zhao_carr or imp_physics_zhao_carr_pdf
        ! do i=1,im
        !   psautco_l(i) = Model%psautco(1)*work1(i) + Model%psautco(2)*work2(i)
        !   prautco_l(i) = Model%prautco(1)*work1(i) + Model%prautco(2)*work2(i)
        ! enddo
        !*GF
        rhc(:,:) = 1.0
      endif   ! end if_ntcw

    end subroutine GFS_suite_interstitial_3_run

  end module GFS_suite_interstitial_3

  module GFS_suite_interstitial_4

  contains

    subroutine GFS_suite_interstitial_4_init ()
    end subroutine GFS_suite_interstitial_4_init

    subroutine GFS_suite_interstitial_4_finalize()
    end subroutine GFS_suite_interstitial_4_finalize

!> \section arg_table_GFS_suite_interstitial_4_run Argument Table
!! \htmlinclude GFS_suite_interstitial_4_run.html
!!
    subroutine GFS_suite_interstitial_4_run (im, levs, ltaerosol, lgocart, cplchm, tracers_total, ntrac, ntcw, ntiw, ntclamt, &
      ntrw, ntsw, ntrnc, ntsnc, ntgl, ntgnc, ntlnc, ntinc, nn, imp_physics, imp_physics_gfdl, imp_physics_thompson,           &
      imp_physics_zhao_carr, imp_physics_zhao_carr_pdf, dtf, save_qc, save_qi, con_pi,                                        &
      gq0, clw, dqdti, errmsg, errflg)

      use machine,               only: kind_phys

      implicit none

      ! interface variables

      integer,                                  intent(in) :: im, levs, tracers_total, ntrac, ntcw, ntiw, ntclamt, ntrw,  &
        ntsw, ntrnc, ntsnc, ntgl, ntgnc, ntlnc, ntinc, nn, imp_physics, imp_physics_gfdl, imp_physics_thompson,           &
        imp_physics_zhao_carr, imp_physics_zhao_carr_pdf

      logical,                                  intent(in) :: ltaerosol, lgocart, cplchm

      real(kind=kind_phys),                     intent(in) :: con_pi, dtf
      real(kind=kind_phys), dimension(im,levs), intent(in) :: save_qc
      ! save_qi is not allocated for Zhao-Carr MP
      real(kind=kind_phys), dimension(:, :),    intent(in) :: save_qi

      real(kind=kind_phys), dimension(im,levs,ntrac), intent(inout) :: gq0
      real(kind=kind_phys), dimension(im,levs,nn),    intent(inout) :: clw
      ! dqdti may not be allocated
      real(kind=kind_phys), dimension(:,:),           intent(inout) :: dqdti

      character(len=*), intent(out) :: errmsg
      integer,          intent(out) :: errflg

      ! local variables
      integer :: i,k,n,tracers

      real(kind=kind_phys) :: liqm, icem

      liqm = 4./3.*con_pi*1.e-12
      icem = 4./3.*con_pi*3.2768*1.e-14*890.

      ! Initialize CCPP error handling variables
      errmsg = ''
      errflg = 0

!  --- update the tracers due to deep & shallow cumulus convective transport
!           (except for suspended water and ice)

      if (tracers_total > 0) then
        tracers = 2
        do n=2,ntrac
!         if ( n /= ntcw .and. n /= ntiw .and. n /= ntclamt) then
          if ( n /= ntcw  .and. n /= ntiw  .and. n /= ntclamt .and. &
               n /= ntrw  .and. n /= ntsw  .and. n /= ntrnc   .and. &
               n /= ntsnc .and. n /= ntgl  .and. n /= ntgnc ) then
              tracers = tracers + 1
            do k=1,levs
              do i=1,im
                gq0(i,k,n) = clw(i,k,tracers)
              enddo
            enddo
          endif
        enddo
      endif

      if (ntcw > 0) then

!  for microphysics
        if (imp_physics == imp_physics_zhao_carr     .or. &
            imp_physics == imp_physics_zhao_carr_pdf .or. &
            imp_physics == imp_physics_gfdl) then
           gq0(1:im,:,ntcw) = clw(1:im,:,1) + clw(1:im,:,2)
        elseif (ntiw > 0) then
          do k=1,levs
            do i=1,im
              gq0(i,k,ntiw) = clw(i,k,1)                     ! ice
              gq0(i,k,ntcw) = clw(i,k,2)                     ! water
            enddo
          enddo
          if (imp_physics == imp_physics_thompson) then
            if (ltaerosol) then
              do k=1,levs
                do i=1,im
                  gq0(i,k,ntlnc) = gq0(i,k,ntlnc)  &
                           +  max(0.0, (clw(i,k,2)-save_qc(i,k))) / liqm
                  gq0(i,k,ntinc) = gq0(i,k,ntinc)  &
                           +  max(0.0, (clw(i,k,1)-save_qi(i,k))) / icem
                enddo
              enddo
            else
              do k=1,levs
                do i=1,im
                  gq0(i,k,ntinc) = gq0(i,k,ntinc)  &
                           +  max(0.0, (clw(i,k,1)-save_qi(i,k))) / icem
                enddo
              enddo
            endif
          endif
        else
          do k=1,levs
            do i=1,im
              gq0(i,k,ntcw) = clw(i,k,1) + clw(i,k,2)
            enddo
          enddo
        endif   ! end if_ntiw
      else
        do k=1,levs
          do i=1,im
            clw(i,k,1) = clw(i,k,1) + clw(i,k,2)
          enddo
        enddo
      endif   ! end if_ntcw

! dqdt_v : instaneous moisture tendency (kg/kg/sec)
      if (lgocart .or. cplchm) then
        do k=1,levs
          do i=1,im
            dqdti(i,k) = dqdti(i,k) * (1.0 / dtf)
          enddo
        enddo
      endif

    end subroutine GFS_suite_interstitial_4_run

  end module GFS_suite_interstitial_4
