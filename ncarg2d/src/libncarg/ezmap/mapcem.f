C
C $Id: mapcem.f,v 1.5 1998-04-16 20:20:56 kennison Exp $
C
      SUBROUTINE MAPCEM (IEM1,IEM2,IERR,IFLG)
C
      CHARACTER*(*) IEM1,IEM2
C
C MAPCEM is called to do a call to SETER when the error message to be
C printed is in two parts which need to be concatenated.  FORTRAN-77
C rules make it necessary to concatenate the two parts of the message
C into a local character variable.
C
      CHARACTER*100 IEMC
C
      IEMC=IEM1//IEM2
      CALL SETER (IEMC,IERR,IFLG)
C
      RETURN
C
      END
