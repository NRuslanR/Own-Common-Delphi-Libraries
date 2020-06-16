// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Sme2wq.pas' rev: 10.00

#ifndef Sme2wqHPP
#define Sme2wqHPP

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
#include <Sme2cell.hpp>	// Pascal unit
#include <Exportds.hpp>	// Pascal unit
#include <Smeengine.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sme2wq
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TSMExportToQuattro;
class PASCALIMPLEMENTATION TSMExportToQuattro : public Sme2cell::TSMExportToCellFile 
{
	typedef Sme2cell::TSMExportToCellFile inherited;
	
private:
	void __fastcall WriteRecordHeader(int RecType, int Size);
	
public:
	virtual void __fastcall WriteFileBegin(void);
	virtual void __fastcall WriteFileEnd(void);
	virtual void __fastcall WriteDimensions(int intRowCount, int intColCount);
	virtual void __fastcall WriteColWidth(int intCurColumn, int intColWidth);
	virtual void __fastcall WriteData(Db::TField* fld, Smeengine::TCellType &CellType, int ARow, int ACol, AnsiString &AString, Classes::TAlignment &al, Graphics::TFont* font, Graphics::TColor &color);
	__fastcall virtual TSMExportToQuattro(Classes::TComponent* AOwner);
	virtual AnsiString __fastcall Extension();
public:
	#pragma option push -w-inl
	/* TSMExportBaseComponent.Destroy */ inline __fastcall virtual ~TSMExportToQuattro(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Sme2wq */
using namespace Sme2wq;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Sme2wq
