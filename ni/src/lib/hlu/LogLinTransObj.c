/*
 *      $Id: LogLinTransObj.c,v 1.8 1994-01-24 23:57:33 dbrown Exp $
 */
/************************************************************************
*									*
*			     Copyright (C)  1992			*
*	     University Corporation for Atmospheric Research		*
*			     All Rights Reserved			*
*									*
************************************************************************/
/*
 *	File:		
 *
 *	Author:		Ethan Alpert
 *			National Center for Atmospheric Research
 *			PO 3000, Boulder, Colorado
 *
 *	Date:		Wed Nov 4 16:38:57 MST 1992
 *
 *	Description:	
 */
#include <stdio.h>
#include <ncarg/hlu/hluutil.h>
#include <ncarg/hlu/hluP.h>
#include <ncarg/hlu/LogLinTransObjP.h>
#include <ncarg/hlu/View.h>
#include <math.h>


static NhlResource resources[] = {
	{ NhlNtrXMinF,NhlCtrXMinF,NhlTFloat,sizeof(float),
		NhlOffset(LogLinTransObjLayerRec,lltrans.x_min),
		NhlTString,"0.0"},
	{ NhlNtrXMaxF,NhlCtrXMaxF,NhlTFloat,sizeof(float),
		NhlOffset(LogLinTransObjLayerRec,lltrans.x_max),
		NhlTString,"1.0"},
	{ NhlNtrXLog,NhlCtrXLog,NhlTInteger,sizeof(int),
		NhlOffset(LogLinTransObjLayerRec,lltrans.x_log),
		NhlTString,"0" },
	{ NhlNtrXReverse,NhlCtrXReverse,NhlTInteger,sizeof(int),
		NhlOffset(LogLinTransObjLayerRec,lltrans.x_reverse),
		NhlTString,"0"},
	{ NhlNtrYMinF,NhlCtrYMinF,NhlTFloat,sizeof(float),
		NhlOffset(LogLinTransObjLayerRec,lltrans.y_min),
		NhlTString,"0.0"},
	{ NhlNtrYMaxF,NhlCtrYMaxF,NhlTFloat,sizeof(float),
		NhlOffset(LogLinTransObjLayerRec,lltrans.y_max),
		NhlTString,"1.0"},
	{ NhlNtrYLog,NhlCtrYLog,NhlTInteger,sizeof(int),
		NhlOffset(LogLinTransObjLayerRec,lltrans.y_log),
		NhlTString,"0" },
	{ NhlNtrYReverse,NhlCtrYReverse,NhlTInteger,sizeof(int),
		NhlOffset(LogLinTransObjLayerRec,lltrans.y_reverse),
		NhlTString,"0"}
};

/*
* BaseClass Methods defined
*/

static NhlErrorTypes  LlTransSetValues(
#ifdef NhlNeedProto
        Layer,          /* old */
        Layer,          /* reference */
        Layer,          /* new */
        _NhlArgList,    /* args */
        int             /* num_args*/
#endif
);

static NhlErrorTypes LlTransInitialize(
#ifdef NhlNeedProto
        LayerClass,     /* class */
        Layer,          /* req */
        Layer,          /* new */
        _NhlArgList,    /* args */
        int             /* num_args */
#endif
);


/*
* TransObjClass Methods defined
*/

static NhlErrorTypes LlNDCLineTo(
#if     NhlNeedProto
Layer   /* instance */,
Layer   /* parent */,
float   /* x */,
float   /* y */,
int     /* upordown */
#endif
);
static NhlErrorTypes LlDataLineTo(
#if     NhlNeedProto
Layer   /* instance */,
Layer   /* parent */,
float   /* x */,
float   /* y */,
int     /* upordown */
#endif
);






static NhlErrorTypes LlSetTrans(
#ifdef NhlNeedProto
Layer	/*instance*/,
Layer  /*parent*/
#endif
);

static NhlErrorTypes LlDataToWin(
#ifdef NhlNeedProto
Layer	/*instance*/,
Layer	/* parent */,
float*	/*x*/,
float*   /*y*/,
int	/* n*/,
float*	/*xout*/,
float*	/*yout*/,
float*	/*xmissing*/,
float*  /*ymissing*/,
int* 	/*status*/
#endif
);
static NhlErrorTypes LlWinToNDC(
#ifdef NhlNeedProto
Layer	/*instance*/,
Layer	/* parent */,
float*	/*x*/,
float*   /*y*/,
int	/* n*/,
float*	/*xout*/,
float*	/*yout*/,
float*	/*xmissing*/,
float*  /*ymissing*/,
int* 	/*status*/
#endif
);


static NhlErrorTypes LlNDCToWin(
#ifdef NhlNeedProto
Layer	/*instance*/,
Layer	/*parent */,
float*	/*x*/,
float*   /*y*/,
int	/* n*/,
float*	/*xout*/,
float*	/*yout*/,
float*	/*xmissing*/,
float*  /*ymissing*/,
int* 	/*status*/
#endif
);


LogLinTransObjLayerClassRec logLinTransObjLayerClassRec = {
        {
/* class_name			*/	"LogLinTransObj",
/* nrm_class			*/	NrmNULLQUARK,
/* layer_size			*/	sizeof(LogLinTransObjLayerRec),
/* class_inited			*/	False,
/* superclass			*/	(LayerClass)&transObjLayerClassRec,

/* layer_resources		*/	resources,
/* num_resources		*/	NhlNumber(resources),
/* all_resources		*/	NULL,

/* class_part_initialize	*/	NULL,
/* class_initialize		*/	NULL,
/* layer_initialize		*/	LlTransInitialize,
/* layer_set_values		*/	LlTransSetValues,
/* layer_set_values_hook	*/	NULL,
/* layer_get_values		*/	NULL,
/* layer_reparent		*/	NULL,
/* layer_destroy		*/	NULL
        },
        {
/* set_trans		*/	LlSetTrans,
/* trans_type		*/	NULL,
/* win_to_ndc		*/	LlWinToNDC,
/* ndc_to_win		*/	LlNDCToWin,
/* data_to_win		*/	LlDataToWin, /* One To One for this Transformation */
/* win_to_data		*/	LlDataToWin, /* One To One for this Transformation */
/* data_to_compc	*/	LlDataToWin,
/* compc_to_data	*/	LlDataToWin,
/* win_to_compc		*/	LlDataToWin,
/* compc_to_win		*/	LlDataToWin,
/* data_lineto 		*/      LlDataLineTo,
/* compc_lineto 	*/      LlDataLineTo,
/* win_lineto 		*/      LlDataLineTo,
/* NDC_lineto 		*/      LlNDCLineTo
        },
	{
		NULL
	}
};

LayerClass logLinTransObjLayerClass = (LayerClass)&logLinTransObjLayerClassRec;




/*
 * Function:	LlTransSetValues
 *
 * Description:	SetValues method for LogLinTrans Objects
 *
 * In Args: 	All standard ones for set_values method.
 *
 * Out Args:	Same as all set_values methods;
 *
 * Return Values: Error status
 *
 * Side Effects: Allocates and copies space for array resources
 */
/*ARGSUSED*/
static NhlErrorTypes LlTransSetValues
#if __STDC__
(Layer old, Layer reference, Layer new, _NhlArgList args, int num_args)
#else
(old,reference, new,args,num_args)
	Layer old;
	Layer reference;
	Layer new;
	_NhlArgList args;
	int	num_args;
#endif
{
	LogLinTransObjLayer lnew = (LogLinTransObjLayer) new;
	float tmp;

	lnew->lltrans.ul = lnew->lltrans.x_min;
	lnew->lltrans.ur = lnew->lltrans.x_max;
	lnew->lltrans.ut = lnew->lltrans.y_max;
	lnew->lltrans.ub = lnew->lltrans.y_min;
	if(lnew->lltrans.x_reverse) {
		tmp = lnew->lltrans.ul;
		lnew->lltrans.ul = lnew->lltrans.ur;
		lnew->lltrans.ur = tmp;
	}
	if(lnew->lltrans.y_reverse) {
		tmp = lnew->lltrans.ut;
		lnew->lltrans.ut = lnew->lltrans.ub;
		lnew->lltrans.ub = tmp;
	}
	if((lnew->lltrans.y_log)&&(lnew->lltrans.x_log)) {
		lnew->lltrans.log_lin_value = 4;
		if((lnew->lltrans.x_min <= 0.0)||(lnew->lltrans.x_max<=0.0)){	
			NhlPError(FATAL,E_UNKNOWN,"LlSetValues: Either NhlNtrXMax or NhlNtrXMin has been set to <= 0 for a log transformation");
			return(FATAL);
		}
		if((lnew->lltrans.y_min <= 0.0)||(lnew->lltrans.y_max<=0.0)){	
			NhlPError(FATAL,E_UNKNOWN,"LlSetValues: Either NhlNtrYMax or NhlNtrYMin has been set to <= 0 for a log transformation");
			return(FATAL);
		}
	} else if(lnew->lltrans.x_log) {
		lnew->lltrans.log_lin_value = 3;
		if((lnew->lltrans.x_min <= 0.0)||(lnew->lltrans.x_max<=0.0)){	
			NhlPError(FATAL,E_UNKNOWN,"LlSetValues: Either NhlNtrXMax or NhlNtrXMin has been set to <= 0 for a log transformation");
			return(FATAL);
		}
	} else if(lnew->lltrans.y_log) {
		lnew->lltrans.log_lin_value = 2;
		if((lnew->lltrans.y_min <= 0.0)||(lnew->lltrans.y_max<=0.0)){	
			NhlPError(FATAL,E_UNKNOWN,"LlSetValues: Either NhlNtrYMax or NhlNtrYMin has been set to <= 0 for a log transformation");
			return(FATAL);
		}
	} else {
		lnew->lltrans.log_lin_value = 1;
	}
	return(NOERROR);

}

/*
 * Function:	LlTransInitialize
 *
 * Description: Initialize function for LogLinTransObjs. Performs same
 *		operations as set_values for copying array resources
 *
 * In Args:  	Standard layer_initialize arguments.
 *
 * Out Args:	Standard layer_initialize output.
 *
 * Return Values: Error Status
 *
 * Side Effects: allocates space and copies valus of array resources.
 */
/*ARGSUSED*/
static NhlErrorTypes LlTransInitialize
#if __STDC__
( LayerClass class, Layer req, Layer new, _NhlArgList args, int num_args)
#else
(class,req,new,args,num_args)
        LayerClass	class;
        Layer		req;
        Layer		new;
        _NhlArgList	args;
        int		num_args;
#endif
{
	LogLinTransObjLayer lnew = (LogLinTransObjLayer) new;
	float tmp;

	lnew->lltrans.ul = lnew->lltrans.x_min;
	lnew->lltrans.ur = lnew->lltrans.x_max;
	lnew->lltrans.ut = lnew->lltrans.y_max;
	lnew->lltrans.ub = lnew->lltrans.y_min;
	if(lnew->lltrans.x_reverse) {
		tmp = lnew->lltrans.ul;
		lnew->lltrans.ul = lnew->lltrans.ur;
		lnew->lltrans.ur = tmp;
	}
	if(lnew->lltrans.y_reverse) {
		tmp = lnew->lltrans.ut;
		lnew->lltrans.ut = lnew->lltrans.ub;
		lnew->lltrans.ub = tmp;
	}
	if((lnew->lltrans.x_log)&&(lnew->lltrans.y_log)) {
		lnew->lltrans.log_lin_value = 4;
		if((lnew->lltrans.x_min <= 0.0)||(lnew->lltrans.x_max<=0.0)){	
			NhlPError(FATAL,E_UNKNOWN,"LlSetValues: Either NhlNtrXMax or NhlNtrXMin has been set to <= 0 for a log transformation");
			return(FATAL);
		}
		if((lnew->lltrans.y_min <= 0.0)||(lnew->lltrans.y_max<=0.0)){	
			NhlPError(FATAL,E_UNKNOWN,"LlSetValues: Either NhlNtrYMax or NhlNtrYMin has been set to <= 0 for a log transformation");
			return(FATAL);
		}
	} else if(lnew->lltrans.x_log) {
		lnew->lltrans.log_lin_value = 3;
		if((lnew->lltrans.x_min <= 0.0)||(lnew->lltrans.x_max<=0.0)){	
			NhlPError(FATAL,E_UNKNOWN,"LlSetValues: Either NhlNtrXMax or NhlNtrXMin has been set to <= 0 for a log transformation");
			return(FATAL);
		}
	} else if(lnew->lltrans.y_log) {
		lnew->lltrans.log_lin_value = 2;
		if((lnew->lltrans.y_min <= 0.0)||(lnew->lltrans.y_max<=0.0)){	
			NhlPError(FATAL,E_UNKNOWN,"LlSetValues: Either NhlNtrYMax or NhlNtrYMin has been set to <= 0 for a log transformation");
			return(FATAL);
		}
	} else {
		lnew->lltrans.log_lin_value = 1;
	}
	return(NOERROR);

}
/*
 * Function:	LlSetTrans
 *
 * Description: set_trans method for LogLinTransObjs. The current instance
 *		and the parent of the instance are needed. The parent 
 *		provides current screen position information (x,y,width,height)
 *		these are not set through resources because one transformation
 *		needs to possibly be shared by multiple plots.
 *
 * In Args:	instance    is the instance of the LogLinTransObj 
 *		parent	    is the parent of the transform
 *
 * Out Args:	NONE
 *
 * Return Values: Error Status
 *
 * Side Effects:  GKS state altered.
 */

static NhlErrorTypes LlSetTrans
#if __STDC__
(Layer instance, Layer parent) 
#else
(instance, parent)
Layer   instance;
Layer   parent;
#endif
{
	float x;
	float y;
	float width;
	float height;
	LogLinTransObjLayer linstance = (LogLinTransObjLayer)instance;
	NhlErrorTypes ret;
	

	ret = NhlGetValues(parent->base.id,
		NhlNvpXF,&x,
		NhlNvpYF,&y,
		NhlNvpWidthF,&width,
		NhlNvpHeightF,&height,NULL);
	if(ret < WARNING) {
		return(ret);
	}

	c_set(x,x+width,y-height,y,linstance->lltrans.ul,linstance->lltrans.ur,
		linstance->lltrans.ub,linstance->lltrans.ut,linstance->lltrans.log_lin_value);

	
	return(NOERROR);
	
}

static NhlErrorTypes LlDataToWin
#if  __STDC__
(Layer instance,Layer parent ,float *x,float *y,int n,float* xout,float* yout,float *xmissing,float *ymissing,int* status)
#else
(instance, parent,x,y,n,xout,yout,xmissing,ymissing,status)
	Layer   instance;
	Layer   parent;
	float   *x;
	float   *y;
	int	n;
	float*  xout;
	float*  yout;
	float*	xmissing;
	float*	ymissing;
	int *	status;
#endif
{
	LogLinTransObjLayer linst = (LogLinTransObjLayer)instance;
	int i; 

	*status = 0;

	for(i = 0; i< n; i++) {
		if(((xmissing != NULL)&&(*xmissing == x[i]))
			||((ymissing != NULL)&&(*ymissing == y[i]))
			||(x[i] < linst->lltrans.x_min)
			||(x[i] > linst->lltrans.x_max)
			||(y[i] < linst->lltrans.y_min)
			||(y[i] > linst->lltrans.y_max)) {
		
			*status = 1;
			xout[i]=yout[i]=linst->trobj.out_of_range;
			
		} else {
			xout[i] = x[i];
			yout[i] = y[i];

		}
	}
	return(NOERROR);
}

/*
 * Function:	LlWinToNDC
 *
 * Description: Computes the current forward tranformation of the points x and
 *		y to NDC based on the current viewport of the parent. It is
 *		important that this routine not depend on a static screen 
 *		orientation because the parents view may have been transformed.
 *
 * In Args:	instance is the LogLinTransObj and parent is the plot.
 *		(x,y) are the coordinates in data space.
 *		(xout,yout) are the coordinate in Normalized device coordinates.
 *
 * Out Args:
 *
 * Return Values:
 *
 * Side Effects:
 */

static NhlErrorTypes LlWinToNDC
#if  __STDC__
(Layer instance,Layer parent ,float *x,float *y,int n,float* xout,float* yout,float *xmissing,float *ymissing,int* status)
#else
(instance, parent,x,y,n,xout,yout,xmissing,ymissing,status)
	Layer   instance;
	Layer   parent;
	float   *x;
	float   *y;
	int	n;
	float*  xout;
	float*  yout;
	float*	xmissing;
	float*	ymissing;
	int *	status;
#endif
{
	float x0;
	float y0;
	float width;
	int i;
	float height;
	LogLinTransObjLayer linstance = (LogLinTransObjLayer)instance;
	NhlErrorTypes ret;
	float urtmp,ultmp,uttmp,ubtmp;
	float xmin,ymin,xmax,ymax;
	float tmpx,tmpy;
	
	
	ret = NhlGetValues(parent->base.id,
		NhlNvpXF,&x0,
		NhlNvpYF,&y0,
		NhlNvpWidthF,&width,
		NhlNvpHeightF,&height,NULL);
	if( ret < WARNING)
		return(ret);
	*status = 0;
	switch(linstance->lltrans.log_lin_value) {
		case 4:
/*
*XLogYLog case
*/
			urtmp = (float)log10(linstance->lltrans.ur);
			ultmp = (float)log10(linstance->lltrans.ul);
			uttmp = (float)log10(linstance->lltrans.ut);
			ubtmp = (float)log10(linstance->lltrans.ub);
	
			xmin = MIN(urtmp,ultmp);
			xmax = MAX(urtmp,ultmp);
			ymin = MIN(uttmp,ubtmp);
			ymax = MAX(uttmp,ubtmp);
	
			for(i = 0; i< n; i++) {
				if((x[i] > 0.0)||(y[i] > 0.0)) {
					tmpx = log10(x[i]);
					tmpy = log10(y[i]);
					if(((xmissing != NULL) &&(*xmissing == x[i]))
						||((ymissing != NULL) &&(*ymissing == y[i]))
						||(tmpx < xmin)
						||(tmpx > xmax)
						||(tmpy < ymin)
						||(tmpy > ymax)) {

						*status = 1;
						xout[i]=yout[i]=linstance->trobj.out_of_range;

					} else {

						strans( ultmp, urtmp, ubtmp, uttmp, 
							x0,x0+width,y0-height,y0,
							tmpx, tmpy, 
							&(xout[i]),&(yout[i]));
					}
				} else {
					*status = 1;	
					xout[i]=yout[i]=linstance->trobj.out_of_range;
				}
			}
			break;
		case 3:
/*
*XLogYLin case
*/
			urtmp = (float)log10(linstance->lltrans.ur);
			ultmp = (float)log10(linstance->lltrans.ul);
			xmin = MIN(urtmp,ultmp);
			xmax = MAX(urtmp,ultmp);
		
			for(i = 0; i< n; i++) {
				if(x[i] > 0) {
					tmpx = log10(x[i]);
					if(((xmissing != NULL) &&(*xmissing == x[i]))
						||((ymissing != NULL) &&(*ymissing == y[i]))
						||(tmpx < xmin)
						||(tmpx > xmax)
						||(y[i] < linstance->lltrans.y_min)
						||(y[i] > linstance->lltrans.y_max)) {
						
						*status = 1;
						xout[i]=yout[i]=linstance->trobj.out_of_range;
					} else {
						strans( ultmp, urtmp, linstance->lltrans.ub, 
							linstance->lltrans.ut, x0,x0+width,
							y0-height,y0,tmpx,y[i], 
						&(xout[i]),&(yout[i]));
					}
				} else {
					*status = 1;
					xout[i]=yout[i]=linstance->trobj.out_of_range;
				}
			}
			break;
		case 2:
/*
*XLinYLog case
*/
			uttmp = (float)log10(linstance->lltrans.ut);
			ubtmp = (float)log10(linstance->lltrans.ub);
			ymin = MIN(uttmp,ubtmp);
			ymax = MAX(uttmp,ubtmp);
			for(i = 0; i< n; i++) {
				if(y[i] > 0) {
					tmpy = log10(y[i]);
					if(((xmissing != NULL) &&(*xmissing == x[i]))
						||((ymissing != NULL)&&(*ymissing == y[i]))
						||(x[i] < linstance->lltrans.x_min)
						||(x[i] > linstance->lltrans.x_max)
						||(tmpy < ymin)
						||(tmpy > ymax)) {

						*status = 1;
						xout[i]=yout[i]=linstance->trobj.out_of_range;

					} else {
						strans( linstance->lltrans.ul, 
							linstance->lltrans.ur, ubtmp,uttmp, 
							x0,x0+width,y0-height,y0,
							x[i],tmpy,
							&(xout[i]),&(yout[i]));
					}
				} else {	
					*status = 1;
					xout[i]=yout[i]=linstance->trobj.out_of_range;
				}
			}
			break;
		case 1:
/*
*XLinYLin
*/
			for(i = 0; i< n; i++) {
				if(((xmissing != NULL) &&(*xmissing == x[i]))
					||((ymissing != NULL) &&(*ymissing == y[i])) 
					||(x[i] < linstance->lltrans.x_min)
					||(x[i] > linstance->lltrans.x_max)
					||(y[i] < linstance->lltrans.y_min)
					||(y[i] > linstance->lltrans.y_max)) {

					*status = 1;
					xout[i]=yout[i]=linstance->trobj.out_of_range;
	
				} else {
					strans( linstance->lltrans.ul, 
						linstance->lltrans.ur, 
						linstance->lltrans.ub, 
						linstance->lltrans.ut, 
						x0,x0+width,y0-height,y0,
						x[i],y[i], &(xout[i]),&(yout[i]));
				}
			}
			break;
		default:
			NhlPError(FATAL,E_UNKNOWN,"Internal Error in LlNDCToWin");
			return(FATAL);
	}
	return NOERROR;
}


/*
 * Function:	LlNDCToWin
 *
 * Description:
 *
 * In Args:
 *
 * Out Args:
 *
 * Return Values:
 *
 * Side Effects:
 */
static NhlErrorTypes LlNDCToWin
#if  __STDC__
(Layer instance,Layer parent ,float *x,float *y,int n,float* xout,float* yout,float *xmissing, float *ymissing,int *status)
#else
(instance, parent,x,y,n,xout,yout,xmissing,ymissing,status)
	Layer   instance;
	Layer   parent;
	float   *x;
	float   *y;
	int	n;
	float*  xout;
	float*  yout;
	float*	xmissing;
	float*	ymissing;
	int *status;
#endif
{
	float x0;
	float y0;
	float width;
	int i;
	float height;
	LogLinTransObjLayer linstance = (LogLinTransObjLayer)instance;
	NhlErrorTypes ret;
	float urtmp,ultmp,uttmp,ubtmp;
	float xmin,ymin,xmax,ymax;
	
	
	ret = NhlGetValues(parent->base.id,
		NhlNvpXF,&x0,
		NhlNvpYF,&y0,
		NhlNvpWidthF,&width,
		NhlNvpHeightF,&height,NULL);
	xmin = x0;
	xmax = x0 + width;
	ymin = y0 - height;
	ymax = y0;
	if( ret < WARNING)
		return(ret);
	*status = 0;
	switch(linstance->lltrans.log_lin_value) {
		case 4:
/*
*XLogYLog case
*/
			urtmp = (float)log10(linstance->lltrans.ur);
			ultmp = (float)log10(linstance->lltrans.ul);
			uttmp = (float)log10(linstance->lltrans.ut);
			ubtmp = (float)log10(linstance->lltrans.ub);
	

			for(i = 0; i< n; i++) {
				if(((xmissing != NULL)&&(*xmissing == x[i]))
					||((ymissing != NULL)&&(*ymissing == y[i]))
					||(x[i] < xmin)
					||(x[i] > xmax)
					||(y[i] < ymin)
					||(y[i] > ymax)) {
			
					*status = 1;
					xout[i]=yout[i]=linstance->trobj.out_of_range;
				} else {
		
					strans(x0,x0+width,y0-height,y0,ultmp, urtmp, 
						ubtmp, uttmp, x[i],y[i], 
						&(xout[i]),&(yout[i]));
					xout[i]=(float)pow((double)10.0,
							(double)xout[i]);
					yout[i]=(float) pow((double)10.0,
							(double)yout[i]);
				}
			}
		
			break;
		case 3:
/*
*XLogYLin case
*/
			urtmp = (float)log10(linstance->lltrans.ur);
			ultmp = (float)log10(linstance->lltrans.ul);
		
			for(i = 0; i< n; i++) {
				if(((xmissing != NULL)&&(*xmissing == x[i]))
					||((ymissing != NULL)&&(*ymissing == y[i]))
					||(x[i] < xmin)
					||(x[i] > xmax)
					||(y[i] < ymin)
					||(y[i] > ymax)) {
		
					*status = 1;
					xout[i]=yout[i]=linstance->trobj.out_of_range;
				} else {
					strans(x0,x0+width,y0-height,y0,ultmp,
						urtmp, linstance->lltrans.ub,
						linstance->lltrans.ut, x[i],y[i],
						&(xout[i]),&(yout[i]));
						xout[i] = (float) pow((double)10.0,
								(double) xout[i]);
				}
			}
			break;
		case 2:
/*
*XLinYLog case
*/
			uttmp = (float)log10(linstance->lltrans.ut);
			ubtmp = (float)log10(linstance->lltrans.ub);

			for(i = 0; i< n; i++) {
				if(((xmissing != NULL)&&(*xmissing == x[i]))
					||((ymissing != NULL)&&(*ymissing == y[i]))
					||(x[i] < xmin)
					||(x[i] > xmax)
					||(y[i] < ymin)
					||(y[i] > ymax)) {

					*status = 1;
					xout[i]=yout[i]=linstance->trobj.out_of_range;
				} else {
					strans(x0,x0+width,y0-height,y0,
						linstance->lltrans.ul,
						linstance->lltrans.ur, 
						ubtmp,uttmp, 
						x[i],y[i],
						&(xout[i]),&(yout[i]));
					yout[i]=(float) pow((double)10.0,
							(double)yout[i]);
				}
			}
			break;
		case 1:
/*
*XLinYLin
*/
			for(i = 0; i< n; i++) {
				if(((xmissing != NULL)&&(*xmissing == x[i]))
					||((ymissing != NULL)&&(*ymissing == y[i]))
					||(x[i] < xmin)
					||(x[i] > xmax)
					||(y[i] < ymin)
					||(y[i] > ymax)) {

					*status = 1;
					xout[i]=yout[i]=linstance->trobj.out_of_range;
				} else {
					strans(x0,x0+width,y0-height,y0,
						linstance->lltrans.ul,
						linstance->lltrans.ur, 
						linstance->lltrans.ub,
						linstance->lltrans.ut, 
						x[i],y[i],
						&(xout[i]),&(yout[i]));
				}
			}
			break;
		default:
			NhlPError(FATAL,E_UNKNOWN,"Internal Error in LlNDCToWin");
			return(FATAL);
	}
	return ret;
}


/*ARGSUSED*/
static NhlErrorTypes LlDataLineTo
#if __STDC__
(Layer instance, Layer parent,float x, float y, int upordown )
#else
(instance, parent,x, y, upordown )
Layer instance;
Layer parent;
float x;
float y;
int upordown;
#endif
{
	LogLinTransObjLayer llinst = (LogLinTransObjLayer)instance;
	static float lastx,lasty;
	static call_frstd = 1;
	float currentx,currenty;
	float holdx,holdy;

/*
* if true the moveto is being performed
*/
	if(upordown) {
		lastx = x;
		lasty = y;
		call_frstd =1;
		return(NOERROR);
	} else {
		currentx = x;
		currenty = y;
		holdx = lastx;
		holdy = lasty;
		_NhlTransClipLine(llinst->lltrans.x_min,
			llinst->lltrans.x_max,
			llinst->lltrans.y_min,
			llinst->lltrans.y_max,
			&lastx,
			&lasty,
			&currentx,
			&currenty,
			llinst->trobj.out_of_range);
		if((lastx == llinst->trobj.out_of_range)
			||(lasty == llinst->trobj.out_of_range)
			||(currentx == llinst->trobj.out_of_range)
			||(currenty == llinst->trobj.out_of_range)){
/*
* Line has gone completely out of window
*/
			lastx = x;	
			lasty = y;
			call_frstd = 1;
			return(_NhlWorkstationLineTo(parent->base.wkptr,c_cufx(x),c_cufy(y),1));
		} else {
                        if((lastx != holdx)||(lasty!= holdy)) {
                                call_frstd = 1;
                        }
			if(call_frstd == 1) {
				_NhlWorkstationLineTo(parent->base.wkptr,c_cufx(lastx),c_cufy(lasty),1);
				call_frstd = 2;
			}
			_NhlWorkstationLineTo(parent->base.wkptr,c_cufx(currentx),c_cufy(currenty),0);
			lastx = x;
			lasty = y;
			return(NOERROR);
		}
			
			
	}
	
}

/*ARGSUSED*/
static NhlErrorTypes LlNDCLineTo
#if __STDC__
(Layer instance, Layer parent, float x, float y, int upordown)
#else
(instance, parent, x, y, upordown)
Layer instance;
Layer parent;
float x;
float y;
int upordown;
#endif
{
	LogLinTransObjLayer llinst = (LogLinTransObjLayer)instance;
	static float lastx,lasty;
	static call_frstd = 1;
	float currentx,currenty;
	float xvp,yvp,widthvp,heightvp;
	NhlErrorTypes ret = NOERROR,ret1 = NOERROR;
	float holdx,holdy;

/*
* if true the moveto is being performed
*/
	if(upordown) {
		lastx = x;
		lasty = y;
		call_frstd = 1;
		return(NOERROR);
	} else {
		currentx = x;
		currenty = y;
		holdx = lastx;
		holdy = lasty;
		NhlGetValues(parent->base.id,
			NhlNvpXF,&xvp,
			NhlNvpYF,&yvp,
			NhlNvpWidthF,&widthvp,
			NhlNvpHeightF,&heightvp,NULL);
		_NhlTransClipLine( xvp, xvp+widthvp, yvp-heightvp, yvp,
			&lastx, &lasty, &currentx, &currenty,
			llinst->trobj.out_of_range);
		if((lastx == llinst->trobj.out_of_range)
			||(lasty == llinst->trobj.out_of_range)
			||(currentx == llinst->trobj.out_of_range)
			||(currenty == llinst->trobj.out_of_range)){
/*
* Line has gone completely out of window
*/
			lastx  = x;
			lasty  = y;
			call_frstd = 1;
			return(_NhlWorkstationLineTo(parent->base.wkptr,x,y,1));
		} else {
                        if((lastx != holdx)||(lasty!= holdy)) {
                                call_frstd = 1;
                        }
			if(call_frstd == 1) {
				ret1 = _NhlWorkstationLineTo(parent->base.wkptr,lastx,lasty,1);
				call_frstd = 2;
			}
			ret = _NhlWorkstationLineTo(parent->base.wkptr,currentx,currenty,0);
			lastx = x;
			lasty = y;			
			return(MIN(ret1,ret));
		}
			
			
	}
	
}
