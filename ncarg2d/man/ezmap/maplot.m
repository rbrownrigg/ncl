.TH MAPLOT 3NCARG "March 1993" UNIX "NCAR GRAPHICS"
.na
.nh
.SH NAME
MAPLOT - Draws geographical outlines.
.SH SYNOPSIS
CALL MAPLOT 
.SH C-BINDING SYNOPSIS
#include <ncarg/ncargC.h>
.sp
void c_maplot()
.SH DESCRIPTION
MAPLOT has no arguments.
.SH USAGE 
MAPLOT draws the continental and/or political outlines selected 
by the Ezmap parameter 'OU'; the parameter
\&'DO' determines whether solid lines or dotted lines are drawn.
If Ezmap currently needs initialization, or if the error flag
\&'ER' is set, MAPLOT does nothing.
.SH EXAMPLES
Use the ncargex command to see the following relevant
examples: 
ccpcica,
ccpmovi,
ccppole,
colcon,
cmpclr,
cmpel,
cmpfil,
cmpgrp,
cmpita,
cmpitm,
cmplab,
cmplot,
cmpmsk,
cmpou,
cmptit,
cpex08,
mpex09,
eezmpa,
epltch,
tezmpa,
fcover,
ffex00,
ffex02,
ffex03,
ffex05,
fpchiqu.
.SH ACCESS
To use MAPLOT or c_maplot, load the NCAR Graphics libraries ncarg, ncarg_gks,
and ncarg_c, preferably in that order.  
.SH SEE ALSO
Online:
ezmap,
ezmap_params,
mapaci,
mapbla,
mapblm,
mapdrw,
mapeod,
mapfst,
mapgci,
mapgrd,
mapgrm,
mapgtc,
mapgti,
mapgtl,
mapgtr,
mapint,
mapiq,
mapiqa,
mapiqd,
mapiqm,
mapit,
mapita,
mapitd,
mapitm,
maplbl,
maplmb,
mappos,
maproj,
maprs,
maprst,
mapsav,
mapset,
mapstc,
mapsti,
mapstl,
mapstr,
maptra,
maptri,
maptrn,
mapusr,
mapvec,
mpgetc,
mpgeti,
mpgetl,
mpgetr,
mprset,
mpsetc,
mpseti,
mpsetl,
mpsetr,
supmap,
supcon,
ncarg_cbind
.sp
Hardcopy:  
NCAR Graphics Contouring and Mapping Tutorial
.SH COPYRIGHT
Copyright (C) 1987-1998
.br
University Corporation for Atmospheric Research
.br
The use of this Software is governed by a License Agreement.
