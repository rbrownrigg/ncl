C NCLFORTSTART
      subroutine dh2sdrv(dati,dato,hya,hyb,p0,sigi,sigo
     +                  ,intyp,psfc,nlvi,nlvo)
      implicit none

      
      integer  intyp,nlvi,nlvo
      double precision  dati(nlvi), dato(nlvo),p0, psfc
     +                 ,hya(nlvo),hyb(nlvo)
     +                 ,sigi(nlvi),sigo(nlvo)
C NCLEND

c NCL:  xHybrid = sigma2hybrid(xSigma,sigma,hya,hyb,P0,psfc,intyp)

c          sigo must be created in the interface. Need only be done once.
c          It is the same size as hya/hyb.

C         ----- ORIGINAL FUNCTION DOCUMENTATION --------------
C****     THIS ROUTINE INTERPLOATES DATA TO MODEL HYBRID
C****     COORDINATES FROM SIGMA COORDINATES USING SIGMA SURFACES. 
C****     THE TYPE OF INTERPOLATION IS CURRENTLY A VARIANT OF
C****     TRANSFORMED SIGMA COORDINATES WITH THE  INTERPOLATION TYPE
C****     SPECIFIED BY INTYP.  ALL HYBRID COORDINATE VALUES ARE 
C****     TRANSFORMED TO SIGMA VALUES. WHERE THE
C****     FORMULA FOR THE PRESSURE OF A HYBRID SURFACE IS;
C****          P(K) = HBCOFA(LEVH,K)*P0 + HBCOFB(LEVH,K)*PSFC
C****     THE RELATIONSHIP OF PRESSURE AND SIGMA IS;
C****          SIG(K) = P(K)/PSFC
C****     HENCE,
C****          SIG(K) = HBCOFA(K)*P0/PSFC + HBCOFB(K)
C****     WHERE,
C****          HBCOFA - IS THE "A" OR PRESSURE HYBRID COEF
C****          LEVH   - IS THE LAYER SURFACE (INTERFACE=1 MIDPOINT=2)
C****          P0     - IS THE BASE PRESSURE (PA)
C****          K      - THE LEVEL INDEX (RUNNING FROM TOP TO BOTTOM)
C****          HBCOFB - IS THE "B" OR SIGMA COEFICIENT
C****          P(K)   - IS THE PRESSURE OF A HYBRID SURFACE (PA).
C****          PSFC   - IS THE SURFACE PRESSURE IN PASCALS

C****                   (MB = .01D0*PASCALS   : PA = 100*MB/hPA)

C****        SIGI    - 1 DIMENSIONAL ARRAY CONTAINING MODEL SIGMA
C****                  SURFACES.  ARRAY IS NLVI.  
C****                  AS WITH THE HYBRID COEFFICIENTS THEY ARE 
C****                  ORDERED FROM TOP TO BOTTOM.


      integer n

c convert hybrid to sigma. P0 and psfc are in the same units.
      
      do n=1,nlvo
         sigo(n) = (hya(n)*P0)/psfc +hyb(n)
      end do

      call ds2hbd (dati,dato,intyp,sigi,sigo,nlvi,nlvo)

      return
      end
c ------------
      subroutine ds2hbd(fkr,fkm,intyp,siglevi,siglevo,nli,nlo)
      implicit none
C
C****     THIS ROUTINE INTERP. A VERTICAL COLUMN OF SIGMA
C****     COORDINATE DATA TO HYBRID COORDINATES.
C
C****     ON INPUT-
C****        FKR     - INPUT DATA ON SIGMA COORDINATES
C****        FKM     - OUTPUT DATA  ON HYBRID COORD.
C****        INTYP   - TYPE OF INTERP. TO BE PERFORMED (1 - LINEAR,
C****                   2 - LOG ,3 - LOG-LOG
C****        SIGLEVI - 2 DIMENSIONAL ARRAY CONTAINING MODEL SIGMA
C****                  SURFACES.  ARRAY IS 2*NLVIP1.  THE 1ST INDEX
C****                  TAKES ON THE VALUE OF EITHER 
C****                    1 - FOR LEVEL INTERFACES (OR 1/2 LEVELS) OR;
C****                    2 - FOR LEVEL MIDPOINTS  (OR FULL LEVELS WHERE
C****                        VIRTUALLY ALL VARIABLES ARE LOCATED)
C****                   AS WITH THE HYBRID COEFFICIENTS THEY ARE 
C****                   ORDERED FROM TOP TO BOTTOM.
C****        SIGLEVO - ARRAY SPACE TO HOLD OUTPUT PRESURE SURFACES
C****                  FOR EITHER A 1/2 OF FULL LEVELS.  CURRENTLY
C****                  ALL VARIABLES ARE ON FULL LEVELS.
C****        NLI     - NO. OF PRESS SFCS.
C****        NLIP1   - NLI + 1
C****        NLO     - NO. OF MODEL HYBRID LEVELS.
C****
C****     ON OUTPUT-
C****        FKM - OUTPUT DATA ON MODEL HYBRID COORDINATES
C
C     INTEGER INTYP, NLI, NLIP1, NLO, IPHLV
C     REAL    FKR(NLI),FKM(NLO),SIGLEVO(NLO),SIGLEVI(NLIP1)  ! original
      INTEGER INTYP, NLI, NLO
      DOUBLE PRECISION FKR(NLI),FKM(NLO),SIGLEVO(NLO),SIGLEVI(NLI)

      INTEGER K, KP, IPRINT
      DOUBLE PRECISION A2LN, A1
C
C****     STATEMENT FCN. FOR DOUBLE DLOG. INTERP ON PRESSURE SURFACES
C****     PRESUMES PRESSURE IS IN MB
C
C     A2LN(A1)=DLOG(DLOG(A1+2.72))
C
C****     STATEMENT FCN. FOR DOUBLE DLOG. INTERP ON SIGMA SURFACES.
C****     SETS UP ROUGH UPPER BPOUND SIMILAR TO STATEMENT FCN FOR
C****     PRESSURE. I.E.    FIXED VALUE LN(LN(P) = LN(LN(FIXED VAL)
C****     AT .001 SIGMA OR ABOUT 1 MB
C
      A2LN(A1)=DLOG(DLOG(A1+1.001D0))
C
C****     BRACKET LEVEL TO BE INTERP. UNLESS MODEL IS AT EXTREMA OF REAL
C****     DATA LEVELS
C
      DO 60 K=1,NLO
C
C****     IF BRANCH FOR MODEL TOP
C
      IF (SIGLEVO(K).LE.SIGLEVI(2)) THEN
         KP=1
         GO TO 20
C
C****     IF BRANCH FOR MODEL BOTTOM
C
      ELSE IF (SIGLEVO(K).GE.SIGLEVI(NLI-1)) THEN
         KP=NLI-1
         GO TO 20
C
C****     IF BRANCH FOR MODEL INTERIOR
C
      ELSE
         KP=1
   10    CONTINUE
         KP=KP+1
         IF (SIGLEVO(K).LE.SIGLEVI(KP+1)) GO TO 20
        GO TO 10
      ENDIF
   20 CONTINUE
C
C****     LINEAR INTERP.
C
      IF (INTYP.EQ.1) THEN
         FKM(K) = FKR(KP)+(FKR(KP+1)-FKR(KP))
     *            * (SIGLEVO(K)-SIGLEVI(KP))
     *            / (SIGLEVI(KP+1)-SIGLEVI(KP))
C
C****     LOG INTERPOLATION.
C
      ELSE IF (INTYP.EQ.2) THEN
         FKM(K) = FKR(KP)+(FKR(KP+1)-FKR(KP))
     *            * DLOG(SIGLEVO(K)/SIGLEVI(KP))
     *            /  DLOG(SIGLEVI(KP+1)/SIGLEVI(KP))
C
C****     FOR LOG LOG INTERP. NOTE A2LN IS A STATEMENT FCN.
C
      ELSE IF (INTYP.EQ.3) THEN
         FKM(K)=FKR(KP)+(FKR(KP+1)-FKR(KP))*
     2          (A2LN(SIGLEVO(K)) - A2LN(SIGLEVI(KP)))/
     3          (A2LN(SIGLEVI(KP+1)) - A2LN(SIGLEVI(KP)))
      ENDIF
   60 CONTINUE
      RETURN
      END
