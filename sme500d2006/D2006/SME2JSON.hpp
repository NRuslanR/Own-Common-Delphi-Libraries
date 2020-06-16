// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Sme2json.pas' rev: 10.00

#ifndef Sme2jsonHPP
#define Sme2jsonHPP

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

namespace Sme2json
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TSMEJSONForm { ejfStandard, ejfSpaceFormatted, ejfRJSON };
#pragma option pop

class DELPHICLASS TSMExportToJSON;
class PASCALIMPLEMENTATION TSMExportToJSON : public Sme2cell::TSMExportToCellFile 
{
	typedef Sme2cell::TSMExportToCellFile inherited;
	
private:
	char FQuoteTerm;
	TSMEJSONForm FJSONForm;
	Sme2cell::TSMEBLOBEncoding FBLOBEncoding;
	
protected:
	bool FIsFirstRowExport;
	virtual bool __fastcall MergeIsSupported(void);
	virtual bool __fastcall TitleIsSupported(void);
	virtual AnsiString __fastcall GetFieldStr(Db::TField* Field);
	
public:
	virtual void __fastcall WriteFileBegin(void);
	virtual void __fastcall WriteFileEnd(void);
	virtual void __fastcall WriteRowStart(void);
	virtual void __fastcall WriteRowEnd(void);
	virtual void __fastcall WriteData(Db::TField* fld, Smeengine::TCellType &CellType, int ARow, int ACol, AnsiString &AString, Classes::TAlignment &al, Graphics::TFont* font, Graphics::TColor &color);
	__fastcall virtual TSMExportToJSON(Classes::TComponent* AOwner);
	virtual AnsiString __fastcall Extension();
	
__published:
	__property char QuoteTerm = {read=FQuoteTerm, write=FQuoteTerm, default=34};
	__property TSMEJSONForm JSONForm = {read=FJSONForm, write=FJSONForm, default=0};
	__property Sme2cell::TSMEBLOBEncoding BLOBEncoding = {read=FBLOBEncoding, write=FBLOBEncoding, default=1};
public:
	#pragma option push -w-inl
	/* TSMExportBaseComponent.Destroy */ inline __fastcall virtual ~TSMExportToJSON(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Sme2json */
using namespace Sme2json;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Sme2json
