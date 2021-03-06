C
C	$Id: plgcls.f,v 1.4 2008-07-27 12:23:44 haley Exp $
C                                                                      
C			     Copyright (C)  1997
C	     University Corporation for Atmospheric Research
C			     All Rights Reserved
C
C The use of this Software is governed by a License Agreement.
C

      SUBROUTINE PLGCLS(WHICH, IOS, STATUS)
C
C  Process the PLOYGON keywords.
C
C
C  INPUT
C       WHICH   --  the encoded path flags.
C
C  OUTPUT
C       IOS     --  I/O status flag.  This flag is valid only
C                   if STATUS indicates an error.
C       STATUS  --  The error status as defined in COMMON CAPERR.
C
C
      COMMON /PARTB1/ PART1, KEYSEP, KEYTER, FRMCOM
      COMMON /PARTB2/ PART2, PART3, PART4, PART5, CTSTR, CTLOC
C
C  THE NUMBER OF WORDS IN THE SEARCH PATH MUST BE BIG ENOUGH TO HOLD
C       THE NUMBER OF BITS PER PATH TIMES THE NUMBER OF LEVELS
C
      INTEGER WHSIZE
      PARAMETER (WHSIZE=20)
C
      INTEGER PARTSZ, OTHSZ, NTABLE
      PARAMETER(PARTSZ=3000, OTHSZ=150, NTABLE=50)
      CHARACTER*1 KEYSEP,KEYTER
      CHARACTER*1 FRMCOM(2)
      INTEGER PART2(OTHSZ), PART3(OTHSZ), PART4(NTABLE), PART5(NTABLE*2)
      CHARACTER*1 PART1(PARTSZ)
      INTEGER CTSTR, CTLOC
      COMMON /CAPERR/ ALLOK, EOFFL, INTERR, MAXINT, PLBERR, PMBERR,
     1                FABERR, TXBERR, FLTERR, MAXFLT, NOTINT, SIZERR,
     2                UNDASC, DEVERR, DOCERR, TBLERR , STSZER, ENTERR,
     3                TABERR, TABSER, PRSFIL
      INTEGER ALLOK, EOFFL, INTERR, MAXINT, PLBERR, PMBERR,
     1        FABERR, TXBERR, FLTERR, MAXFLT, NOTINT, SIZERR, UNDASC,
     2        DEVERR, DOCERR, STSZER, ENTERR, TABERR, TABSER, TBLERR,
     3        PRSFIL
      COMMON /CAPPLG/ PCSSTR, PCSSIZ, PCTSTR, PCTSIZ, PLSSTR,
     1                PLSSIZ, PLTSTR, PLTSIZ, PBSSTR, PBSSIZ,
     2                PBTSTR, PBTSIZ, PHATSP, PMAXPT, PPSSTR,
     3                PPSSIZ, PPTSTR, PPTSIZ, PLGSIM, PSIMSP,
     4                PSIMTR
      INTEGER         PCSMAX, PCTMAX, PLSMAX, PLTMAX, PBSMAX,
     1                PBTMAX, PPSMAX, PPTMAX
      PARAMETER   (PCSMAX=20, PCTMAX=15, PLSMAX=40, PLTMAX=20)
      PARAMETER   (PBSMAX=30, PBTMAX=15, PPSMAX=20, PPTMAX=20)
      INTEGER         PCSSTR(PCSMAX), PCSSIZ, PCTSTR(PCTMAX), PCTSIZ,
     1                PLSSTR(PLSMAX), PLSSIZ, PLTSTR(PLTMAX), PLTSIZ,
     2                PBSSTR(PBSMAX), PBSSIZ, PBTSTR(PBTMAX), PBTSIZ,
     3                PHATSP, PMAXPT, PPSSTR(PPSMAX), PPSSIZ,
     4                PPTSTR(PPTMAX), PPTSIZ, PSIMSP, PSIMTR
      LOGICAL         PLGSIM
      INTEGER         LENPLG
      PARAMETER   (LENPLG=PCSMAX+1+PCTMAX+1+PLSMAX+1+PLTMAX+1+
     1                    PBSMAX+1+PBTMAX+1+1+1+PPSMAX+1+PPTMAX+
     2                    1+1+1+1)
C
      INTEGER WHICH(WHSIZE), IOS, STATUS
      INTEGER ROW2, ROW3, ROW4
C
C  Branch to the proper level 2 processing.
C
      ROW2 = WHICH(2)
      ROW3 = WHICH(3)
      ROW4 = WHICH(4)
C
C  POLYGON class processing.
C
C  ROW2   ROW3  ROW4  Keyword
C  ----   ----  ----  ---------------------------------------
C   1     1     1    POLYGON_COLOR_INSTRUCTION_START
C   1     1     2    POLYGON_COLOR_INSTRUCTION_TERMINATOR
C   3     1          POLYGON_INSTRUCTION_START
C   3     2          POLYGON_INSTRUCTION_TERMINATOR
C   4                POLYGON_SIMULATE
C   5     1     1    POLYGON_BACKGROUND_COLOR_INSTRUCTION_START
C   5     1     2    POLYGON_BACKGROUND_COLOR_INSTRUCTION_TERMINATOR
C   6     1          POLYGON_POINT_START
C   6     2          POLYGON_POINT_TERMINATOR
C   8                POLYGON_SIMULATION_SPACING
C   9                POLYGON_SIMULATION_TRUNCATION
C  10                POLYGON_MAXIMUM_POINTS
C  11                POLYGON_HATCH_SPACING
C
C
      IF (ROW2.EQ.1 .AND. ROW3.EQ.1) THEN
        IF (ROW4 .EQ. 1) THEN
                CALL GTSTR(PCSSTR, PCSMAX, PCSSIZ, IOS, STATUS)
        ELSE IF (ROW4 .EQ. 2) THEN
                CALL GTSTR(PCTSTR, PCTMAX, PCTSIZ, IOS, STATUS)
        END IF
      ELSE IF (ROW2.EQ.3 .AND. ROW3.EQ.1) THEN
                CALL GTSTR(PLSSTR, PLSMAX, PLSSIZ, IOS, STATUS)
      ELSE IF (ROW2.EQ.3 .AND. ROW3.EQ.2) THEN
                CALL GTSTR(PLTSTR, PLTMAX, PLTSIZ, IOS, STATUS)
      ELSE IF (ROW2.EQ.4) THEN
                CALL GTLOG(PLGSIM, 1, DUMMY, IOS, STATUS)
      ELSE IF (ROW2.EQ.5 .AND. ROW3.EQ.1) THEN
        IF (ROW4 .EQ. 1) THEN
                CALL GTSTR(PBSSTR, PBSMAX, PBSSIZ, IOS, STATUS)
        ELSE IF (ROW4 .EQ. 2) THEN
                CALL GTSTR(PBTSTR, PBTMAX, PBTSIZ, IOS, STATUS)
        END IF
      ELSE IF (ROW2.EQ.6 .AND. ROW3.EQ.1) THEN
                CALL GTSTR(PPSSTR, PPSMAX, PPSSIZ, IOS, STATUS)
      ELSE IF (ROW2.EQ.6 .AND. ROW3.EQ.2) THEN
                CALL GTSTR(PPTSTR, PPTMAX, PPTSIZ, IOS, STATUS)
      ELSE IF (ROW2.EQ.8) THEN
                CALL GTINT(PSIMSP, 1, DUMMY, IOS, STATUS)
      ELSE IF (ROW2.EQ.9) THEN
                CALL GTINT(PSIMTR, 1, DUMMY, IOS, STATUS)
      ELSE IF (ROW2.EQ.10) THEN
                CALL GTINT(PMAXPT, 1, DUMMY, IOS, STATUS)
      ELSE IF (ROW2.EQ.11) THEN
                CALL GTINT(PHATSP, 1, DUMMY, IOS, STATUS)
      END IF
C
      RETURN
      END
