C
C	$Id: stseti.f,v 1.2 1993-02-25 19:32:17 dbrown Exp $
C
C
C-----------------------------------------------------------------------
C
      SUBROUTINE STSETI (CNM,IVL)
C
      CHARACTER*(*) CNM
C
C This subroutine is called to give a specified integer value to a
C specified parameter.
C
C CNM is the name of the parameter whose value is to be set.
C
C IVL is an integer variable containing the new value of the parameter.
C
C The real work is done by STSETR
C
C Float the integer value and pass it on to STSETR.
C
      RVL=REAL(IVL)
      CALL STSETR (CNM,RVL)
C
C Done.
C
      RETURN
C
      END
