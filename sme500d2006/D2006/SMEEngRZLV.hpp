// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Smeengrzlv.pas' rev: 10.00

#ifndef SmeengrzlvHPP
#define SmeengrzlvHPP

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
#include <Comctrls.hpp>	// Pascal unit
#include <Smeengine.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Smeengrzlv
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TSMERZListViewDataEngine;
class PASCALIMPLEMENTATION TSMERZListViewDataEngine : public Smeengine::TSMECustomDataEngine 
{
	typedef Smeengine::TSMECustomDataEngine inherited;
	
private:
	int FCurLine;
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	virtual bool __fastcall Eof(void);
	virtual void __fastcall First(void);
	virtual void __fastcall Next(void);
	virtual Variant __fastcall GetFieldValue(Smeengine::TSMEColumn* Column);
	virtual int __fastcall RecordCount(void);
public:
	#pragma option push -w-inl
	/* TComponent.Create */ inline __fastcall virtual TSMERZListViewDataEngine(Classes::TComponent* AOwner) : Smeengine::TSMECustomDataEngine(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TComponent.Destroy */ inline __fastcall virtual ~TSMERZListViewDataEngine(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Smeengrzlv */
using namespace Smeengrzlv;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Smeengrzlv
