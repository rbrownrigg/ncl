/*
 *      $Id: varmenus.h,v 1.4 1998-09-18 23:47:40 boote Exp $
 */
/************************************************************************
*									*
*			     Copyright (C)  1996			*
*	     University Corporation for Atmospheric Research		*
*			     All Rights Reserved			*
*									*
************************************************************************/
/*
 *	File:		varmenus.h
 *
 *	Author:		David I. Brown
 *			National Center for Atmospheric Research
 *			PO 3000, Boulder, Colorado
 *
 *	Date:		Mon Mar 17 20:52:04 MST 1997
 *
 *	Description:	
 */
#ifndef	_NG_VARMENUS_H
#define	_NG_VARMENUS_H

#include <ncarg/ngo/go.h>

#ifndef _NCL_H_
#include <ncarg/ncl/defs.h>
#include <ncarg/ncl/NclDataDefs.h>
#include <ncarg/ncl/ApiRecords.h>
#include <ncarg/ncl/NclApi.h>
#define _NCL_H_
#endif

/*
 * Public api
 */

typedef struct _NgVarMenusRec 
{
        NhlPointer	vmenu_data;
	Widget		hluvars_mbutton;
        Widget		regvars_mbutton;
        Widget		filerefs_mbutton;
        Widget		filevars_mbutton;
        NrmQuark	qfile;    /* only used for retrieving file vars */
} NgVarMenusRec, *NgVarMenus;

NgVarMenus
NgCreateVarMenus(
        Widget		parent,
        XtCallbackProc	hluvar_cb,
        XtCallbackProc	regvar_cb,
        XtCallbackProc	fileref_cb,
        XtCallbackProc	filevar_cb,
        XtPointer	udata
        );


NhlErrorTypes NgUpdateVarMenus
(
        NgVarMenus		var_menus
        );

void NgDestroyVarMenus
(
        NgVarMenus		var_menus
        );
        

#endif	/* _NG_VARMENUS_H */
