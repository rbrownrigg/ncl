
/*
 *      $Id: TypeSupport.c.sed,v 1.2 1995-03-01 00:36:21 ethan Exp $
 */
/************************************************************************
*									*
*			     Copyright (C)  1995			*
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
 *	Date:		Fri Jan 27 18:29:40 MST 1995
 *
 *	Description:	
 */
#include <ncarg/hlu/hlu.h>
#include <ncarg/hlu/NresDB.h>
#include "defs.h"
#include "NclType.h"
#include "TypeSupport.h"
#include "NclMdInc.h"

INSERTHERE

NhlErrorTypes _NclInitTypeClasses
#if	NhlNeedProto
(void)
#else
()
#endif
{
	_NclInitClass(nclTypedoubleClass);
	_NclInitClass(nclTypefloatClass);
	_NclInitClass(nclTypelongClass);
	_NclInitClass(nclTypeintClass);
	_NclInitClass(nclTypeshortClass);
	_NclInitClass(nclTypelogicalClass);
	_NclInitClass(nclTypebyteClass);
	_NclInitClass(nclTypecharClass);
	_NclInitClass(nclTypestringClass);
	_NclInitClass(nclTypeobjClass);
	return(NhlNOERROR);
}

NhlErrorTypes _Nclcmpf
#if	NhlNeedProto
(NclTypeClass the_type, void *lhs, void* rhs, NclScalar* lhs_m, NclScalar* rhs_m,int digits,double *result)
#else
(the_type,lhs,rhs,lhs_m,rhs_m,digits,result)
NclTypeClass the_type;
void *lhs;
void* rhs;
NclScalar* lhs_m;
NclScalar* rhs_m;
int digits;
double *result;
#endif
{
	NclTypeClass tmp;

	if(the_type->type_class.cmpf!= NULL) {
		return((*(the_type->type_class.cmpf))(lhs,rhs,lhs_m,rhs_m,digits,result));
	} else {
		tmp = (NclTypeClass)the_type->obj_class.super_class;
		while(tmp != (NclTypeClass)nclTypeClass) {
			if(tmp->type_class.print!= NULL) {
				return((*(tmp->type_class.cmpf))(lhs,rhs,lhs_m,rhs_m,digits,result));
			} else {
				tmp = (NclTypeClass)tmp->obj_class.super_class;
			}
		}
	}

}

NclTypeClass _NclTypeEnumToTypeClass
#if	NhlNeedProto
(NclObjTypes obj_type_enum)
#else
(obj_type_enum)
NclObjTypes obj_type_enum;
#endif
{
	switch(obj_type_enum) {
	case Ncl_Typedouble:
		return((NclTypeClass)nclTypedoubleClass);
	case Ncl_Typefloat:
		return((NclTypeClass)nclTypefloatClass);
	case Ncl_Typelong:
		return((NclTypeClass)nclTypelongClass);
	case Ncl_Typeint:
		return((NclTypeClass)nclTypeintClass);
	case Ncl_Typeshort:
		return((NclTypeClass)nclTypeshortClass);
	case Ncl_Typebyte:
		return((NclTypeClass)nclTypebyteClass);
	case Ncl_Typestring:
		return((NclTypeClass)nclTypestringClass);
	case Ncl_Typechar:
		return((NclTypeClass)nclTypecharClass);
	case Ncl_Typeobj:
		return((NclTypeClass)nclTypeobjClass);
	case Ncl_Typelogical:
		return((NclTypeClass)nclTypelogicalClass);
	default:
		return((NclTypeClass)nclTypeClass);
	}
}

void _Nclprint
#if	NhlNeedProto
(NclTypeClass the_type,FILE *fp,void* val)
#else
(the_type,fp,val)
NclTypeClass the_type;
FILE *fp;
void* val;
#endif
{
	NclTypeClass tmp;

	if(the_type->type_class.print != NULL) {
		(*(the_type->type_class.print))(fp,val);
	} else {
		tmp = (NclTypeClass)the_type->obj_class.super_class;
		while(tmp != (NclTypeClass)nclTypeClass) {
			if(tmp->type_class.print!= NULL) {
				(*(tmp->type_class.print))(fp,val);
			} else {
				tmp = (NclTypeClass)tmp->obj_class.super_class;
			}
		}
	}

}

NhlErrorTypes _Nclcoerce
#if	NhlNeedProto
(NclTypeClass to_type, void * result, void* from, int n, NclScalar* from_m, NclScalar* to_m, NclTypeClass from_type)
#else
(t0_type, result, from, int n, from_m, to_m, from_type)
NclTypeClass to_type;
void * result;
void* from;
int n;
NclScalar* from_m;
NclScalar* to_m;
NclTypeClass from_type;
#endif
{
	NclTypeClass tmp;

	if(to_type->type_class.coerce != NULL) {
		return((*(to_type->type_class.coerce))(result,from,n,from_m,to_m,from_type));
	} else {
		tmp = (NclTypeClass)to_type->obj_class.super_class;
		while(tmp != (NclTypeClass)nclTypeClass) {
			if(tmp->type_class.coerce != NULL) {
				return((*(tmp->type_class.coerce))(result,from,n,from_m,to_m,from_type));
			} else {
				tmp =(NclTypeClass) tmp->obj_class.super_class;
			}
		}
		return(NhlFATAL);
	}
}

NhlErrorTypes _Nclreset_mis
#if	NhlNeedProto
(NclTypeClass the_type,void *val, NclScalar* old_m, NclScalar * new_m,int nval)
#else
(the_type,val, old_m, new_m,nval)
NclTypeClass the_type;
void *val;
NclScalar* old_m;
NclScalar* new_m;
int nval;
#endif
{
	NclTypeClass tmp;
	if(the_type->type_class.reset_mis != NULL) {
		return((*(the_type->type_class.reset_mis))(val,old_m,new_m,nval));
	} else {
		tmp = (NclTypeClass)the_type->obj_class.super_class;
		while(tmp != (NclTypeClass)nclTypeClass) {
			if(tmp->type_class.reset_mis != NULL) {
				return((*(tmp->type_class.reset_mis))(val,old_m,new_m,nval));
			} else {
				tmp = (NclTypeClass)tmp->obj_class.super_class;
			}
		}
		return(NhlFATAL);
	}
}

NclMonoTypes _Nclis_mono
#if	NhlNeedProto
(NclTypeClass the_type, void *val, NclScalar* val_m, int nval)
#else
(the_type, val, val_m, nval)
NclTypeClass the_type;
void *val;
NclScalar* val_m;
int nval;
#endif
{
	NclTypeClass tmp;
	if(the_type->type_class.is_mono != NULL) {
		return((*(the_type->type_class.is_mono))(val, val_m, nval));
	} else {
		tmp = (NclTypeClass)the_type->obj_class.super_class;
		while(tmp != (NclTypeClass)nclTypeClass) {
			if(tmp->type_class.is_mono != NULL) {
				return((*(tmp->type_class.is_mono))(val, val_m, nval));
			} else {
				tmp = (NclTypeClass)tmp->obj_class.super_class;
			}
		}
		return(NhlFATAL);
	}

}
