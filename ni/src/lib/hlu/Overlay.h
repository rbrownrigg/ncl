
/*
 *      $Id: Overlay.h,v 1.4 1994-01-24 23:57:44 dbrown Exp $
 */
/************************************************************************
*									*
*			     Copyright (C)  1992			*
*	     University Corporation for Atmospheric Research		*
*			     All Rights Reserved			*
*									*
************************************************************************/
/*
 *	File:		Overlay.h
 *
 *	Author:		David Brown
 *			National Center for Atmospheric Research
 *			PO 3000, Boulder, Colorado
 *
 *	Date:		Tue Nov 16 15:18:58 MST 1993
 *
 *	Description:	Public header for Overlay class.
 */

#ifndef _NOverlay_h
#define _NOverlay_h

#include <ncarg/hlu/Transform.h>
#include <ncarg/hlu/TickMark.h>
#include <ncarg/hlu/Title.h>
#include <ncarg/hlu/LabelBar.h>
#include <ncarg/hlu/Legend.h>

/*
 * defines for Display resources (temporary, should be enums)
 */

#define Nhl_ovNoCreate		0
#define Nhl_ovNever		1
#define Nhl_ovConditionally	2
#define Nhl_ovAlways		3


/*
 * Overlay instance resources
 */

#define NhlNovOverlayIds	".ovOverlayIds"
#define NhlNovPreDrawOrder	".ovPreDrawOrder"
#define NhlNovPostDrawOrder	".ovPostDrawOrder"
#define NhlNovDisplayTitles	"ovDisplayTitles"
#define NhlNovDisplayTickMarks	"ovDisplayTickMarks"
#define NhlNovDisplayLabelBar	"ovDisplayLabelBar"
#define NhlNovDisplayLegend	"ovDisplayLegend"
#define NhlNovLabelBarWidthF	"ovLabelBarWidth"
#define NhlNovLabelBarHeightF	"ovLabelBarHeight"
#define NhlNovLabelBarXOffsetF	"ovLabelBarXOffset"
#define NhlNovLabelBarYOffsetF	"ovLabelBarYOffset"
#define NhlNovLabelBarSide	"ovLabelBarSide"
#define NhlNovLabelBarPosition	"ovLabelBarPosition"
#define NhlNovLegendWidthF	"ovLegendWidth"
#define NhlNovLegendHeightF	"ovLegendHeight"
#define NhlNovLegendXOffsetF	"ovLegendXOffset"
#define NhlNovLegendYOffsetF	"ovLegendYOffset"
#define NhlNovLegendSide	"ovLegendSide"
#define NhlNovLegendPosition	"ovLegendPosition"

/*
 * Overlay class resources
 */

#define NhlCovOverlayIds	".OvOverlayIds"
#define NhlCovPreDrawOrder	".OvPreDrawOrder"
#define NhlCovPostDrawOrder	".OvPostDrawOrder"
#define NhlCovDisplayTitles	"OvDisplayTitles"
#define NhlCovDisplayTickMarks	"OvDisplayTickMarks"
#define NhlCovDisplayLabelBar	"OvDisplayLabelBar"
#define NhlCovDisplayLegend	"OvDisplayLegend"
#define NhlCovLabelBarWidthF	"OvLabelBarWidth"
#define NhlCovLabelBarHeightF	"OvLabelBarHeight"
#define NhlCovLabelBarXOffsetF	"OvLabelBarXOffset"
#define NhlCovLabelBarYOffsetF	"OvLabelBarYOffset"
#define NhlCovLabelBarSide	"OvLabelBarSide"
#define NhlCovLabelBarPosition	"OvLabelBarPosition"
#define NhlCovLegendWidthF	"OvLegendWidth"
#define NhlCovLegendHeightF	"OvLegendHeight"
#define NhlCovLegendXOffsetF	"OvLegendXOffset"
#define NhlCovLegendYOffsetF	"OvLegendYOffset"
#define NhlCovLegendSide	"OvLegendSide"
#define NhlCovLegendPosition	"OvLegendPosition"


typedef struct _OverlayLayerClassRec *OverlayLayerClass;
typedef struct _OverlayLayerRec *OverlayLayer;

extern LayerClass overlayLayerClass;

/* 
 * Convenience function that performs the basic management of an
 * overlay for a plot object. Designed to be called from ...Initialize
 * or ...SetValues.
 */

extern NhlErrorTypes _NhlManageOverlay(
#ifdef NhlNeedProto
	Layer		*overlay_object,
	Layer		lnew,
	Layer		lold,
	NhlBoolean	init,
	NhlSArgList	sargs,
	int		nargs,
	char		*entry_name				   
#endif
);

#endif /*_NOverlay_h */
