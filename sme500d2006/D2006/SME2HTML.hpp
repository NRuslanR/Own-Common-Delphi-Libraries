// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Sme2html.pas' rev: 10.00

#ifndef Sme2htmlHPP
#define Sme2htmlHPP

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

namespace Sme2html
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TSMEGetExtHTMLTableParamsEvent)(System::TObject* Sender, AnsiString &ExtTableText);

typedef void __fastcall (__closure *TSMEGetExtHTMLRowParamsEvent)(System::TObject* Sender, AnsiString &ExtRowText);

typedef void __fastcall (__closure *TSMEGetExtHTMLCellParamsEvent)(System::TObject* Sender, Smeengine::TSMEColumn* Column, AnsiString &TDTagName, AnsiString &ExtTDText);

class DELPHICLASS TSMExportToHTML;
class PASCALIMPLEMENTATION TSMExportToHTML : public Sme2cell::TSMExportToCellBufferedFile 
{
	typedef Sme2cell::TSMExportToCellBufferedFile inherited;
	
private:
	bool FEmbeddedImages;
	bool IsCustomHTMLTemplate;
	Classes::TStrings* FHTMLPattern;
	int intCurLineHTMLPattern;
	int intCurColumn;
	Variant arrWidthByColumns;
	bool FHeaderFooterWithHTML;
	TSMEGetExtHTMLCellParamsEvent FOnGetExtHTMLCellParamsEvent;
	TSMEGetExtHTMLRowParamsEvent FOnGetExtHTMLRowParamsEvent;
	TSMEGetExtHTMLTableParamsEvent FOnGetExtHTMLTableParamsEvent;
	void __fastcall SetHTMLPattern(Classes::TStrings* Value);
	AnsiString __fastcall GetHTMLColor(Graphics::TColor cl, bool IsBackColor);
	AnsiString __fastcall GetHTMLFontSize(int Size);
	AnsiString __fastcall GetHTMLTextWithFont(AnsiString s, Graphics::TFont* fn);
	
protected:
	int intCurPicFile;
	AnsiString strDefTDTag;
	int FLastColWritten;
	bool IsTBodyTag;
	virtual AnsiString __fastcall GetFieldStr(Db::TField* Field);
	AnsiString __fastcall GetDefaultCodePage();
	AnsiString __fastcall GetTableStart();
	AnsiString __fastcall GetTableFinish();
	
public:
	virtual void __fastcall WriteFileBegin(void);
	virtual void __fastcall WriteFileEnd(void);
	virtual void __fastcall WriteDimensions(int intRowCount, int intColCount);
	virtual void __fastcall WriteColWidth(int intCurColumn, int intColWidth);
	virtual void __fastcall WriteDataBegin(void);
	virtual void __fastcall WriteDataEnd(void);
	virtual void __fastcall WriteRowStart(void);
	virtual void __fastcall WriteRowEnd(void);
	virtual void __fastcall WriteData(Db::TField* fld, Smeengine::TCellType &CellType, int ARow, int ACol, AnsiString &AString, Classes::TAlignment &al, Graphics::TFont* font, Graphics::TColor &color);
	virtual void __fastcall WriteMergeData(Smeengine::TCellType &CellType, int ARow, int ACol, int AMergeCols, AnsiString &AString, Classes::TAlignment &al, Graphics::TFont* font, Graphics::TColor &color);
	__fastcall virtual TSMExportToHTML(Classes::TComponent* AOwner);
	__fastcall virtual ~TSMExportToHTML(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual AnsiString __fastcall Extension();
	
__published:
	__property bool EmbeddedImages = {read=FEmbeddedImages, write=FEmbeddedImages, default=0};
	__property bool HeaderFooterWithHTML = {read=FHeaderFooterWithHTML, write=FHeaderFooterWithHTML, nodefault};
	__property Classes::TStrings* HTMLPattern = {read=FHTMLPattern, write=SetHTMLPattern};
	__property TSMEGetExtHTMLCellParamsEvent OnGetExtHTMLCellParamsEvent = {read=FOnGetExtHTMLCellParamsEvent, write=FOnGetExtHTMLCellParamsEvent};
	__property TSMEGetExtHTMLTableParamsEvent OnGetExtHTMLTableParamsEvent = {read=FOnGetExtHTMLTableParamsEvent, write=FOnGetExtHTMLTableParamsEvent};
	__property TSMEGetExtHTMLRowParamsEvent OnGetExtHTMLRowParamsEvent = {read=FOnGetExtHTMLRowParamsEvent, write=FOnGetExtHTMLRowParamsEvent};
	__property ActionAfterExport  = {default=0};
	__property FileName ;
	__property AddTitle  = {default=0};
	__property CharacterSet ;
	__property ExportStyle ;
	__property Header ;
	__property Footer ;
	__property OnGetCellParams ;
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Sme2html */
using namespace Sme2html;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Sme2html
