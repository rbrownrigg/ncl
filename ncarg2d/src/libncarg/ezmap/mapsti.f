C
C $Id: mapsti.f,v 1.14 2001-05-18 22:49:38 kennison Exp $
C
C                Copyright (C)  2000
C        University Corporation for Atmospheric Research
C                All Rights Reserved
C
C This file is free software; you can redistribute it and/or modify
C it under the terms of the GNU General Public License as published
C by the Free Software Foundation; either version 2 of the License, or
C (at your option) any later version.
C
C This software is distributed in the hope that it will be useful, but
C WITHOUT ANY WARRANTY; without even the implied warranty of
C MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
C General Public License for more details.
C
C You should have received a copy of the GNU General Public License
C along with this software; if not, write to the Free Software
C Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
C USA.
C
      SUBROUTINE MAPSTI (WHCH,IVAL)
C
      CHARACTER*(*) WHCH
C
C Declare required common blocks.  See MAPBD for descriptions of these
C common blocks and the variables in them.
C
      COMMON /MAPCM2/ UMIN,UMAX,VMIN,VMAX,UCEN,VCEN,URNG,VRNG,BLAM,SLAM,
     +                BLOM,SLOM,ISSL,PEPS
      SAVE   /MAPCM2/
C
      COMMON /MAPCM4/ INTF,JPRJ,PHIA,PHIO,ROTA,ILTS,PLA1,PLA2,PLA3,PLA4,
     +                PLB1,PLB2,PLB3,PLB4,PLTR,GRID,IDSH,IDOT,LBLF,PRMF,
     +                ELPF,XLOW,XROW,YBOW,YTOW,IDTL,GRDR,SRCH,ILCW,GRLA,
     +                GRLO,GRPO
      LOGICAL         INTF,LBLF,PRMF,ELPF
      SAVE   /MAPCM4/
C
      COMMON /MAPCM7/ ULOW,UROW,VBOW,VTOW
      SAVE   /MAPCM7/
C
      COMMON /MAPCMA/ DPLT,DDTS,DSCA,DPSQ,DSSQ,DBTD,DATL
      SAVE   /MAPCMA/
C
      COMMON /MAPCMC/ IGI1,IGI2,NOVS,XCRA(100),YCRA(100),NCRA
      SAVE   /MAPCMC/
C
      COMMON /MAPCMQ/ ICIN(8)
      SAVE   /MAPCMQ/
C
      COMMON /MAPSAT/ SALT,SSMO,SRSS,ALFA,BETA,RSNA,RCSA,RSNB,RCSB
      SAVE   /MAPSAT/
C
      COMMON /MAPDPS/ DSNA,DCSA,DSNB,DCSB
      DOUBLE PRECISION DSNA,DCSA,DSNB,DCSB
      SAVE   /MAPDPS/
C
      COMMON /MAPRGD/ ICOL(5),ICSF(5),NILN,NILT
      SAVE   /MAPRGD/
C
      IF (ICFELL('MAPSTI - UNCLEARED PRIOR ERROR',1).NE.0) RETURN
C
      IF      (WHCH(1:2).EQ.'C1'.OR.WHCH(1:2).EQ.'c1') THEN
        ICIN(1)=IVAL
      ELSE IF (WHCH(1:2).EQ.'C2'.OR.WHCH(1:2).EQ.'c2') THEN
        ICIN(2)=IVAL
      ELSE IF (WHCH(1:2).EQ.'C3'.OR.WHCH(1:2).EQ.'c3') THEN
        ICIN(3)=IVAL
      ELSE IF (WHCH(1:2).EQ.'C4'.OR.WHCH(1:2).EQ.'c4') THEN
        ICIN(4)=IVAL
      ELSE IF (WHCH(1:2).EQ.'C5'.OR.WHCH(1:2).EQ.'c5') THEN
        ICIN(5)=IVAL
      ELSE IF (WHCH(1:2).EQ.'C6'.OR.WHCH(1:2).EQ.'c6') THEN
        ICIN(6)=IVAL
      ELSE IF (WHCH(1:2).EQ.'C7'.OR.WHCH(1:2).EQ.'c7') THEN
        ICIN(7)=IVAL
      ELSE IF (WHCH(1:2).EQ.'C8'.OR.WHCH(1:2).EQ.'c8') THEN
        ICIN(8)=IVAL
      ELSE IF (WHCH(1:2).EQ.'DA'.OR.WHCH(1:2).EQ.'da') THEN
        IDSH=IVAL
      ELSE IF (WHCH(1:2).EQ.'DD'.OR.WHCH(1:2).EQ.'dd') THEN
        DDTS=IVAL
        DBTD=DDTS/DSCA
      ELSE IF (WHCH(1:2).EQ.'DL'.OR.WHCH(1:2).EQ.'dl') THEN
        IDTL=IVAL
      ELSE IF (WHCH(1:2).EQ.'DO'.OR.WHCH(1:2).EQ.'do') THEN
        IDOT=IVAL
      ELSE IF (WHCH(1:2).EQ.'EL'.OR.WHCH(1:2).EQ.'el') THEN
        ELPF=IVAL.NE.0
      ELSE IF (WHCH(1:2).EQ.'GN'.OR.WHCH(1:2).EQ.'gn') THEN
        GRLO=IVAL
      ELSE IF (WHCH(1:2).EQ.'GP'.OR.WHCH(1:2).EQ.'gp') THEN
        GRPO=MAX(0,MIN(90360,IVAL))
      ELSE IF (WHCH(1:2).EQ.'GR'.OR.WHCH(1:2).EQ.'gr') THEN
        GRID=IVAL
      ELSE IF (WHCH(1:2).EQ.'GT'.OR.WHCH(1:2).EQ.'gt') THEN
        GRLA=IVAL
      ELSE IF (WHCH(1:2).EQ.'G1'.OR.WHCH(1:2).EQ.'g1') THEN
        IGI1=IVAL
      ELSE IF (WHCH(1:2).EQ.'G2'.OR.WHCH(1:2).EQ.'g2') THEN
        IGI2=IVAL
      ELSE IF (WHCH(1:2).EQ.'II'.OR.WHCH(1:2).EQ.'ii') THEN
        NILN=MAX(1,MIN(256,MOD(IVAL,1000)))
        NILT=MAX(1,MIN(256,IVAL/1000))
      ELSE IF (WHCH(1:2).EQ.'LA'.OR.WHCH(1:2).EQ.'la') THEN
        LBLF=IVAL.NE.0
      ELSE IF (WHCH(1:2).EQ.'LS'.OR.WHCH(1:2).EQ.'ls') THEN
        ILCW=IVAL
      ELSE IF (WHCH(1:2).EQ.'MV'.OR.WHCH(1:2).EQ.'mv') THEN
        DPLT=IVAL
        DPSQ=DPLT*DPLT
      ELSE IF (WHCH(1:2).EQ.'PE'.OR.WHCH(1:2).EQ.'pe') THEN
        PRMF=IVAL.NE.0
      ELSE IF (WHCH(1:2).EQ.'RE'.OR.WHCH(1:2).EQ.'re') THEN
        PLTR=IVAL
        INTF=.TRUE.
      ELSE IF (WHCH(1:2).EQ.'SA'.OR.WHCH(1:2).EQ.'sa') THEN
        SALT=IVAL
        IF (ABS(SALT).GT.1.) THEN
          SSMO=SALT*SALT-1.
          SRSS=SQRT(SSMO)
        END IF
        INTF=.TRUE.
      ELSE IF (WHCH(1:2).EQ.'S1'.OR.WHCH(1:2).EQ.'s1') THEN
        ALFA=ABS(IVAL)
        DSNA=SIN(DBLE(.017453292519943*ALFA))
        RSNA=REAL(DSNA)
        DCSA=COS(DBLE(.017453292519943*ALFA))
        RCSA=REAL(DCSA)
        INTF=.TRUE.
      ELSE IF (WHCH(1:2).EQ.'S2'.OR.WHCH(1:2).EQ.'s2') THEN
        BETA=IVAL
        DSNB=SIN(DBLE(.017453292519943*BETA))
        RSNB=REAL(DSNB)
        DCSB=COS(DBLE(.017453292519943*BETA))
        RCSB=REAL(DCSB)
        INTF=.TRUE.
      ELSE IF (WHCH(1:2).EQ.'VS'.OR.WHCH(1:2).EQ.'vs') THEN
        NOVS=IVAL
      ELSE
        GO TO 901
      END IF
C
C Done.
C
      RETURN
C
C Error exits.
C
  901 CALL MAPCEM ('MAPSTI - UNKNOWN PARAMETER NAME ',WHCH,2,1)
      RETURN
C
      END
