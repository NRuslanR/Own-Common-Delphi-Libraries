// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Smeengstrings.pas' rev: 10.00

#ifndef SmeengstringsHPP
#define SmeengstringsHPP

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
#include <Smeengine.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Smeengstrings
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TSMEStringsDataEngine;
class PASCALIMPLEMENTATION TSMEStringsDataEngine : public Smeengine::TSMECustomDataEngine 
{
	typedef Smeengine::TSMECustomDataEngine inherited;
	
private:
	int FCurLine;
	Classes::TStrings* FStrings;
	void __fastcall SetStrings(Classes::TStrings* AValue);
	
public:
	__fastcall virtual TSMEStringsDataEngine(Classes::TComponent* AOwner);
	__fastcall virtual ~TSMEStringsDataEngine(void);
	virtual void __fastcall EnableControls(void);
	virtual void __fastcall DisableControls(void);
	virtual void __fastcall FillColumns(Smeengine::TSMEColumns* Columns, Smeengine::TSMEColumnBands* Bands, bool RightToLeft);
	virtual bool __fastcall Eof(void);
	virtual void __fastcall First(void);
	virtual void __fastcall Next(void);
	virtual Variant __fastcall GetFieldValue(Smeengine::TSMEColumn* Column);
	virtual int __fastcall RecordCount(void);
	
__published:
	__property Classes::TStrings* Strings = {read=FStrings, write=SetStrings};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Smeengstrings */
using namespace Smeengstrings;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Smeengstrings
