.\"
.\"	$Id: ginq_line_colr_ind.m,v 1.7 1998-02-04 05:12:36 haley Exp $
.\"
.TH GINQ_LINE_COLR_ind 3NCARG "March 1993" UNIX "NCAR GRAPHICS"
.SH NAME
ginq_line_colr_ind (Inquire polyline color index) - gets the polyline color index.
.SH SYNOPSIS
#include <ncarg/gks.h>
.sp
void ginq_line_colr_ind(Gint *err_ind, Gint *line_colr_ind);
.SH DESCRIPTION
.IP err_ind 12
(Output) - If the inquired value cannot be returned correctly,
a non-zero error indicator is returned in err_ind, otherwise a zero is returned.
Consult "User's Guide for NCAR GKS-0A Graphics" for a description of the
meaning of the error indicators.
.IP line_colr_ind 12
(Output) - Returns the polyline color index as set by default
of by a call to gset_line_colr_ind.
.SH ACCESS
To use the GKS C-binding routines, load the ncarg_gks and
ncarg_c libraries.
.SH SEE ALSO
Online: 
.BR gpolyline(3NCARG),
.BR gset_linetype(3NCARG),
.BR gset_linewidth(3NCARG),
.BR gset_colr_rep(3NCARG),
.BR gset_line_colr_ind(3NCARG),
.BR ginq_linetype(3NCARG),
.BR ginq_linewidth(3NCARG),
.BR ginq_line_colr_ind(3NCARG),
.BR dashline(3NCARG),
.BR gks(3NCARG),
.BR ncarg_gks_cbind(3NCARG)
.sp
Hardcopy: 
User's Guide for NCAR GKS-0A Graphics;
NCAR Graphics Fundamentals, UNIX Version
.SH COPYRIGHT
Copyright (C) 1987-1998
.br
University Corporation for Atmospheric Research
.br
The use of this Software is governed by a License Agreement.
