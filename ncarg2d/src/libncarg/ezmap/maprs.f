C
C $Id: maprs.f,v 1.5 1998-04-16 20:21:15 kennison Exp $
C
      SUBROUTINE MAPRS
C
C Declare required common blocks.  See MAPBD for descriptions of these
C common blocks and the variables in them.
C
      COMMON /MAPCM2/ UMIN,UMAX,VMIN,VMAX,UEPS,VEPS,UCEN,VCEN,URNG,VRNG,
     +                BLAM,SLAM,BLOM,SLOM,ISSL
      SAVE /MAPCM2/
      COMMON /MAPCM7/ ULOW,UROW,VBOW,VTOW
      SAVE /MAPCM7/
C
C Check for an uncleared prior error.
C
      IF (ICFELL('MAPRS - UNCLEARED PRIOR ERROR',1).NE.0) RETURN
C
C Restore the SET call.
C
      CALL SET (ULOW,UROW,VBOW,VTOW,UMIN,UMAX,VMIN,VMAX,1)
      IF (ICFELL('MAPRS',2).NE.0) RETURN
C
C Done.
C
      RETURN
C
      END
