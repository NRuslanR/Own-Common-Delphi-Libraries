// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Sme2clp.pas' rev: 10.00

#ifndef Sme2clpHPP
#define Sme2clpHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Smeengine.hpp>	// Pascal unit
#include <Sme2txt.hpp>	// Pascal unit
#include <Sme2cell.hpp>	// Pascal unit
#include <Exportds.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sme2clp
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TSMExportToClipboard;
class PASCALIMPLEMENTATION TSMExportToClipboard : public Sme2txt::TSMExportToText 
{
	typedef Sme2txt::TSMExportToText inherited;
	
private:
	AnsiString strClipboard;
	
protected:
	virtual void __fastcall AfterExport(void);
	
public:
	__fastcall virtual TSMExportToClipboard(Classes::TComponent* AOwner);
	virtual void __fastcall WriteString(const AnsiString s);
	virtual void __fastcall WriteFileBegin(void);
	virtual void __fastcall CreateFileStream(const AnsiString AFileName, int intCurFileNum);
	virtual void __fastcall CloseFileStream(void);
public:
	#pragma option push -w-inl
	/* TSMExportBaseComponent.Destroy */ inline __fastcall virtual ~TSMExportToClipboard(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Sme2clp */
using namespace Sme2clp;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Sme2clp
