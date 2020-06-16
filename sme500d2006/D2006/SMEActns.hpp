// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Smeactns.pas' rev: 10.00

#ifndef SmeactnsHPP
#define SmeactnsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Actnlist.hpp>	// Pascal unit
#include <Smeengine.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Smeactns
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TSMExportAction;
class PASCALIMPLEMENTATION TSMExportAction : public Actnlist::TAction 
{
	typedef Actnlist::TAction inherited;
	
protected:
	Controls::TWinControl* __fastcall GetControl(void);
	TMetaClass* __fastcall GetExportEngineClass(Controls::TWinControl* AControl);
	Smeengine::TSMECustomDataEngine* __fastcall GetExportEngine(Controls::TWinControl* AControl);
	
public:
	virtual void __fastcall ExecuteTarget(System::TObject* Target);
	virtual void __fastcall UpdateTarget(System::TObject* Target);
public:
	#pragma option push -w-inl
	/* TAction.Create */ inline __fastcall virtual TSMExportAction(Classes::TComponent* AOwner) : Actnlist::TAction(AOwner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TSMExportAction(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Smeactns */
using namespace Smeactns;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Smeactns
