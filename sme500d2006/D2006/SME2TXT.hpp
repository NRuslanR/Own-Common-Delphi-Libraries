// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Sme2txt.pas' rev: 10.00

#ifndef Sme2txtHPP
#define Sme2txtHPP

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
#include <Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sme2txt
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TSMETextQualifying { tqAny, tqStringOnly, tqNoNumber };
#pragma option pop

class DELPHICLASS TSMExportToText;
class PASCALIMPLEMENTATION TSMExportToText : public Sme2cell::TSMExportToCellBufferedFile 
{
	typedef Sme2cell::TSMExportToCellBufferedFile inherited;
	
private:
	Variant arrWidthByColumns;
	TSMETextQualifying FTextQualifying;
	bool FAddCtrlZ;
	
protected:
	virtual int __fastcall MappingVersion(void);
	virtual bool __fastcall MergeIsSupported(void);
	virtual AnsiString __fastcall GetFieldStr(Db::TField* Field);
	
public:
	virtual void __fastcall WriteDimensions(int intRowCount, int intColCount);
	virtual void __fastcall WriteColWidth(int intCurColumn, int intColWidth);
	virtual void __fastcall WriteFileBegin(void);
	virtual void __fastcall WriteDataBegin(void);
	virtual void __fastcall WriteRowEnd(void);
	virtual void __fastcall WriteData(Db::TField* fld, Smeengine::TCellType &CellType, int ARow, int ACol, AnsiString &AString, Classes::TAlignment &al, Graphics::TFont* font, Graphics::TColor &color);
	virtual void __fastcall WriteFooter(void);
	__fastcall virtual TSMExportToText(Classes::TComponent* AOwner);
	virtual AnsiString __fastcall Extension();
	void __fastcall GenerateOraControlFile(const AnsiString AFileName);
	
__published:
	__property TSMETextQualifying TextQualifying = {read=FTextQualifying, write=FTextQualifying, nodefault};
	__property bool AddCtrlZ = {read=FAddCtrlZ, write=FAddCtrlZ, default=0};
	__property TextQualifier ;
	__property Separator ;
	__property RecordSeparator ;
	__property Fixed ;
	__property ActionAfterExport  = {default=0};
	__property AddTitle  = {default=0};
	__property CharacterSet ;
	__property Header ;
	__property Footer ;
	__property OnGetCellParams ;
public:
	#pragma option push -w-inl
	/* TSMExportBaseComponent.Destroy */ inline __fastcall virtual ~TSMExportToText(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TSMETextQualifying defTextQualifying;

}	/* namespace Sme2txt */
using namespace Sme2txt;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Sme2txt
