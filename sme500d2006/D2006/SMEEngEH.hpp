// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Smeengeh.pas' rev: 10.00

#ifndef SmeengehHPP
#define SmeengehHPP

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

namespace Smeengeh
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TSMEDBGridEHDataEngine;
class PASCALIMPLEMENTATION TSMEDBGridEHDataEngine : public Smeengdb::TSMECustomDBDataEngine 
{
	typedef Smeengdb::TSMECustomDBDataEngine inherited;
	
protected:
	virtual Db::TDataSet* __fastcall GetDataset(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	virtual bool __fastcall SelectedRecordIsSupported(void);
	virtual void __fastcall FillColumns(Smeengine::TSMEColumns* Columns, Smeengine::TSMEColumnBands* Bands, bool RightToLeft);
	virtual bool __fastcall Eof(void);
	virtual void __fastcall First(void);
	virtual void __fastcall Next(void);
	virtual int __fastcall RecordCount(void);
public:
	#pragma option push -w-inl
	/* TComponent.Create */ inline __fastcall virtual TSMEDBGridEHDataEngine(Classes::TComponent* AOwner) : Smeengdb::TSMECustomDBDataEngine(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TComponent.Destroy */ inline __fastcall virtual ~TSMEDBGridEHDataEngine(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Smeengeh */
using namespace Smeengeh;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Smeengeh
