C
C $Id: ezxy.f,v 1.7 2006-03-09 22:56:09 kennison Exp $
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
      SUBROUTINE EZXY (XDRA,YDRA,NPTS,LABG)
C
      REAL XDRA(*),YDRA(*)
C
      CHARACTER*(*) LABG
C
C The routine EZXY draws one curve through the points (XDRA(I),YDRA(I)),
C for I = 1, 2, ... NPTS.
C
      CALL AGGETI ('SET .',ISET)
      CALL AGGETI ('FRAM.',IFRA)
C
      CALL AGEZSU (2,XDRA,YDRA,NPTS,1,NPTS,LABG,IIVX,IIEX,IIVY,IIEY)
      CALL AGBACK
C
      IF (ISET.GE.0) CALL AGCURV (XDRA,1,YDRA,1,NPTS,1)
C
      IF (IFRA.EQ.1) CALL FRAME
C
      RETURN
C
      END
