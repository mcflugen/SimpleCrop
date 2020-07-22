module WeatherCLI
    implicit none
contains
    !***********************************************************************
    !***********************************************************************
    !     SUBROUTINE WEATHR - Reads daily weather data from file
    !***********************************************************************

    !     LIST OF VARIABLES

    !     DATE = date of weather record (YYDDD)
    !     DYN  = dynamic control variable
    !     PAR  = photosynthetically active radiation (MJ/m2/d)
    !     RAIN = daily rainfall (mm)
    !     SRAD = daily solar radiation (MJ/m2/d)
    !     TMAX = daily maximum temperature (Celsius)
    !     TMIN = daily minimum temperature (Celsius)

    !**********************************************************************
    SUBROUTINE WEATHR(SRAD, TMAX, TMIN, RAIN, PAR, DYN)

        !-----------------------------------------------------------------------
        IMPLICIT NONE
        SAVE
        REAL :: SRAD, TMAX, TMIN, RAIN, PAR
        INTEGER :: DATE
        CHARACTER(10) :: DYN

        !************************************************************************
        !************************************************************************
        !     INITIALIZATION
        !************************************************************************
        IF (INDEX(DYN, 'INITIAL') /= 0) THEN
            !************************************************************************
            OPEN (4, FILE = 'data/weather.inp', STATUS = 'UNKNOWN')

            !************************************************************************
            !************************************************************************
            !     RATE CALCULATIONS
            !************************************************************************
        ELSEIF (INDEX(DYN, 'RATE') /= 0) THEN
            !************************************************************************
            !     Loop to compute data for one year. Climatic data of the year 1987,
            !     for Gainesville, Florida, were used as verification of the module.

            READ(4, 20) DATE, SRAD, TMAX, TMIN, RAIN, PAR
            20 FORMAT(I5, 2X, F4.1, 2X, F4.1, 2X, F4.1, F6.1, 14X, F4.1)

            PAR = 0.5 * SRAD   ! Par is defined as 50% of SRAD

            !************************************************************************
            !************************************************************************
        ELSEIF (INDEX(DYN, 'CLOSE') /= 0) THEN
            !************************************************************************
            CLOSE(4)

            !************************************************************************
            !************************************************************************
            !     End of dynamic 'IF' construct
            !************************************************************************
        ENDIF
        !************************************************************************
        RETURN
    END SUBROUTINE WEATHR
    !***********************************************************************
    !***********************************************************************
end module WeatherCLI
