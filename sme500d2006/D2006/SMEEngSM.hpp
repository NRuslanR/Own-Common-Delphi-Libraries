// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Smeengsm.pas' rev: 10.00

#ifndef SmeengsmHPP
#define SmeengsmHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Smeengine.hpp>	// Pascal unit
#include <Smeengdb.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Smeengsm
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TSMEsmDBGridDataEngine;
class PASCALIMPLEMENTATION TSMEsmDBGridDataEngine : public Smeengdb::TSMECustomDBDataEngine 
{
	typedef Smeengdb::TSMECustomDBDataEngine inherited;
	
private:
	int intCurrentRow;
	bool FExportFooters;
	
public:
	virtual bool __fastcall SelectedRecordIsSupported(void);
	virtual bool __fastcall IsDataRow(int Index);
	virtual bool __fastcall Eof(void);
	virtual void __fastcall First(void);
	virtual void __fastcall Next(void);
	virtual int __fastcall RecordCount(void);
	virtual Variant __fastcall GetFieldValue(Smeengine::TSMEColumn* Column);
	
__published:
	__property bool ExportFooters = {read=FExportFooters, write=FExportFooters, default=0};
public:
	#pragma option push -w-inl
	/* TComponent.Create */ inline __fastcall virtual TSMEsmDBGridDataEngine(Classes::TComponent* AOwner) : Smeengdb::TSMECustomDBDataEngine(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TComponent.Destroy */ inline __fastcall virtual ~TSMEsmDBGridDataEngine(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Smeengsm */
using namespace Smeengsm;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Smeengsm
