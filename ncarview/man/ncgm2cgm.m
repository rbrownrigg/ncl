.\"
.\"	$Id: ncgm2cgm.m,v 1.8 1993-01-16 00:02:35 clyne Exp $
.\"
.\"	ncgm2cgm.l 3.00 10/5/89 NCAR View
.TH NCGM2CGM 1NCARG "January 1993" NCARG "NCAR GRAPHICS"
.SH NAME
cgm2ncgm ncgm2cgm \- filter \fBNCAR CGM\fR to/from vanilla \fBCGM\fR
.SH SYNOPSIS
.B ncgm2cgm
[\ \fB\-s\ \fIoutput block size\fR\ ]
[\ \fB\-V\ ]
.LP
.B cgm2ncgm
[\ \fB\-s\ \fIinput block size\fR\ ]
[\ \fB\-V\ ]
.PP
.SH DESCRIPTION
\fBncgm2cgm\fR and \fBcgm2ncgm\fR are filters for converting back and forth
between \fBNCAR Computer Graphics Metafile\fR (CGM) and vanilla \fRCGM\fR.
\fBncgm2cgm\fR strips the wrapper from NCAR CGM records while \fRcgm2ncgm\fR
restores. I/O is done from standard in/out respectively.
.PP
.SH OPTIONS
.IP \fB\-s\fP\fI\ size\fP
Set block size in bytes for reads/writes of vanilla CGM. The default blocking
factor is 1024.
.IP \fB\-V\fR
Print the version number and then exit.
.SH SEE ALSO
.nf
\fIISO/DIS 8632 CGM Functional Specification\fR (Nov. 1985)
\fINCAR Installer's Guide\fR, Version 2.00 (Aug. 1987)
.fi
.SH BUGS
Some 
.I vanilla
metafile interpretors take advantage of shortcuts provided by their CGM
generators. In effect, they are not
.I true
CGM interpretors. Although It will still be possible to convert these metafiles
to NCAR format that may be interpreted by NCAR Graphics translators. It may
not be the case that the aforementioned interpreters will be able to translate
.I true
vanilla metafiles, such as produced by 
.B ncgm2cgm.
