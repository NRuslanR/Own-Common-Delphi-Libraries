// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Sme2xls.pas' rev: 10.00

#ifndef Sme2xlsHPP
#define Sme2xlsHPP

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
#include <Activex.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Sme2cell.hpp>	// Pascal unit
#include <Exportds.hpp>	// Pascal unit
#include <Smeengine.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sme2xls
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS ESMEMaxRowCountException;
class PASCALIMPLEMENTATION ESMEMaxRowCountException : public Sysutils::Exception 
{
	typedef Sysutils::Exception inherited;
	
public:
	#pragma option push -w-inl
	/* Exception.Create */ inline __fastcall ESMEMaxRowCountException(const AnsiString Msg) : Sysutils::Exception(Msg) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall ESMEMaxRowCountException(const AnsiString Msg, System::TVarRec const * Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall ESMEMaxRowCountException(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall ESMEMaxRowCountException(int Ident, System::TVarRec const * Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall ESMEMaxRowCountException(const AnsiString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall ESMEMaxRowCountException(const AnsiString Msg, System::TVarRec const * Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall ESMEMaxRowCountException(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall ESMEMaxRowCountException(System::PResStringRec ResStringRec, System::TVarRec const * Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~ESMEMaxRowCountException(void) { }
	#pragma option pop
	
};


class DELPHICLASS ESMEExcelException;
class PASCALIMPLEMENTATION ESMEExcelException : public Sysutils::Exception 
{
	typedef Sysutils::Exception inherited;
	
public:
	#pragma option push -w-inl
	/* Exception.Create */ inline __fastcall ESMEExcelException(const AnsiString Msg) : Sysutils::Exception(Msg) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall ESMEExcelException(const AnsiString Msg, System::TVarRec const * Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall ESMEExcelException(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall ESMEExcelException(int Ident, System::TVarRec const * Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall ESMEExcelException(const AnsiString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall ESMEExcelException(const AnsiString Msg, System::TVarRec const * Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall ESMEExcelException(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall ESMEExcelException(System::PResStringRec ResStringRec, System::TVarRec const * Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~ESMEExcelException(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TSMExportXLSVersion { exvExcel2, exvExcel3, exvExcel4, exvExcel5, exvExcel7, exvExcel8, exvExcel9, exvExcel12, exvExcel12Bin };
#pragma option pop

#pragma option push -b-
enum TXLSObjectKind { okUnknown, okHyperlink, okNote, okPicture, okImage, okGraphic, okMergedCells };
#pragma option pop

class DELPHICLASS TXLSObject;
class PASCALIMPLEMENTATION TXLSObject : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	TXLSObjectKind FObjectKind;
	Word FFromCol;
	Word FFromRow;
	Word FToCol;
	Word FToRow;
	
public:
	__property TXLSObjectKind ObjectKind = {read=FObjectKind, write=FObjectKind, default=0};
	__property Word FromCol = {read=FFromCol, write=FFromCol, nodefault};
	__property Word FromRow = {read=FFromRow, write=FFromRow, nodefault};
	__property Word ToCol = {read=FToCol, write=FToCol, nodefault};
	__property Word ToRow = {read=FToRow, write=FToRow, nodefault};
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TXLSObject(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TXLSObject(void) { }
	#pragma option pop
	
};


class DELPHICLASS TXLSPicture;
class PASCALIMPLEMENTATION TXLSPicture : public TXLSObject 
{
	typedef TXLSObject inherited;
	
private:
	Graphics::TPicture* FPicture;
	int FSize;
	
public:
	__fastcall virtual TXLSPicture(void);
	__fastcall virtual ~TXLSPicture(void);
	int __fastcall GetPictureSize(void);
	int __fastcall GetPictureType(void);
	AnsiString __fastcall GetPictureExt();
	void __fastcall WriteToStream(Classes::TStream* strm);
	AnsiString __fastcall GetAsString(bool ConvertToJpeg);
	__property Graphics::TPicture* Picture = {read=FPicture, write=FPicture};
	__property int Size = {read=FSize, write=FSize, nodefault};
};


class DELPHICLASS TXLSMergeCells;
class PASCALIMPLEMENTATION TXLSMergeCells : public TXLSObject 
{
	typedef TXLSObject inherited;
	
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TXLSMergeCells(void) : TXLSObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TXLSMergeCells(void) { }
	#pragma option pop
	
};


class DELPHICLASS TXLSFormat;
class PASCALIMPLEMENTATION TXLSFormat : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	Graphics::TColor FColor;
	int FFontIndex;
	int FNumFormat;
	Classes::TAlignment FAlignment;
	bool FWrapText;
	
public:
	__property Graphics::TColor Color = {read=FColor, write=FColor, default=0};
	__property int FontIndex = {read=FFontIndex, write=FFontIndex, default=0};
	__property int NumFormat = {read=FNumFormat, write=FNumFormat, default=-1};
	__property Classes::TAlignment Alignment = {read=FAlignment, write=FAlignment, default=0};
	__property bool WrapText = {read=FWrapText, write=FWrapText, default=0};
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TXLSFormat(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TXLSFormat(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSMEXLSSST;
class DELPHICLASS TSMExportToCustomXLS;
class PASCALIMPLEMENTATION TSMExportToCustomXLS : public Sme2cell::TSMExportToCellFile 
{
	typedef Sme2cell::TSMExportToCellFile inherited;
	
private:
	Classes::TMemoryStream* FTempFontStream;
	TSMExportXLSVersion FVersion;
	int FSheetIndex;
	AnsiString FUserName;
	Classes::TStrings* FPageHeader;
	Classes::TStrings* FPageFooter;
	Classes::TStrings* __fastcall GetPageHeader(void);
	void __fastcall SetPageHeader(Classes::TStrings* Value);
	Classes::TStrings* __fastcall GetPageFooter(void);
	void __fastcall SetPageFooter(Classes::TStrings* Value);
	int __fastcall GetFontFromTable(const Graphics::TFont* Font);
	Classes::TMemoryStream* __fastcall GetFontStream(void);
	int __fastcall GetXLSIndexByColor(Graphics::TColor color);
	
protected:
	Classes::TList* lstFonts;
	Classes::TList* lstFormats;
	Classes::TList* lstObjects;
	TSMEXLSSST* lstSST;
	int __fastcall GetXF(const Graphics::TFont* Font, Graphics::TColor AColor, int ANumFormat, Classes::TAlignment AAlignment, bool AWrapText);
	void __fastcall WriteFormats(void);
	void __fastcall WriteStyles(void);
	void __fastcall WriteSST(void);
	virtual void __fastcall InternalBeforeProcess(void);
	virtual void __fastcall InternalAfterProcess(void);
	virtual void __fastcall WriteBuffer(Sysutils::PByteArray Buffer, int ASize);
	virtual void __fastcall WriteStringValue(const AnsiString AString, bool IncludeLength);
	int __fastcall GetMaxBuffSize(void);
	AnsiString __fastcall ApplyDataFormat(const AnsiString AFormat, bool ToDirect);
	virtual Word __fastcall GetDefaultNumFormat(Smeengine::TCellType ACellType);
	virtual int __fastcall GetMaxFontCount(void);
	virtual int __fastcall GetMaxRowCount(void);
	virtual int __fastcall GetMaxColCount(void);
	bool __fastcall AddPicture(Db::TField* AField, Smeengine::TCellType ACellType, int ARow, int ACol, AnsiString AContent);
	
public:
	virtual void __fastcall ApplyDefaultFont(Graphics::TFont* AFont, bool ReadOwner);
	virtual void __fastcall WriteRecordHeader(Classes::TStream* Stream, __int64 RecType, __int64 Size);
	virtual void __fastcall WriteFontStream(void);
	void __fastcall WriteMSOHeader(Word FBT, Word Version, Word Instance, int Size);
	void __fastcall Write_MSO_DGG(int ContainerSize);
	void __fastcall Write_MSO_BStoreContainer(int ContainerSize);
	virtual void __fastcall WriteData(Db::TField* fld, Smeengine::TCellType &CellType, int ARow, int ACol, AnsiString &AString, Classes::TAlignment &al, Graphics::TFont* font, Graphics::TColor &color);
	virtual void __fastcall WriteFont(Graphics::TFont* fn);
	virtual void __fastcall WriteRowStart(void);
	virtual void __fastcall WriteFormat(int Index, AnsiString Format, bool IsFormat);
	virtual void __fastcall WriteXF(TXLSFormat* fmt, int AIndex);
	virtual void __fastcall WriteFileEnd(void);
	void __fastcall WriteFontFormats(void);
	void __fastcall WriteXF5s(void);
	void __fastcall WriteStyle(const AnsiString Style);
	__fastcall virtual TSMExportToCustomXLS(Classes::TComponent* AOwner);
	__fastcall virtual ~TSMExportToCustomXLS(void);
	virtual AnsiString __fastcall Extension();
	__property Classes::TMemoryStream* TempFontStream = {read=GetFontStream};
	__property TSMExportXLSVersion Version = {read=FVersion, write=FVersion, default=3};
	
__published:
	__property ExportStyle ;
	__property AnsiString UserName = {read=FUserName, write=FUserName};
	__property Classes::TStrings* PageHeader = {read=GetPageHeader, write=SetPageHeader};
	__property Classes::TStrings* PageFooter = {read=GetPageFooter, write=SetPageFooter};
};


class PASCALIMPLEMENTATION TSMEXLSSST : public Classes::TStringList 
{
	typedef Classes::TStringList inherited;
	
private:
	TSMExportToCustomXLS* FEngine;
	Classes::TList* BlockSizes;
	__int64 CurPosInSSTBlock;
	
public:
	__fastcall virtual TSMEXLSSST(void);
	__fastcall virtual ~TSMEXLSSST(void);
	int __fastcall AddString(AnsiString Value);
	virtual void __fastcall Clear(void);
};


class DELPHICLASS TSMExportToXLS;
class PASCALIMPLEMENTATION TSMExportToXLS : public TSMExportToCustomXLS 
{
	typedef TSMExportToCustomXLS inherited;
	
protected:
	virtual void __fastcall WriteBuffer(Sysutils::PByteArray Buffer, int ASize);
	virtual void __fastcall WriteStringValue(const AnsiString AString, bool IncludeLength);
	
public:
	virtual void __fastcall WriteRecordHeader(Classes::TStream* Stream, __int64 RecType, __int64 Size);
	virtual void __fastcall WriteFontStream(void);
	virtual void __fastcall WriteFileBegin(void);
	virtual void __fastcall WriteDimensions(int intRowCount, int intColCount);
	virtual void __fastcall WriteColWidth(int intCurColumn, int intColWidth);
	virtual void __fastcall WriteFormat(int Index, AnsiString Format, bool IsFormat);
public:
	#pragma option push -w-inl
	/* TSMExportToCustomXLS.Create */ inline __fastcall virtual TSMExportToXLS(Classes::TComponent* AOwner) : TSMExportToCustomXLS(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TSMExportToCustomXLS.Destroy */ inline __fastcall virtual ~TSMExportToXLS(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSMExportToXLSWorkBook;
class PASCALIMPLEMENTATION TSMExportToXLSWorkBook : public TSMExportToCustomXLS 
{
	typedef TSMExportToCustomXLS inherited;
	
private:
	int APos;
	
protected:
	Byte *pBuf;
	_di_IStream OStream;
	virtual Word __fastcall GetDefaultNumFormat(Smeengine::TCellType ACellType);
	virtual void __fastcall WriteBuffer(Sysutils::PByteArray Buffer, int ASize);
	virtual void __fastcall WriteStringValue(const AnsiString AString, bool IncludeLength);
	
public:
	virtual void __fastcall WriteRecordHeader(Classes::TStream* Stream, __int64 RecType, __int64 Size);
	virtual void __fastcall WriteFontStream(void);
	virtual void __fastcall WriteDimensions(int intRowCount, int intColCount);
	virtual void __fastcall WriteFormat(int Index, AnsiString Format, bool IsFormat);
	void __fastcall SaveToWorkbook(void);
public:
	#pragma option push -w-inl
	/* TSMExportToCustomXLS.Create */ inline __fastcall virtual TSMExportToXLSWorkBook(Classes::TComponent* AOwner) : TSMExportToCustomXLS(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TSMExportToCustomXLS.Destroy */ inline __fastcall virtual ~TSMExportToXLSWorkBook(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Sme2xls */
using namespace Sme2xls;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Sme2xls
