// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Sme2xlsx.pas' rev: 10.00

#ifndef Sme2xlsxHPP
#define Sme2xlsxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Smeengine.hpp>	// Pascal unit
#include <Sme2xls.hpp>	// Pascal unit
#include <Smezipfile.hpp>	// Pascal unit
#include <Sme2cell.hpp>	// Pascal unit
#include <Exportds.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sme2xlsx
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TTemporaryFileStream;
class PASCALIMPLEMENTATION TTemporaryFileStream : public Classes::THandleStream 
{
	typedef Classes::THandleStream inherited;
	
public:
	__fastcall TTemporaryFileStream(void);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TTemporaryFileStream(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSMExportToXLSX;
class PASCALIMPLEMENTATION TSMExportToXLSX : public Sme2xls::TSMExportToCustomXLS 
{
	typedef Sme2xls::TSMExportToCustomXLS inherited;
	
private:
	Smezipfile::TZipArchive* fsXLSX;
	AnsiString strDimension;
	AnsiString strColWidths;
	AnsiString strXMLRow;
	Classes::TStrings* lstXMLRows;
	int countSST;
	Classes::TStream* strmSST;
	Classes::TStream* strmXMLRows;
	void * __fastcall GetResourceAsPointer(char * ResName, char * ResType, /* out */ int &Size);
	AnsiString __fastcall GetResourceAsString(char * ResName, char * ResType);
	
protected:
	virtual void __fastcall InternalBeforeProcess(void);
	virtual void __fastcall InternalAfterProcess(void);
	virtual void __fastcall InternalFileCreate(const AnsiString AFileName);
	void __fastcall AddFileToArchive(const AnsiString FileName, unsigned FAttr, const AnsiString AValue);
	void __fastcall AddFileStreamToArchive(const AnsiString FileName, Classes::TStream* AStream);
	HIDESBASE void __fastcall WriteStyles(void);
	HIDESBASE void __fastcall WriteSST(void);
	void __fastcall WriteObjects(void);
	AnsiString __fastcall GetSpreadSheetRange(int ARow, int ACol);
	virtual Word __fastcall GetDefaultNumFormat(Smeengine::TCellType ACellType);
	AnsiString __fastcall GetXLSXColor(Graphics::TColor cl);
	int __fastcall Pixels2EMU(int AValue, bool IsX);
	virtual int __fastcall GetMaxFontCount(void);
	virtual int __fastcall GetMaxRowCount(void);
	virtual int __fastcall GetMaxColCount(void);
	void __fastcall PatchMacroInStream(Classes::TStream* AStream, const AnsiString AContent, const AnsiString AMacro, const AnsiString AValue);
	AnsiString __fastcall GetPageHeaderFooter();
	
public:
	__fastcall virtual TSMExportToXLSX(Classes::TComponent* AOwner);
	virtual AnsiString __fastcall Extension();
	virtual void __fastcall ApplyDefaultFont(Graphics::TFont* AFont, bool ReadOwner);
	virtual void __fastcall WriteFileBegin(void);
	virtual void __fastcall CloseFileStream(void);
	virtual void __fastcall WriteDataBegin(void);
	virtual void __fastcall WriteData(Db::TField* fld, Smeengine::TCellType &CellType, int ARow, int ACol, AnsiString &AString, Classes::TAlignment &al, Graphics::TFont* font, Graphics::TColor &color);
	virtual void __fastcall WriteRowStart(void);
	virtual void __fastcall WriteRowEnd(void);
	virtual void __fastcall WriteDimensions(int intRowCount, int intColCount);
	virtual void __fastcall WriteColWidth(int intCurColumn, int intColWidth);
public:
	#pragma option push -w-inl
	/* TSMExportToCustomXLS.Destroy */ inline __fastcall virtual ~TSMExportToXLSX(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Sme2xlsx */
using namespace Sme2xlsx;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Sme2xlsx
