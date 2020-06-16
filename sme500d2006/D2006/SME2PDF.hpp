// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Sme2pdf.pas' rev: 10.00

#ifndef Sme2pdfHPP
#define Sme2pdfHPP

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
#include <Exportds.hpp>	// Pascal unit
#include <Sme2cell.hpp>	// Pascal unit
#include <Smeengine.hpp>	// Pascal unit
#include <Zlib.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sme2pdf
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TPDFFilterDecode { fdASCIIHex, fdASCII85, fdLZW, fdDCT, fdFlate };
#pragma option pop

#pragma option push -b-
enum TPDFCompressionMethod { cmFastest, cmNormal, cmMaxCompress };
#pragma option pop

typedef AnsiString SME2PDF__1[5];

class DELPHICLASS TPDFFont;
class PASCALIMPLEMENTATION TPDFFont : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	AnsiString RefIndex;
	AnsiString BaseFont;
	AnsiString FontName;
	AnsiString Name;
	Graphics::TFontCharset CharSet;
	Graphics::TFontStyles Style;
	bool IsTrueType;
	bool IsEmbeddable;
	int Flags;
	void __fastcall FontParameters(Graphics::TFont* Font);
	AnsiString __fastcall GetFontName();
	bool __fastcall IsStandardFont(void);
	AnsiString __fastcall EncodingString();
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TPDFFont(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TPDFFont(void) { }
	#pragma option pop
	
};


class DELPHICLASS TPDFFonts;
class DELPHICLASS TSMExportToPDF;
class PASCALIMPLEMENTATION TPDFFonts : public Classes::TList 
{
	typedef Classes::TList inherited;
	
private:
	AnsiString __fastcall FontFamily(Graphics::TFont* Font, Graphics::TFontCharset Charset);
	Graphics::TFontCharset __fastcall GetFontCharset(Graphics::TFontCharset AValue);
	int __fastcall GetItemByFont(const AnsiString BaseFont, Graphics::TFontCharset Charset);
	int __fastcall FontFromTable(TSMExportToPDF* PDFEngine, Graphics::TFont* Font);
	void __fastcall WriteFontDifferences(TSMExportToPDF* PDFEngine, TPDFFont* fnt);
	
public:
	TPDFFont* __fastcall GetFont(int Index);
	virtual void __fastcall Clear(void);
	void __fastcall WriteFonts(TSMExportToPDF* PDFEngine);
public:
	#pragma option push -w-inl
	/* TList.Destroy */ inline __fastcall virtual ~TPDFFonts(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TPDFFonts(void) : Classes::TList() { }
	#pragma option pop
	
};


#pragma option push -b-
enum TSMEViewerPreference { evpHideToolBar, evpHideMenuBar, evpHideWindowUI, evpFitWindow, evpCenterWindow };
#pragma option pop

typedef Set<TSMEViewerPreference, evpHideToolBar, evpCenterWindow>  TSMEViewerPreferences;

#pragma option push -b-
enum TSMEPDFPageLayout { eplDefault, eplSinglePage, eplOneColumn, eplTwoColumnLeft, eplTwoColumnRight, eplTwoPageLeft, eplTwoPageRight };
#pragma option pop

class PASCALIMPLEMENTATION TSMExportToPDF : public Sme2cell::TSMExportToCellFile 
{
	typedef Sme2cell::TSMExportToCellFile inherited;
	
private:
	TPDFCompressionMethod FCompressionMethod;
	TSMEViewerPreferences FViewerPreferences;
	TSMEPDFPageLayout FPageLayout;
	Variant arrColWidths;
	int MaxKids;
	int FLastUsedRefIndex;
	Classes::TStringList* CrossRef;
	TPDFFonts* tblFont;
	Classes::TStrings* tblImage;
	Classes::TStrings* lstPages;
	int intTotalPages;
	int StreamSize;
	int FilePos;
	int intLastMergeCol;
	AnsiString BodyRefIndex;
	AnsiString ResRefIndex;
	AnsiString StreamRefIndex;
	AnsiString ProcRefIndex;
	int intCurY;
	int intCurRowHeight;
	int intCurYPos;
	int FOneSheetWidth;
	int PageWidth;
	int PageHeight;
	bool IsMemStream;
	bool IsDataStarted;
	TPDFFilterDecode FFontDecode;
	TPDFFilterDecode FImageDecode;
	int __fastcall GetRowTop(int ARow);
	
protected:
	Classes::TMemoryStream* MemStream;
	virtual bool __fastcall MergeIsSupported(void);
	AnsiString __fastcall DateToPDFString(System::TDateTime dt);
	int __fastcall Occurs(AnsiString Value, char ch);
	void __fastcall ReplaceChar(AnsiString &Source, char chOld, char chNew);
	AnsiString __fastcall PDFColor(Graphics::TColor Value, bool IsBackground);
	void __fastcall AddRef(AnsiString RefIndex);
	AnsiString __fastcall GetNextRefIndex();
	void __fastcall WriteCrossRef(void);
	
public:
	virtual void __fastcall WriteString(const AnsiString s);
	virtual void __fastcall WriteFileBegin(void);
	virtual void __fastcall WriteFileEnd(void);
	virtual void __fastcall WriteDimensions(int intRowCount, int intColCount);
	virtual void __fastcall WriteColWidth(int intCurColumn, int intColWidth);
	virtual void __fastcall WriteHeader(void);
	virtual void __fastcall WriteRowStart(void);
	virtual void __fastcall WriteRowEnd(void);
	virtual void __fastcall WriteData(Db::TField* fld, Smeengine::TCellType &CellType, int ARow, int ACol, AnsiString &AString, Classes::TAlignment &al, Graphics::TFont* font, Graphics::TColor &color);
	virtual void __fastcall WriteMergeData(Smeengine::TCellType &CellType, int ARow, int ACol, int AMergeCols, AnsiString &AString, Classes::TAlignment &al, Graphics::TFont* font, Graphics::TColor &color);
	void __fastcall WriteLine(int Left, int Top, int Width, int Height, Graphics::TColor ForeColor, Graphics::TColor BackColor);
	void __fastcall WriteBitmap(int Index, AnsiString ImageRefIndex, Graphics::TBitmap* bmp);
	virtual void __fastcall WritePageBegin(void);
	virtual void __fastcall WritePageEnd(void);
	__fastcall virtual TSMExportToPDF(Classes::TComponent* AOwner);
	__fastcall virtual ~TSMExportToPDF(void);
	virtual AnsiString __fastcall Extension();
	
__published:
	__property PageSetup ;
	__property TSMEViewerPreferences ViewerPreferences = {read=FViewerPreferences, write=FViewerPreferences, default=0};
	__property TSMEPDFPageLayout PageLayout = {read=FPageLayout, write=FPageLayout, default=0};
	__property TPDFCompressionMethod CompressionMethod = {read=FCompressionMethod, write=FCompressionMethod, default=1};
	__property TPDFFilterDecode FontDecode = {read=FFontDecode, write=FFontDecode, default=0};
	__property TPDFFilterDecode ImageDecode = {read=FImageDecode, write=FImageDecode, default=4};
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE AnsiString arrPDFFilter[5];

}	/* namespace Sme2pdf */
using namespace Sme2pdf;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Sme2pdf
